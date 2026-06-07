# Guide: Migration Convention

## File Structure

```
supabase/
└── migrations/
    ├── 000_create_schema_migrations.sql    # Bootstrap (self-tracking)
    ├── 001_create_[table_name].sql         # First table
    ├── 002_create_[table_name].sql         # Second table
    ├── 003_add_[column]_to_[table].sql     # Column addition
    ├── 004_backfill_[description].sql      # Data migration
    ├── 005_add_[feature].sql               # New feature
    └── ...
```

## Naming Convention

```
[NNN]_[verb]_[description].sql
```

| Part | Rule | Example |
|------|------|---------|
| `NNN` | Zero-padded 3-digit sequence | `001`, `012`, `100` |
| `verb` | Action being taken | `create`, `add`, `remove`, `alter`, `backfill` |
| `description` | What's being changed | `create_expenses_table`, `add_receipt_url` |

### Common Verbs

| Verb | Usage | Example |
|------|-------|---------|
| `create` | New table or major object | `001_create_expenses.sql` |
| `add` | New column, index, or policy | `003_add_project_id_fk.sql` |
| `remove` | Drop column or object | `010_remove_legacy_field.sql` |
| `alter` | Modify existing column | `008_alter_amount_precision.sql` |
| `backfill` | Data migration | `004_backfill_project_ids.sql` |

## Bootstrap Migration (000)

Every project starts with the schema_migrations tracking table:

```sql
-- 000_create_schema_migrations.sql
CREATE TABLE IF NOT EXISTS public.schema_migrations (
    version TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    applied_at TIMESTAMPTZ DEFAULT NOW()
);

-- Self-register
INSERT INTO public.schema_migrations (version, name)
VALUES ('000', 'create_schema_migrations')
ON CONFLICT (version) DO NOTHING;
```

## Idempotent Template

Every migration MUST be idempotent (safe to run multiple times):

```sql
-- NNN_description.sql
-- Description: [What this migration does]
-- Author: [name]
-- Date: [YYYY-MM-DD]

-- Migration
[SQL statements using IF NOT EXISTS / IF EXISTS guards]

-- Register migration
INSERT INTO public.schema_migrations (version, name)
VALUES ('NNN', 'description')
ON CONFLICT (version) DO NOTHING;
```

## Why Idempotent?

| Scenario | Non-Idempotent | Idempotent |
|----------|---------------|------------|
| Run migration twice | ❌ ERROR: already exists | ✅ No-op, no error |
| Deploy to already-migrated DB | ❌ Fails, blocks deploy | ✅ Skips, continues |
| CI runs all migrations | ❌ Fails on existing schema | ✅ Applies only new ones |
| Debugging with re-runs | ❌ Must drop and recreate | ✅ Safe to retry |
| Team member has partial state | ❌ Manual intervention | ✅ Self-healing |

## Common Migration Types

### Create Table

```sql
-- 001_create_expenses.sql
CREATE TABLE IF NOT EXISTS public.expenses (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    amount INTEGER NOT NULL,  -- cents
    category TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE public.expenses ENABLE ROW LEVEL SECURITY;

CREATE POLICY IF NOT EXISTS "Users can view own expenses"
    ON public.expenses FOR SELECT
    USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can insert own expenses"
    ON public.expenses FOR INSERT
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can update own expenses"
    ON public.expenses FOR UPDATE
    USING (auth.uid() = user_id);

CREATE POLICY IF NOT EXISTS "Users can delete own expenses"
    ON public.expenses FOR DELETE
    USING (auth.uid() = user_id);

-- Register
INSERT INTO public.schema_migrations (version, name)
VALUES ('001', 'create_expenses')
ON CONFLICT (version) DO NOTHING;
```

### Add Column

```sql
-- 005_add_logged_date_notes.sql
ALTER TABLE public.expenses
    ADD COLUMN IF NOT EXISTS logged_date DATE,
    ADD COLUMN IF NOT EXISTS notes TEXT;

-- Register
INSERT INTO public.schema_migrations (version, name)
VALUES ('005', 'add_logged_date_notes')
ON CONFLICT (version) DO NOTHING;
```

### Add Index

```sql
-- 006_add_expense_date_index.sql
CREATE INDEX IF NOT EXISTS idx_expenses_logged_date
    ON public.expenses (logged_date);

CREATE INDEX IF NOT EXISTS idx_expenses_user_date
    ON public.expenses (user_id, logged_date);

-- Register
INSERT INTO public.schema_migrations (version, name)
VALUES ('006', 'add_expense_date_index')
ON CONFLICT (version) DO NOTHING;
```

### Storage + RLS

```sql
-- 007_add_receipts_storage_rls.sql

-- Create storage bucket (Supabase-specific)
INSERT INTO storage.buckets (id, name, public)
VALUES ('receipts', 'receipts', false)
ON CONFLICT (id) DO NOTHING;

-- Storage policies
CREATE POLICY IF NOT EXISTS "Users can upload own receipts"
    ON storage.objects FOR INSERT
    WITH CHECK (
        bucket_id = 'receipts' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );

CREATE POLICY IF NOT EXISTS "Users can view own receipts"
    ON storage.objects FOR SELECT
    USING (
        bucket_id = 'receipts' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );

CREATE POLICY IF NOT EXISTS "Users can delete own receipts"
    ON storage.objects FOR DELETE
    USING (
        bucket_id = 'receipts' AND
        auth.uid()::text = (storage.foldername(name))[1]
    );

-- Register
INSERT INTO public.schema_migrations (version, name)
VALUES ('007', 'add_receipts_storage_rls')
ON CONFLICT (version) DO NOTHING;
```

### RPC Function

```sql
-- 009_add_expense_summary_rpc.sql

CREATE OR REPLACE FUNCTION public.get_expense_summary(
    p_user_id UUID,
    p_start_date DATE DEFAULT NULL,
    p_end_date DATE DEFAULT NULL
)
RETURNS TABLE (
    total_amount BIGINT,
    expense_count BIGINT,
    avg_amount BIGINT,
    top_category TEXT
)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    RETURN QUERY
    SELECT
        COALESCE(SUM(e.amount), 0)::BIGINT AS total_amount,
        COUNT(*)::BIGINT AS expense_count,
        COALESCE(AVG(e.amount), 0)::BIGINT AS avg_amount,
        (SELECT category FROM public.expenses
         WHERE user_id = p_user_id
         GROUP BY category ORDER BY SUM(amount) DESC LIMIT 1
        ) AS top_category
    FROM public.expenses e
    WHERE e.user_id = p_user_id
        AND (p_start_date IS NULL OR e.logged_date >= p_start_date)
        AND (p_end_date IS NULL OR e.logged_date <= p_end_date);
END;
$$;

-- Register
INSERT INTO public.schema_migrations (version, name)
VALUES ('009', 'add_expense_summary_rpc')
ON CONFLICT (version) DO NOTHING;
```

## Execution Rules

### Development

```bash
# Run all migrations against local Supabase
for f in supabase/migrations/*.sql; do
  psql "$LOCAL_DB_URL" -f "$f"
done
```

### Production

```bash
# Run migrations one-by-one, checking status between each
psql "$PROD_DB_URL" -f supabase/migrations/005_add_logged_date_notes.sql

# Verify
psql "$PROD_DB_URL" -c "SELECT * FROM schema_migrations ORDER BY version;"
```

### Rules

| Rule | Rationale |
|------|-----------|
| Never edit a deployed migration | Other environments depend on it |
| Always add new migrations at the end | Sequence must be deterministic |
| Always use `IF NOT EXISTS` / `IF EXISTS` | Idempotency |
| Always include self-registration | Tracking |
| Never use `DROP TABLE` without backup | Data safety |
| Test on staging before production | Catch errors early |
| One concern per migration | Easy to debug and revert |

## Checking Status

```sql
-- See which migrations have been applied
SELECT version, name, applied_at
FROM public.schema_migrations
ORDER BY version;
```

Expected output:
```
 version |           name            |         applied_at
---------+---------------------------+----------------------------
 000     | create_schema_migrations  | 2025-01-10 10:00:00+00
 001     | create_expenses           | 2025-01-10 10:01:00+00
 002     | create_projects_table     | 2025-01-12 14:30:00+00
 003     | add_project_id_fk         | 2025-01-12 14:31:00+00
 ...
```

## Real-World Example: Nidhi Seermai

8 migrations over 4 sprints:

| # | Name | Sprint | What |
|---|------|--------|------|
| 000 | `create_schema_migrations` | 0 | Bootstrap tracking table |
| 001 | `create_project_expenses` | 1 | Main expenses table + RLS |
| 002 | `create_projects_table` | 2 | Projects for categorization |
| 003 | `add_project_id_fk` | 2 | Link expenses → projects |
| 004 | `backfill_project_ids` | 2 | Assign existing expenses to default project |
| 005 | `add_logged_date_notes` | 3 | Calendar + notes support |
| 006 | `add_receipt_url` | 3 | Receipt upload column |
| 007 | `add_receipts_storage_rls` | 3 | Storage bucket + policies |
| 008 | `add_tags_column` | 3 | Tag-based categorization |

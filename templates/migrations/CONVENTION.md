# Migration Convention

## File Naming

```
[NNN]_[verb]_[description].sql
```

- `NNN` — Zero-padded 3-digit sequence number
- `verb` — Action: `create`, `add`, `remove`, `alter`, `backfill`
- `description` — What's being changed (snake_case)

**Examples:**
- `001_create_expenses.sql`
- `002_create_projects_table.sql`
- `003_add_project_id_fk.sql`
- `004_backfill_project_ids.sql`

## Idempotent Template

Every migration follows this pattern:

```sql
-- NNN_description.sql
-- Description: [What this migration does]
-- Author: [name]
-- Date: [YYYY-MM-DD]

-- Migration body
[Use IF NOT EXISTS / IF EXISTS guards]

-- Self-register
INSERT INTO public.schema_migrations (version, name)
VALUES ('NNN', 'description')
ON CONFLICT (version) DO NOTHING;
```

## Rules

| # | Rule | Rationale |
|---|------|-----------|
| 1 | Every migration MUST be idempotent | Safe to re-run |
| 2 | Every migration MUST self-register | Tracking |
| 3 | Never edit a deployed migration | Other envs depend on it |
| 4 | One concern per migration file | Easy to debug/revert |
| 5 | Always use `IF NOT EXISTS` / `IF EXISTS` | Prevent errors on re-run |
| 6 | Never `DROP TABLE` without a backup plan | Data safety |
| 7 | Test on staging before production | Catch errors early |

## Quick Reference

```bash
# Run all migrations (development)
for f in supabase/migrations/*.sql; do psql "$DB_URL" -f "$f"; done

# Check applied migrations
psql "$DB_URL" -c "SELECT * FROM schema_migrations ORDER BY version;"

# Run single migration (production)
psql "$PROD_DB_URL" -f supabase/migrations/NNN_description.sql
```

## Full Guide

See [guides/08-migration-convention.md](../../guides/08-migration-convention.md) for:
- Detailed examples (tables, columns, indexes, RLS, RPC functions)
- Production execution procedures
- Rollback strategies

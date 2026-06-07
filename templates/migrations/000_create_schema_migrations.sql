-- 000_create_schema_migrations.sql
-- Bootstrap migration: creates the tracking table used by all subsequent migrations.
-- This migration is always safe to re-run (idempotent).

CREATE TABLE IF NOT EXISTS public.schema_migrations (
    version TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    applied_at TIMESTAMPTZ DEFAULT NOW()
);

-- Self-register this bootstrap migration
INSERT INTO public.schema_migrations (version, name)
VALUES ('000', 'create_schema_migrations')
ON CONFLICT (version) DO NOTHING;

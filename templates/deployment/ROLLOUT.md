# Rollout Procedure

## Environments

| Environment | URL | Database | Branch |
|-------------|-----|----------|--------|
| Development | `localhost:{{PORT}}` | Local / Supabase dev | Any |
| Staging | {{STAGING_URL}} | Staging database | `main` (auto) |
| Production | {{PRODUCTION_URL}} | Production database | `main` (manual) |

## Rollout Procedure

### 1. Pre-Deploy Verification

- [ ] All CI checks passing on `main`
- [ ] Coverage meets threshold (≥ {{COVERAGE_TARGET}}%)
- [ ] Staging deployment verified and smoke-tested
- [ ] No open critical/blocker issues

### 2. Apply Migrations

```bash
# List pending migrations
psql $DATABASE_URL -c "SELECT version FROM schema_migrations ORDER BY version;"

# Apply each new migration
psql $DATABASE_URL -f supabase/migrations/NNN_description.sql

# Verify
psql $DATABASE_URL -c "SELECT * FROM schema_migrations ORDER BY version;"
```

- [ ] All new migrations applied successfully
- [ ] No errors in migration output
- [ ] Schema verified correct

### 3. Environment Variables

- [ ] All required variables set in production environment
- [ ] No staging/dev values present
- [ ] Secrets are fresh (not expired)
- [ ] Feature flags set correctly

### 4. Deploy

- [ ] Trigger production deployment
- [ ] Monitor build output for errors
- [ ] Verify application loads at production URL
- [ ] Check deployment logs clean

### 5. Post-Deploy Verification

- [ ] Application accessible
- [ ] Login flow works
- [ ] Create operation works
- [ ] Read/list operations work
- [ ] No elevated error rates (monitor 30 min)
- [ ] Performance acceptable

## Rollback Instructions

### Code Rollback (No DB Changes)

```bash
# Revert the problematic commit
git revert <commit-sha> --no-edit
git push origin main
# Auto-deploys to staging; manual approve for production
```

### Code + Database Rollback

```bash
# 1. Revert code
git revert <commit-sha> --no-edit
git push origin main

# 2. Rollback migration (if safe)
psql $DATABASE_URL -c "ALTER TABLE public.{{TABLE}} DROP COLUMN IF EXISTS {{COLUMN}};"
psql $DATABASE_URL -c "DELETE FROM schema_migrations WHERE version = 'NNN';"
```

### Full Restore (Emergency)

```bash
# Use database provider's point-in-time recovery
# Supabase: Dashboard → Database → Backups → Restore
# Record the restore point timestamp
```

## Migration Execution Checklist

| # | Migration | Applied | Verified | Rollback Plan |
|---|-----------|---------|----------|---------------|
| {{NNN}} | {{description}} | ☐ | ☐ | {{rollback_plan}} |
| {{NNN}} | {{description}} | ☐ | ☐ | {{rollback_plan}} |
| {{NNN}} | {{description}} | ☐ | ☐ | {{rollback_plan}} |

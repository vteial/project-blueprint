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

## Preview access for headless QA agents (Deployment Protection bypass)

> Only relevant if your host gates preview deployments behind an SSO/password wall
> (e.g. Vercel **Deployment Protection**) **and** an automated agent must reach the
> preview to run smoke/E2E tests. Humans click through the SSO wall; headless agents
> cannot — so give them a bypass token, never your SSO credentials.

**Verification surface = the PR preview, not shared staging.** When `main` deploys to
staging, a release branch's changes (incl. the version bump) are **not** on staging until
merged — so the pre-merge gate must run against the **PR's preview deployment** (built from
the branch head), which does show the new version. Staging becomes a post-merge confirmation,
not the gate.

**The durable bypass (Vercel — adapt for other hosts):**
1. Enable **Settings → Deployment Protection → Protection Bypass for Automation**. This mints
   a secret that bypasses the wall via a query param/header — **protection stays ON for
   humans**.
2. Store the secret in a **local, gitignored `.env`** (`DEPLOY_BYPASS_SECRET` /
   `VERCEL_AUTOMATION_BYPASS_SECRET`). **Never commit it.**
3. Hand the QA/E2E agent the preview URL with the bypass params appended:

   ```
   <preview-url>/?x-vercel-protection-bypass=$DEPLOY_BYPASS_SECRET&x-vercel-set-bypass-cookie=true
   ```

   `x-vercel-set-bypass-cookie=true` sets a cookie on first load so subsequent in-app
   navigation stays authenticated. (Header form: `x-vercel-protection-bypass: <secret>`.)
4. Rotate the secret if it ever leaks; regenerate from the same settings page.

- [ ] Preview-protection bypass configured (secret in local `.env`, gitignored)
- [ ] QA/E2E agent given the bypassed **PR-preview** URL (not staging, not SSO creds)

> Ref: Vercel — [Automated access to protected deployments](https://vercel.com/docs/deployment-protection/automated-agent-access).

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

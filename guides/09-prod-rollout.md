# Guide: Production Rollout

## Three Environments

| Environment | Purpose | Data | URL | Auto-Deploy |
|-------------|---------|------|-----|-------------|
| Development | Local coding + testing | Seed/mock data | `localhost:{{PORT}}` | — |
| Staging | Pre-production validation | Copy of prod schema | {{STAGING_URL}} | On merge to main |
| Production | Real users | Real data | {{PRODUCTION_URL}} | Manual approval |

## Data Isolation

| Rule | Why |
|------|-----|
| Never use production data in development | Privacy, compliance |
| Never deploy to production without staging first | Catch issues early |
| Never share database credentials across environments | Security |
| Staging schema mirrors production | Catch migration issues |
| Use seed data for development | Reproducible test environment |

## Deployment Flow

```
Developer Machine          Staging                   Production
     │                        │                          │
     │  git push              │                          │
     ├────────────────────────▶                          │
     │                        │                          │
     │  CI: lint+test+build   │                          │
     │  ✅ All pass           │                          │
     │                        │                          │
     │  Auto-deploy           │                          │
     │  ┌──────────────┐      │                          │
     │  │ Staging Live │      │                          │
     │  └──────────────┘      │                          │
     │                        │                          │
     │  Smoke test staging    │                          │
     │  ✅ Pass               │                          │
     │                        │                          │
     │  Manual approval       │                          │
     ├─────────────────────────────────────────────────▶│
     │                        │                          │
     │                        │  ┌────────────────────┐  │
     │                        │  │ Production Live    │  │
     │                        │  └────────────────────┘  │
     │                        │                          │
     │  Post-deploy smoke     │                          │
     │  ✅ Pass               │                          │
     │                        │                          │
```

## `/rollout` Checklist Template

```markdown
## Pre-Deploy
- [ ] All CI checks passing on main
- [ ] Coverage ≥ {{THRESHOLD}}%
- [ ] No pending/unapplied migrations
- [ ] Staging deployment verified
- [ ] Smoke tests passing on staging

## Migrations
- [ ] List new migrations to apply: ___
- [ ] Migrations tested on staging
- [ ] Rollback plan for each migration documented
- [ ] Database backup created (if destructive migration)

## Environment Variables
- [ ] All required env vars set in production
- [ ] No dev/staging values leaking
- [ ] Secrets rotated if needed
- [ ] Third-party API keys valid

## Deploy
- [ ] Trigger production deployment
- [ ] Verify deployment succeeded (no build errors)
- [ ] Check application loads at production URL

## Post-Deploy
- [ ] Run smoke tests against production
- [ ] Check error monitoring (no spike)
- [ ] Verify critical user flows work
- [ ] Check database for migration success
- [ ] Monitor for 30 minutes
```

## Approval Gates (GitHub Environments)

Configure GitHub Environments for deployment protection:

```yaml
# In repository Settings → Environments

staging:
  deployment_branch_policy: main only
  # No protection rules — auto-deploys

production:
  deployment_branch_policy: main only
  protection_rules:
    - required_reviewers: 1
    - wait_timer: 5 minutes  # Cooling period
  environment_secrets:
    - PROD_DATABASE_URL
    - PROD_ANON_KEY
```

### GitHub Actions Integration

```yaml
jobs:
  deploy-production:
    runs-on: ubuntu-latest
    environment: production  # Triggers approval gate
    steps:
      - name: Deploy
        run: {{DEPLOY_COMMAND}}
```

## Rollback Strategies

### Decision Matrix

| Scenario | Strategy | Command | Time |
|----------|----------|---------|------|
| Bad code, no DB changes | Revert commit | `git revert` + push | 5 min |
| Bad code + reversible migration | Revert commit + rollback migration | `git revert` + SQL | 15 min |
| Bad code + irreversible migration | Restore from backup | Provider restore | 30-60 min |
| Security vulnerability | Immediate revert + rotate credentials | `git revert` + secret rotation | 10 min |
| Performance regression | Revert commit | `git revert` + push | 5 min |

### Rollback via GitHub UI

1. Go to the commit that caused the issue
2. Click "Revert" to create a revert commit
3. Merge the revert PR
4. Auto-deploys to staging → manual approve for production

### Rollback via CLI

```bash
# Identify the bad commit
git log --oneline -5

# Revert it
git revert <commit-sha> --no-edit

# Push to main (triggers deploy)
git push origin main
```

### Database Rollback

For migrations that need to be undone:

```sql
-- Only if the migration is safely reversible
-- Example: remove a column that was just added

ALTER TABLE public.expenses
    DROP COLUMN IF EXISTS new_column;

-- Remove from tracking
DELETE FROM public.schema_migrations
WHERE version = '010';
```

**Warning:** Never roll back a migration that has user data in it without a backup.

## Safety Rules

| Rule | Consequence of Violation |
|------|------------------------|
| Never deploy on Friday | Weekend outages with no team available |
| Never skip staging | Production-only bugs, user-facing issues |
| Always have rollback plan | Stuck in broken state |
| Never deploy without monitoring | Issues go unnoticed for hours |
| Always backup before destructive migrations | Potential data loss |
| Never deploy during peak usage | Maximum user impact |
| Always verify env vars before deploy | Broken configuration |

## Environment Variables Management

### `.env.example` Template

```bash
# .env.example — Committed to repo (no secrets!)
# Copy to .env.local for development

# Application
VITE_APP_NAME={{PROJECT_NAME}}
VITE_APP_URL=http://localhost:5173

# Supabase
VITE_SUPABASE_URL=http://localhost:54321
VITE_SUPABASE_ANON_KEY=your-local-anon-key

# Feature Flags
VITE_ENABLE_ANALYTICS=true
VITE_ENABLE_RECEIPTS=true

# Optional: Error tracking
VITE_SENTRY_DSN=
```

### Environment Comparison

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| `*_URL` | localhost | staging.example.com | app.example.com |
| `*_ANON_KEY` | Local key | Staging key | Production key |
| Error tracking | Disabled | Enabled (low volume) | Enabled |
| Analytics | Disabled | Disabled | Enabled |
| Debug mode | Enabled | Disabled | Disabled |

## Monitoring After Deploy

### Immediate (First 5 Minutes)

- [ ] Application accessible at production URL
- [ ] Login flow works
- [ ] Core feature (create/read/update) works
- [ ] No console errors in browser
- [ ] Error monitoring dashboard clean

### Short-Term (First 30 Minutes)

- [ ] No elevated error rates
- [ ] Response times normal
- [ ] Database connections stable
- [ ] No user-reported issues
- [ ] Memory/CPU normal

### What to Watch

| Metric | Normal | Alert |
|--------|--------|-------|
| Error rate | < 0.1% | > 1% |
| Response time (p95) | < 500ms | > 2000ms |
| Successful requests | > 99% | < 95% |
| Database connections | < 50% pool | > 80% pool |
| Memory usage | < 70% | > 90% |

## Real-World Deployment Stacks

### Nidhi Seermai (Vercel + Supabase)

| Layer | Tool | Config |
|-------|------|--------|
| Frontend hosting | Vercel | Auto-deploy from main |
| Database | Supabase Cloud | Managed PostgreSQL |
| Auth | Supabase Auth | Magic link + OAuth |
| Storage | Supabase Storage | Receipt images |
| CI | GitHub Actions | Lint + test + build |
| Monitoring | Vercel Analytics | Web vitals |

### Saranidhi (Firebase + Supabase)

| Layer | Tool | Config |
|-------|------|--------|
| Web hosting | Firebase Hosting | Auto-deploy from main |
| Mobile | Play Store / App Store | Manual release |
| Database | Supabase Cloud | Managed PostgreSQL |
| Auth | Supabase Auth | Email + Google |
| CI | GitHub Actions | Analyze + test + build |
| Monitoring | Firebase Crashlytics | Error tracking |

# Development Workflow

## Sprint Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    SPRINT LIFECYCLE                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  /start-sprint N                                            │
│       │                                                     │
│       ▼                                                     │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐                │
│  │  Plan   │───▶│  Build  │───▶│  Test   │                │
│  └─────────┘    └─────────┘    └─────────┘                │
│       │              │              │                        │
│       │              ▼              ▼                        │
│       │         Code + PRs    CI Pipeline                   │
│       │                             │                        │
│       │                             ▼                        │
│       │                     ┌─────────────┐                 │
│       │                     │   Review    │                 │
│       │                     └─────────────┘                 │
│       │                             │                        │
│       ▼                             ▼                        │
│  /finish-sprint N                                           │
│       │                                                     │
│       ▼                                                     │
│  /project-update                                            │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Per Sprint

1. **Start** — Run `/start-sprint N` to create branch, set up tracker entry
2. **Build** — Implement features, commit frequently, push PRs
3. **Test** — CI runs automatically; manual smoke tests before merge
4. **Review** — PR review, address feedback
5. **Finish** — Run `/finish-sprint N` to update tracker, merge to main
6. **Update** — Run `/project-update` to sync all documentation

## Protocols

### `/start-sprint`

Initializes a new sprint. Creates the sprint branch, adds tracker entry, sets up tasks.

**Example:**
```
/start-sprint 3

→ Creates branch: sprint-3/main
→ Adds Sprint 3 section to docs/sprint-tracker.md
→ Lists planned tasks from project-plan.md
→ Output: "Sprint 3 started. 6 tasks planned. Branch: sprint-3/main"
```

**What it does:**
1. Creates `sprint-N/main` branch from `main`
2. Adds sprint header + task list to `docs/sprint-tracker.md`
3. References planned modules from `docs/project-plan.md`
4. Sets sprint status to `In Progress`

### `/finish-sprint`

Closes the current sprint. Updates tracker, runs final checks, prepares merge.

**Example:**
```
/finish-sprint 3

→ Updates Sprint 3 status to "Completed" in tracker
→ Records completion date
→ Lists any incomplete tasks (moved to next sprint)
→ Triggers /project-update
→ Output: "Sprint 3 completed. 5/6 tasks done. 1 task moved to Sprint 4."
```

**What it does:**
1. Marks sprint as `Completed` in tracker
2. Records actual completion date
3. Moves incomplete tasks to next sprint
4. Triggers `/project-update` automatically
5. Prepares PR for merge to `main`

### `/project-update`

Syncs all documentation files with current project state.

**Example:**
```
/project-update

→ Updates docs/project-evaluation.md (test counts, coverage)
→ Updates docs/project-valuation-report.md (time tracking)
→ Updates docs/sprint-tracker.md (current status)
→ Updates docs/testing-plan.md (test count progression)
→ Output: "Documentation synced. 4 files updated."
```

**Files updated:**
- `docs/project-evaluation.md` — Test metrics, quality scores
- `docs/project-valuation-report.md` — Hours, session log
- `docs/sprint-tracker.md` — Task completion status
- `docs/testing-plan.md` — Test count progression table

### `/plan`

Creates a detailed implementation plan for a feature or task.

**Example:**
```
/plan add receipt upload with OCR

→ Breaks down into subtasks:
  1. Add file input component (camera + gallery)
  2. Create Supabase storage bucket with RLS
  3. Implement upload service with progress
  4. Add OCR extraction (future: Tier 2)
→ Estimates: 2-3 hours AI-assisted
→ Output: Implementation plan with acceptance criteria
```

### `/hotfix`

Emergency fix workflow — bypasses normal sprint flow.

**Example:**
```
/hotfix auth-redirect-loop

→ Creates branch: hotfix/auth-redirect-loop
→ Skips sprint assignment
→ Fast-track PR (no feature branch)
→ Deploys immediately after merge
→ Output: "Hotfix branch created. Fix, test, merge, deploy."
```

**Rules:**
- Must include test that reproduces the bug
- Must pass all existing tests
- Deployed immediately after merge
- Logged in sprint tracker as unplanned work

### `/rollout`

Production deployment checklist and execution.

**Example:**
```
/rollout production

→ Runs pre-deploy checklist:
  ✓ All tests passing
  ✓ Coverage ≥ threshold
  ✓ No pending migrations
  ✓ Environment variables set
  ✓ Rollback plan documented
→ Triggers deployment
→ Runs post-deploy smoke tests
→ Output: "Deployed to production. Smoke tests: 12/12 passing."
```

## Rollback Strategies

| Scenario | Strategy | Time to Recover | Risk |
|----------|----------|-----------------|------|
| Bad deployment (no data changes) | Git revert + redeploy | 5-10 min | Low |
| Bad migration (reversible) | Run down migration | 10-15 min | Medium |
| Bad migration (data loss risk) | Restore from backup | 30-60 min | High |
| Auth/security issue | Immediate revert | 5 min | Critical |

### Revert Instructions

```bash
# Revert last deployment
git revert HEAD --no-edit
git push origin main

# Revert specific commit
git revert <commit-sha> --no-edit
git push origin main

# Database rollback (if migration has down)
psql $DATABASE_URL -f supabase/migrations/rollback/XXX_rollback.sql
```

## CI/CD Pipeline

| Stage | Trigger | Actions | Blocking |
|-------|---------|---------|----------|
| Lint | Every push | Format check, static analysis | Yes |
| Test | Every push | Unit tests, coverage check | Yes |
| Build | Every push | Compile, bundle | Yes |
| E2E | PR to main | Integration tests, browser tests | Yes |
| Deploy (staging) | Merge to main | Auto-deploy to staging | No |
| Deploy (production) | Manual trigger | Deploy after approval | Yes |

## Pre-commit Hooks

```yaml
# lefthook.yml
pre-commit:
  parallel: true
  commands:
    format:
      run: {{FORMAT_COMMAND}}
    analyze:
      run: {{LINT_COMMAND}}
    test:
      run: {{UNIT_TEST_COMMAND}}
```

## Deployment Architecture

| Component | Development | Staging | Production |
|-----------|-------------|---------|------------|
| Frontend | localhost:{{PORT}} | {{STAGING_URL}} | {{PRODUCTION_URL}} |
| Database | Local/Supabase dev | Supabase staging | Supabase production |
| Storage | Local bucket | Staging bucket | Production bucket |
| Auth | Test accounts | Staging auth | Production auth |
| Secrets | `.env.local` | GitHub Secrets | GitHub Secrets |

## Branch Naming

| Type | Pattern | Example |
|------|---------|---------|
| Sprint work | `sprint-N/main` | `sprint-3/main` |
| Feature | `sprint-N/feature-name` | `sprint-3/receipt-upload` |
| Hotfix | `hotfix/description` | `hotfix/auth-redirect-loop` |
| Docs | `docs/description` | `docs/update-testing-plan` |
| Release | `release/X.Y` | `release/1.0` |

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

| Type | Usage | Example |
|------|-------|---------|
| `feat` | New feature | `feat(expenses): add receipt upload` |
| `fix` | Bug fix | `fix(auth): resolve redirect loop` |
| `chore` | Maintenance | `chore(deps): update Vue to 3.5` |
| `docs` | Documentation | `docs(sprint): complete sprint 3 tracker` |
| `test` | Test additions | `test(dashboard): add integration tests` |
| `refactor` | Code restructuring | `refactor(stores): extract query cache` |
| `ci` | CI/CD changes | `ci: add coverage threshold check` |

## Quality Gates

| Gate | Threshold | Enforcement |
|------|-----------|-------------|
| TypeScript/Lint | Zero errors | CI blocks merge |
| Unit test coverage | ≥ {{COVERAGE_TARGET}}% | CI blocks merge |
| All tests passing | 100% | CI blocks merge |
| Build succeeds | Clean build | CI blocks merge |
| PR review | 1 approval | GitHub branch protection |
| E2E tests | All passing | CI blocks merge to main |

## Verification Checklist

Before marking a sprint complete:

- [ ] All planned tasks completed (or explicitly moved)
- [ ] CI pipeline green on sprint branch
- [ ] Coverage threshold met
- [ ] Sprint tracker updated
- [ ] Documentation current (`/project-update` run)
- [ ] No known regressions
- [ ] PR merged to main

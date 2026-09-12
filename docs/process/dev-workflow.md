[← Back to docs index](../README.md)

# Development Workflow (Core tier)

> **Reviewed:** vX.Y.Z · **Next review:** every release (docs-audit gate) + when a protocol/gate/flow changes.
>
> The operating protocols for a **Core**-tier project. See [`../../PRINCIPLES.md`](../../PRINCIPLES.md)
> for the model these encode and [`../../tiers/README.md`](../../tiers/README.md) for the
> tier comparison. **Min** tier does not use these protocols — branch → PR (with `Tested:`)
> → human merges. Update this doc **and** the project's `AI_COLLABORATION_FRAMEWORK.md` in
> the same PR when a protocol/gate/flow changes, so they never drift.

## Absolute rule — merge & release authority

> The agents **push branches, open PRs, and validate CI, but NEVER merge to
> `main`/`prod` and NEVER create tags.** The **human is the sole merge & release
> authority.** This applies to every protocol below.

## Protocol names

`{domain}-{action}`: `/sprint-start`, `/sprint-finish`, `/sprint-update`, `/plan`,
`/delegate`, `/hotfix`, `/release-start`, `/release-finish`, `/release-update`.

## Sprint Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    SPRINT LIFECYCLE                          │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  /sprint-start N                                            │
│       │                                                     │
│       ▼                                                     │
│  ┌─────────┐    ┌─────────┐    ┌─────────┐                │
│  │  Spec   │───▶│  Build  │───▶│  Test   │                │
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
│  /sprint-finish N   →   human merges                        │
│       │                                                     │
│       ▼                                                     │
│  /sprint-update                                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

## Per Sprint

1. **Start** — `/sprint-start N`: branch from `main`, mark tracker "In Progress"
2. **Spec** (non-trivial work) — planning agent writes the sprint `spec.md` in the dossier
3. **Build** — coding agent implements; local `analyze` + tests **green before the PR**
4. **Test** — CI runs; QA-Verify smoke test on the deployed build before merge
5. **Review** — planning agent reviews the **real diff** against the spec
6. **Finish** — `/sprint-finish N`: tracker → Complete, push, PR ready; **human merges**
7. **Update** — `/sprint-update`: sync docs + finalize the dossier index

## Protocols

### `/sprint-start`

Lightweight entry point.
1. Create branch `feature/sprintN-<topic>` from `main`
2. Mark the sprint "🚧 In Progress" in `docs/process/sprint-tracker.md`
3. Seed the sprint **dossier** `docs/process/sprints/sprint-N-<slug>/` from
   [`templates/`](templates/) (spec + empty impl/test summaries + README index)

### `/delegate` — spec → coding-setup → review

The core Flow 3 handoff (the two-agent division of labor):
1. **Planning agent authors `spec.md`** in the dossier: exact scope, edge cases, test
   updates, migration behavior, DoD, and a **pre-flight known-green baseline** (it can't
   run tests locally and must not ship correctness-critical code blind on CI alone).
2. **Coding agent implements**, runs local `analyze` + tests **GREEN before the PR**,
   fills `implementation-summary.md` + `test-summary.md`, opens the PR.
3. **Planning agent reviews the real diff** (fetches it — does not trust the summary).
   Any source-derived value flagged in the spec is cross-verified before merge.
4. **Human merges** (sole authority). Then `/sprint-update`.

Rules: delegated work stays on its own branch, only files in the spec's scope, and
**no loosening of lint/analysis config** to force a clean pass.

### `/sprint-finish`

1. Commit remaining changes; push branch
2. Create PR targeting `main`
3. `docs/process/sprint-tracker.md` → ✅ Complete (PR #N); push
4. **Tell the human the PR is ready** — the agent never merges
5. Ask: *"Run /sprint-update now or later?"*

### `/sprint-update`

Runs **after merge** on a docs-only branch (`docs/sprintN-update`) to avoid CI code failures.
Update:
- `docs/process/sprint-tracker.md` — inline spec delta on the completed sprint
- `docs/process/spec-changelog.md` — **★ append** the ADDED/MODIFIED/REMOVED delta
- `docs/process/project-evaluation.md` — test metrics, resolved defects
- `docs/process/project-valuation-report.md` — sprint delivery row + phase hours (AI-est + 20%)
- `docs/testing/testing-plan.md` — test-count progression
- product docs (user guide) + `.kiro/steering/{{SPEC_FILE}}` — current state in-place
- finalize the sprint dossier `README.md` (links spec → impl → test → PR)

> **Delta tracking:** the steering spec is updated in-place (current truth); the
> spec-changelog is appended (history). See `guides/10-delta-tracking.md`.
>
> **Valuation is minimalist:** add one delivery row + bump phase hours. Do **not**
> add a per-commit timeline (→ `git log`) or a per-feature deliverables list
> (→ sprint-tracker/CHANGELOG) — those rot.

### `/plan`

Strategic brainstorming → sprint plan revision. Brainstorm with the human, confirm scope,
branch (`plan/sprint-N`), update `sprint-tracker.md` + `sprint-backlog.md` (+ product/
reference docs if scope changes), push, open PR. **The human merges.**

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
- Must include a test that reproduces the bug
- Must pass all existing tests
- New branch → fix → PR → **human merges** (never `--amend` after a CI failure)
- Log it as unplanned work + a Resolved Defects row in `project-evaluation.md`

### `/release-*` — three-phase production promotion (Flow 4)

Deploy targets: `main` → staging; `prod` (or your production branch) → production.

#### `/release-start`
1. Create branch `release/vX.Y.Z` from `main`
2. **First commit bumps the app version** (so the deployed build shows the right version in smoke testing)
3. Ensure `docs/testing/releases/smoke-test-vX.Y.Z.md` exists (plan + results template)
4. Draft `docs/testing/releases/release-notes-vX.Y.Z.md` (permanent record of the release)
5. Create `docs/testing/releases/docs-audit-vX.Y.Z.md` — the **human-run docs-freshness gate**
6. Open PR → `main`; the human smoke-tests staging, commits results, merges

#### `/release-finish`
1. Validate the smoke-test PR merged + **CI green (not just the preview)**
2. Create PR `main → prod` with the release notes
3. Human merges → production deploys; **human creates the tag** `vX.Y.Z`

#### `/release-update`
1. Branch `docs/release-vX.Y.Z-update`
2. Finalize `release-notes-vX.Y.Z.md`; **confirm the docs-audit is ticked PASS** and fix any doc it flagged (bump that doc's `> Reviewed:` stamp)
3. Add the version row to `smoke-test-results.md`; set the `CHANGELOG.md` date
4. Refresh `README.md` Current Status + `sprint-tracker.md` current-state note
5. Push, open docs-only PR; **human merges**

#### Docs Freshness Gate (per release)
The doc equivalent of the smoke test — a transactional, **human-run** gate
(`docs-audit-vX.Y.Z.md` from [`templates/docs-audit.template.md`](templates/docs-audit.template.md))
that keeps durable docs from silently rotting. Mechanism: every durable doc carries a
`> Reviewed: vX.Y.Z` stamp; a stamp older than the current release is a visible red flag
the audit must resolve. Created at `/release-start`, ticked by the human, confirmed PASS
at `/release-update`.

**Rules:** the agent never pushes to `main`/`prod` and never tags; smoke test must PASS
before `/release-finish`; a QA bug is fixed on the same branch and the specific scenario
re-verified.

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
| Sprint feature | `feature/sprintN-topic` | `feature/sprint3-receipt-upload` |
| Hotfix | `fix/description` | `fix/auth-redirect-loop` |
| Docs | `docs/description` | `docs/update-testing-plan` |
| Plan | `plan/description` | `plan/sprint-4` |
| Release | `release/vX.Y.Z` | `release/v1.0.0` |

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
- [ ] **CI green — the full suite, not just a deploy preview** (see the gate note below)
- [ ] Coverage threshold met
- [ ] Sprint dossier filled: spec + implementation-summary + test-summary
- [ ] Sprint tracker updated + spec delta documented (ADDED/MODIFIED/REMOVED)
- [ ] Documentation current (`/sprint-update` run); dossier index finalized
- [ ] No known regressions
- [ ] **Human** merged to main (the agent never merges)

> **CI green, not just the preview.** A green deploy preview is NOT sign-off — confirm
> the required CI checks (fast + full test suites, coverage, integration) are green
> before any merge. A preview can pass while the full suite fails (syntax slips,
> coverage shortfalls, stale integration assertions).

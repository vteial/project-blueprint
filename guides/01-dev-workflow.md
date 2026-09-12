# Guide: Development Workflow

## Philosophy

Sprint-based development with AI assistance follows a simple principle: **structure enables speed**. Without consistent protocols, every sprint starts with "where were we?" — wasting the first hour rediscovering context. With protocols, you start building immediately.

This workflow is designed for **solo developers or small teams** working with AI coding assistants. It scales down to one person and up to about 5, beyond which you likely need more formal project management.

## Why Each Protocol

### `/sprint-start` — Context Loading

**Problem it solves:** Every coding session starts cold. The AI doesn't remember what you did yesterday, and you might not either.

**What it does:**
1. Creates a sprint branch (isolates work)
2. Loads sprint context from tracker
3. Lists remaining tasks
4. Sets the working state

**Real example (Nidhi Seermai, Sprint 3):**
```
/sprint-start 3

Sprint 3: Polish & Extended Features
Branch: sprint-3/main (created from main)

Planned tasks:
- 3.1 Tag-based categorization
- 3.2 Receipt upload with storage
- 3.3 Calendar view with indicators
- 3.4 Dark mode / theming
- 3.5 Performance optimization
- 3.6 E2E test suite

Continuing from Sprint 2: Dashboard + analytics operational.
```

### `/sprint-finish` — Clean Handoff

**Problem it solves:** Without a clean finish, tasks bleed between sprints. You lose track of what's done vs what's "mostly done."

**What it does:**
1. Audits task completion
2. Moves incomplete work explicitly
3. Records metrics (test count, coverage)
4. Triggers documentation sync
5. Merges sprint branch

**Real example (Saranidhi, Sprint 2):**
```
/sprint-finish 2

Sprint 2 Summary:
- Planned: 6 tasks
- Completed: 5 tasks
- Moved to Sprint 3: 1 task (offline sync — needs more research)

Metrics:
- Tests: 12 → 28 (+16)
- Coverage: 35% → 52% (+17%)

Sprint branch merged to main.
Documentation updated via /sprint-update.
```

### `/sprint-update` — Living Documentation

**Problem it solves:** Docs go stale within hours of writing them. By the time you need them (security review, client demo, onboarding), they're wrong.

**What it does:**
- Reads current codebase state
- Updates test counts, coverage numbers
- Refreshes sprint tracker status
- Syncs evaluation scores
- Updates valuation hours

**Real example:**
```
/sprint-update

Updated:
✓ docs/project-evaluation.md — Tests: 34→38, Coverage: 62%→68%
✓ docs/sprint-tracker.md — Sprint 4: 3/6 tasks complete
✓ docs/testing-plan.md — Added 4 new test IDs
✓ docs/project-valuation-report.md — Session 8 logged (2.5h)
```

### `/plan` — Before You Build

**Problem it solves:** Jumping into code without a plan leads to rewrites. AI can over-engineer or under-engineer without constraints.

**What it does:**
- Breaks feature into subtasks
- Identifies dependencies
- Estimates effort
- Defines acceptance criteria

**Real example:**
```
/plan add project management to expenses

Implementation plan:
1. Create projects table (migration 002)
2. Add project_id FK to expenses (migration 003)
3. Create projects Pinia store
4. Build ProjectsView with CRUD
5. Add project selector to expense form
6. Update dashboard to group by project

Estimate: 3-4 hours AI-assisted
Dependencies: None (new feature)
Acceptance: User can create projects, assign expenses, filter by project
```

### `/hotfix` — Emergency Lane

**Problem it solves:** Production bugs can't wait for sprint planning. You need a fast lane that still maintains quality.

**Rules:**
- Bypasses sprint assignment
- Requires a test that reproduces the bug
- Deploys immediately after merge
- Gets logged as unplanned work in tracker

### `/release-finish` — Deployment Safety Net

**Problem it solves:** "It works on my machine" → broken production. Checklists prevent forgotten steps.

**What it does:**
- Pre-deploy verification (tests, coverage, migrations)
- Environment variable audit
- Deploy execution
- Post-deploy smoke tests
- Rollback readiness confirmation

> **Preview deployments & automated QA:** run the pre-merge smoke test on the **PR preview**
> (not staging), skip builds for changes that can't affect the bundle, and — if previews sit
> behind SSO — hand a headless QA agent a Protection-Bypass token. See
> [Guide 09 — Production Rollout § Preview Deployments & Automated QA](09-prod-rollout.md#preview-deployments--automated-qa).

## Responsibility Split

| Task | AI (Kiro/IDE) | Human | Why |
|------|--------------|-------|-----|
| Writing code | Primary | Review | AI is fast at generation |
| Architecture decisions | Suggests | Decides | Human understands business |
| Test writing | Primary | Verify coverage | AI generates thorough tests |
| PR creation | Primary | Review + merge | Human gate on quality |
| Sprint planning | Assists | Decides priorities | Human knows what matters |
| Debugging | Assists | Directs investigation | Human has context |
| Documentation | Primary | Review accuracy | AI handles volume |
| Deployment | Assists (checklist) | Executes | Human owns production |

## Adapting for Your Team

### Solo Developer

Use all protocols as-is. The sprint structure keeps you honest with yourself about progress. `/sprint-update` is especially valuable — it's your "standup" with yourself.

### Small Team (2-5)

- Add PR reviews as a gate
- Sprint planning becomes a conversation (15 min)
- Each person owns specific modules
- `/sprint-update` becomes the team sync artifact

### Without Kiro

The protocols are just checklists. Without an AI to automate them:
- `/sprint-start` → Create branch manually, write sprint tasks in tracker
- `/sprint-finish` → Review tracker, move tasks, merge manually
- `/sprint-update` → Update docs by hand (less frequent, that's okay)
- `/plan` → Write plan in an issue or doc before coding

## Common Pitfalls

| Pitfall | Symptom | Fix |
|---------|---------|-----|
| Skipping `/sprint-finish` | Tasks bleed between sprints | Make it a ritual |
| Over-planning | Sprint takes 3 days to plan | Limit to 4-8 tasks/sprint |
| Never updating docs | Stale test counts, wrong architecture | Run `/sprint-update` weekly minimum |
| Sprint scope creep | "Just one more feature" | Move to next sprint instead |
| Hotfix without test | Bug comes back later | Require regression test |
| Deploying without checklist | Missing env var breaks prod | Always use `/release-finish` |

# Guide: Documentation Standards

## Required Documents

Every project using this blueprint should maintain these documents:

> Paths reflect the grouped `docs/` layout (`process/ product/ testing/ reference/`).
> Each durable doc carries a `> Reviewed: vX.Y.Z` stamp checked by the per-release docs-audit gate.

| # | Document | Purpose | Update Frequency |
|---|----------|---------|-----------------|
| 1 | `docs/reference/architecture.md` | Architecture, data model, features | Sprint start / arch changes |
| 2 | `docs/process/sprint-tracker.md` | Sprint history and task status | Every `/sprint-finish` |
| 3 | `docs/process/sprint-backlog.md` | Candidate/future work, epics | `/plan` |
| 4 | `docs/process/dev-workflow.md` | Protocols and CI/CD | When workflow changes |
| 5 | `docs/testing/testing-plan.md` | Test strategy and coverage | Every sprint |
| 6 | `docs/process/project-evaluation.md` | Quality & defects | Every `/sprint-update` |
| 7 | `docs/process/project-valuation-report.md` | Investment & delivery | Every `/sprint-update` |
| 8 | `docs/process/release-plan.md` | Scope, gates, risks | Sprint 3+ / pre-release |
| 9 | `docs/reference/security-review.md` | Security posture | Major release / boundary change |
| 10 | `docs/testing/smoke-test-plan.md` | Manual test scenarios | Pre-release |
| 11 | `docs/testing/smoke-test-results.md` | Per-release results index | Each release |
| 12 | `docs/process/sprints/sprint-N-*/` | Per-sprint dossier (spec+impl+test) | Every sprint (Core) |
| 13 | `docs/testing/releases/` | Per-release dossier (smoke+notes+audit) | Every release (Core) |

## Optional Documents

| Document | When to Add | Example |
|----------|------------|---------|
| `docs/performance-baseline.md` | When performance matters | Load times, bundle sizes |
| `docs/api-reference.md` | When building APIs | Endpoint documentation |
| `docs/data-dictionary.md` | Complex data models | Field definitions, relationships |
| `docs/runbook.md` | Production operations | Incident response procedures |
| `docs/adr/NNN-*.md` | Architecture decisions | Decision records |

## Structure Conventions

### Header Format

Every document starts with:
```markdown
# Document Title

## Section (clear, scannable)
```

No front-matter required (unlike steering files). Documents are for humans.

### Footer Convention

Optional — add conventions comment at bottom for AI context:
```markdown
<!-- CONVENTIONS:
- Status icons: ✅ Done | 🔄 In Progress | 📋 Planned
- Update this file with /sprint-update
- Keep tables sorted by [column]
-->
```

### HTML Comments for AI Instructions

Use HTML comments to give AI tools context without cluttering the human-readable document:
```markdown
<!-- When updating this section, recalculate totals from sprint tracker -->
```

## Freshness Rules

| Document | Stale After | Auto-updatable | Manual Trigger |
|----------|------------|----------------|----------------|
| `sprint-tracker.md` | 1 day without commits | Yes | `/sprint-finish` |
| `project-evaluation.md` | 1 sprint | Yes | `/sprint-update` |
| `project-valuation-report.md` | 1 session | Partially | Manual session log |
| `testing-plan.md` | When tests added | Yes | `/sprint-update` |
| `project-plan.md` | When arch changes | No | Manual review |
| `release-plan.md` | When scope changes | No | Manual review |
| `security-review.md` | Pre-release | No | Manual review |

## Cross-Linking Standards

Documents should reference each other:
```markdown
See [sprint-tracker.md](./sprint-tracker.md) for current status.
Deployment follows [ROLLOUT.md](../supabase/ROLLOUT.md) procedure.
For conventions, see [Guide: Doc Standards](../guides/03-doc-standards.md).
```

**Rules:**
- Use relative paths (works on GitHub and locally)
- Link to specific sections with anchors: `[Release Gates](./release-plan.md#quality-gates)`
- Don't link to external URLs that may rot (except stable references)

## Table Formatting

### Status Indicators

Use consistent icons across all documents:

| Icon | Meaning | Usage |
|------|---------|-------|
| ✅ | Done / Passing / Active | Completed items |
| 🔄 | In Progress | Currently being worked on |
| 📋 | Planned | Scheduled for future |
| ⏸️ | Blocked / Paused | Waiting on dependency |
| ❌ | Failed / Cancelled | Did not pass / removed |
| ⚠️ | Warning / Needs attention | Partial pass or risk |
| ⬜ | Not yet tested | Smoke test results |

### Consistent Columns

Tables with similar data should use consistent column names:

| Pattern | Columns |
|---------|---------|
| Task tracking | `#`, `Task`, `Status`, `Notes` |
| Test scenarios | `ID`, `Scenario`, `Status` |
| Quality gates | `Gate`, `Threshold`, `Status` |
| Time logging | `#`, `Date`, `Duration`, `Focus Area`, `Output` |
| Risk register | `ID`, `Risk`, `Probability`, `Impact`, `Mitigation` |

## Writing Style

- **Tables over prose** for status, comparisons, and inventories
- **Bullets over paragraphs** for lists of items
- **Concrete over abstract** — include real values, not vague descriptions
- **Present tense** for current state ("Coverage is 68%")
- **Imperative** for instructions ("Run `/sprint-update`")
- **No fluff** — every sentence should add information

### Good vs Bad

| ❌ Bad | ✅ Good |
|--------|---------|
| "The testing situation is generally okay" | "34 tests passing, 68% coverage" |
| "We should probably add more tests" | "Coverage gap: `src/utils/` at 42% (target: 70%)" |
| "The sprint went well" | "Sprint 3: 6/6 tasks complete, +12 tests, +15% coverage" |

## `/sprint-update` Automation Flow

When `/sprint-update` runs, it:

1. **Reads** current test output → updates test counts in `testing-plan.md` and `project-evaluation.md`
2. **Reads** sprint tracker → calculates completion rates for `project-evaluation.md`
3. **Reads** coverage report → updates percentages across docs
4. **Reads** commit log → adds session to `project-valuation-report.md`
5. **Writes** all updated files in a single docs commit

```
/sprint-update

Files scanned: 14
Files updated: 4
  ✓ docs/testing-plan.md (test count: 34→38)
  ✓ docs/project-evaluation.md (coverage: 62%→68%)
  ✓ docs/sprint-tracker.md (Sprint 4: 3/6 tasks)
  ✓ docs/project-valuation-report.md (new session)
Files unchanged: 10
```

## Real-World Document Inventories

### Nidhi Seermai (Vue/TS Expense Tracker)

```
docs/
├── dev-workflow.md          (200 lines — protocols + CI)
├── sprint-tracker.md        (180 lines — 5 sprints tracked)
├── project-plan.md          (250 lines — full architecture)
├── project-evaluation.md    (120 lines — scorecard + metrics)
├── project-valuation-report.md (100 lines — 10 sessions)
├── testing-plan.md          (150 lines — 38 test scenarios)
├── release-1.0-plan.md      (130 lines — scope + gates)
└── performance-baseline.md  (60 lines — load times)
```

### Saranidhi (Flutter Freelancer Tool)

```
docs/
├── dev-workflow.md          (180 lines)
├── sprint-tracker.md        (200 lines — 6 sprints)
├── project-plan.md          (220 lines)
├── project-evaluation.md    (100 lines)
├── project-valuation-report.md (90 lines)
├── testing-plan.md          (130 lines)
├── release-plan.md          (110 lines)
├── security-review.md       (80 lines)
├── smoke-test-plan.md       (70 lines)
└── smoke-test-results.md    (60 lines)
```

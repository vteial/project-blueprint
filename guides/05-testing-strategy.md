# Guide: Testing Strategy

## Testing Pyramid

```
         ╱╲
        ╱  ╲          E2E Tests (few, slow, high confidence)
       ╱    ╲         - Full browser automation
      ╱──────╲        - Critical user paths only
     ╱        ╲
    ╱          ╲      Integration Tests (moderate)
   ╱            ╲     - Multi-component flows
  ╱──────────────╲    - Store + component together
 ╱                ╲
╱                  ╲   Unit Tests (many, fast, focused)
╱────────────────────╲ - Pure functions, store logic
                       - Individual components
```

**Rule:** More tests at the bottom, fewer at the top. Unit tests are cheap; E2E tests are expensive.

## Coverage Threshold Progression

| Phase | Sprint | Threshold | Rationale |
|-------|--------|-----------|-----------|
| Foundation | Sprint 1 | 25% | Just core paths — prove the pattern works |
| Growth | Sprint 2 | 40% | Expanding with features |
| Maturity | Sprint 3 | 55% | Critical paths all covered |
| Release | Sprint 4+ | 70% | Production-ready confidence |

**Why progressive?** Setting 80% on Sprint 1 blocks all PRs for boilerplate coverage. Start low, ratchet up as the codebase stabilizes.

### Ratchet Rule

Coverage can only go **up** between sprints. If Sprint 2 reaches 45%, Sprint 3's threshold becomes 45% (not 55% if already exceeded). Never lower the threshold.

## Test Categories & Tags

| Category | Tag | What It Tests | Location |
|----------|-----|---------------|----------|
| Domain unit | `@domain` | Pure logic, calculations, transformations | `src/**/__tests__/` |
| UI component | `@component` | Rendering, props, events, slots | `src/components/__tests__/` |
| Integration | `@integration` | Multi-component user flows | `src/views/__tests__/` |
| E2E | `@e2e` | Full browser scenarios | `e2e/` |
| Security | `@security` | Auth, RLS, permissions | `e2e/security/` |
| Performance | `@perf` | Load times, render speed | `e2e/performance/` |

## Writing Good Test Scenarios

### ID System

```
[CATEGORY]-[NUMBER]
```

| Category Code | Meaning | Example |
|--------------|---------|---------|
| `DU` | Domain Unit | `DU-001` |
| `UC` | UI Component | `UC-001` |
| `UF` | User Flow (Integration) | `UF-001` |
| `SE` | Security E2E | `SE-001` |
| `PF` | Performance | `PF-001` |
| `CR` | Cross-browser/Responsive | `CR-001` |

### Scenario Template

```markdown
| ID | Scenario | Steps | Expected | Priority |
|----|----------|-------|----------|----------|
| DU-001 | Calculate total with tax | Input: [100, 200], tax: 0.1 | 330 | High |
```

### Good vs Bad Scenarios

| ❌ Bad | ✅ Good | Why |
|--------|---------|-----|
| "Test the add function" | "DU-001: Add expense — amount 5000 cents → stored as 5000" | Specific input/output |
| "Check if login works" | "SE-001: Login with valid email/password → redirect to /dashboard, session cookie set" | Clear success criteria |
| "Test responsive" | "CR-001: Dashboard at 375px — single column, bottom nav visible, no horizontal scroll" | Observable result |
| "It should handle errors" | "UF-003: Network failure during save → error toast, data preserved in form, retry button visible" | Full behavior described |

## Awaiting Coverage Backlog

When you identify areas that need tests but can't write them now:

```markdown
## Awaiting Coverage

| Area | Current | Target | Blocking Reason | Sprint |
|------|---------|--------|-----------------|--------|
| `src/utils/calendar.ts` | 20% | 80% | Complex date edge cases | Sprint 4 |
| `src/stores/expenses.ts` | 45% | 80% | Need fixture data first | Sprint 3 |
| `src/views/AnalyticsView.vue` | 0% | 50% | Charts hard to test | Sprint 5 |
```

This makes technical debt visible and trackable.

## CI Integration

### Test Execution in Pipeline

```yaml
# Relevant section of CI workflow
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install dependencies
        run: {{INSTALL_COMMAND}}
      - name: Run tests with coverage
        run: {{TEST_COMMAND}} --coverage
      - name: Check coverage threshold
        run: |
          COVERAGE=$({{PARSE_COVERAGE_COMMAND}})
          THRESHOLD={{THRESHOLD}}
          if [ "$COVERAGE" -lt "$THRESHOLD" ]; then
            echo "Coverage $COVERAGE% below threshold $THRESHOLD%"
            exit 1
          fi
```

### paths-ignore

Don't run tests when only docs change:

```yaml
on:
  push:
    paths-ignore:
      - 'docs/**'
      - '*.md'
      - '.kiro/**'
```

### Threshold Script Pattern

```bash
#!/bin/bash
# scripts/check-coverage.sh

THRESHOLD=${1:-70}
COVERAGE=$(cat coverage/coverage-summary.json | jq '.total.lines.pct' | cut -d. -f1)

echo "Coverage: ${COVERAGE}%"
echo "Threshold: ${THRESHOLD}%"

if [ "$COVERAGE" -lt "$THRESHOLD" ]; then
  echo "❌ Coverage below threshold!"
  exit 1
else
  echo "✅ Coverage meets threshold"
  exit 0
fi
```

## Manual Smoke Tests

### When to Run

| Trigger | Scope | Who |
|---------|-------|-----|
| Pre-release | Full smoke test plan | Developer |
| After hotfix | Affected areas + regression | Developer |
| Post-deploy | Critical paths only | Developer |
| User-reported bug | Specific scenario | Developer |

### Structure

See `docs/smoke-test-plan.md` for the template. Key points:
- Group scenarios by feature area
- Mark priority (Critical / High / Medium)
- Include specific steps (not just "test login")
- Record results in `docs/smoke-test-results.md`

### Pass Criteria

| Priority | Required Pass Rate |
|----------|-------------------|
| Critical | 100% (blocks release) |
| High | 100% (blocks release) |
| Medium | ≥ 80% (can release with notes) |
| Low | Informational only |

### Execution Timing

- Full plan: ~30-45 minutes
- Critical-only: ~10 minutes
- Post-hotfix: ~15 minutes

## Defect-to-Test Pipeline

When a bug is found:

1. **Document** — Add to defects table in `docs/project-evaluation.md`
2. **Reproduce** — Write a failing test that demonstrates the bug
3. **Fix** — Make the test pass
4. **Verify** — Run full test suite (no regressions)
5. **Close** — Mark defect as resolved, note test ID

```
Bug found → D-005 logged → Write test (fail) → Fix code → Test passes → D-005 resolved (test: DU-015)
```

**Rule:** Every bug fix MUST include a regression test. No exceptions.

## Real-World Test Counts

### Nidhi Seermai (Sprint 5)

| Category | Count | Notable Tests |
|----------|-------|---------------|
| Domain unit | 18 | Store operations, currency math, date ranges |
| Component | 8 | Drawer interactions, form validation |
| Integration | 6 | Dashboard data flow, expense CRUD flow |
| E2E | 6 | Login→create→browse→delete, receipt upload |
| **Total** | **38** | — |

### Saranidhi (Sprint 4)

| Category | Count | Notable Tests |
|----------|-------|---------------|
| Domain unit | 22 | Invoice calculations, time rounding |
| Widget | 10 | Form widgets, list tiles |
| Integration | 8 | Client→invoice flow, time entry |
| E2E | 4 | Full invoice creation, PDF export |
| **Total** | **44** | — |

# Testing Plan

> **Reviewed:** vX.Y.Z · **Next review:** every release (test-count + scenarios).

## Testing Framework Stack

| Layer | Tool | Purpose |
|-------|------|---------|
| Unit tests | {{TEST_RUNNER}} | Domain logic, store tests |
| Component tests | {{COMPONENT_TEST_LIB}} | UI rendering, interactions |
| Integration tests | {{INTEGRATION_LIB}} | Multi-component user flows |
| E2E tests | {{E2E_FRAMEWORK}} | Full browser automation |
| Coverage | {{COVERAGE_TOOL}} | Line + branch coverage |
| Mocking | {{MOCK_LIB}} | API stubs, service mocks |

## Test Categories

### 1. Domain Unit Tests

**What:** Pure business logic — calculations, transformations, state mutations.
**Where:** `src/**/__tests__/*.spec.ts`
**Runs:** Every push (CI) + pre-commit (local)

| ID | Scenario | Status |
|----|----------|--------|
| DU-001 | {{DOMAIN_TEST_1}} | ✅ Passing |
| DU-002 | {{DOMAIN_TEST_2}} | ✅ Passing |
| DU-003 | {{DOMAIN_TEST_3}} | ✅ Passing |
| DU-004 | {{DOMAIN_TEST_4}} | ✅ Passing |
| DU-005 | {{DOMAIN_TEST_5}} | ✅ Passing |

### 2. UI Component Tests

**What:** Component rendering, props, events, slots.
**Where:** `src/components/__tests__/*.spec.ts`
**Runs:** Every push (CI)

| ID | Scenario | Status |
|----|----------|--------|
| UC-001 | {{COMPONENT_TEST_1}} | ✅ Passing |
| UC-002 | {{COMPONENT_TEST_2}} | ✅ Passing |
| UC-003 | {{COMPONENT_TEST_3}} | ✅ Passing |
| UC-004 | {{COMPONENT_TEST_4}} | ✅ Passing |

### 3. User Flow Integration Tests

**What:** Multi-step user journeys through multiple components.
**Where:** `src/views/__tests__/*.spec.ts`
**Runs:** Every push (CI)

| ID | Scenario | Status |
|----|----------|--------|
| UF-001 | {{USER_FLOW_1}} | ✅ Passing |
| UF-002 | {{USER_FLOW_2}} | ✅ Passing |
| UF-003 | {{USER_FLOW_3}} | ✅ Passing |

### 4. Security E2E Tests

**What:** Authentication flows, authorization boundaries, RLS enforcement.
**Where:** `e2e/security/*.spec.ts`
**Runs:** PR to main (CI)

| ID | Scenario | Status |
|----|----------|--------|
| SE-001 | Unauthenticated user cannot access protected routes | ✅ Passing |
| SE-002 | User cannot access other user's data | ✅ Passing |
| SE-003 | Session expiry redirects to login | ✅ Passing |
| SE-004 | Invalid tokens are rejected | ✅ Passing |

### 5. Performance Tests

**What:** Load times, render performance, bundle size.
**Where:** `e2e/performance/*.spec.ts`
**Runs:** PR to main (CI)

| ID | Scenario | Target | Status |
|----|----------|--------|--------|
| PF-001 | Initial page load | < 3s (3G) | ✅ Passing |
| PF-002 | Route navigation | < 500ms | ✅ Passing |
| PF-003 | List rendering (100 items) | < 1s | ✅ Passing |
| PF-004 | Bundle size | < {{SIZE}}KB gzipped | ✅ Passing |

### 6. Cross-Browser / Responsive Tests

**What:** Layout correctness across viewports and browsers.
**Where:** `e2e/responsive/*.spec.ts`
**Runs:** PR to main (CI)

| ID | Scenario | Status |
|----|----------|--------|
| CR-001 | Mobile viewport (375px) — navigation usable | ✅ Passing |
| CR-002 | Tablet viewport (768px) — layout adapts | ✅ Passing |
| CR-003 | Desktop viewport (1280px) — full layout | ✅ Passing |
| CR-004 | Dark mode renders correctly | ✅ Passing |

## Execution Strategy

| Trigger | Tests Run | Timeout | Blocking |
|---------|-----------|---------|----------|
| Pre-commit (local) | Unit only | 30s | Yes |
| Push to any branch | Unit + Component | 2 min | Yes |
| PR to main | All categories | 10 min | Yes |
| Nightly (cron) | Full suite + performance | 15 min | No |

## Test Count Progression

| Sprint | Unit | Component | Integration | E2E | Total |
|--------|------|-----------|-------------|-----|-------|
| Sprint 1 | {{N}} | — | — | — | {{N}} |
| Sprint 2 | {{N}} | {{N}} | {{N}} | — | {{N}} |
| Sprint 3 | {{N}} | {{N}} | {{N}} | {{N}} | {{N}} |
| Sprint 4 | {{N}} | {{N}} | {{N}} | {{N}} | {{N}} |
| Sprint 5 | {{N}} | {{N}} | {{N}} | {{N}} | {{N}} |

## Coverage Targets

### Threshold Progression

| Phase | Sprint | Target | Rationale |
|-------|--------|--------|-----------|
| Foundation | Sprint 1 | 25% | Core paths only |
| Growth | Sprint 2 | 40% | Expanding coverage |
| Maturity | Sprint 3 | 55% | Critical paths covered |
| Release | Sprint 4+ | 70% | Production-ready |

### Current Coverage Breakdown

| Area | Lines | Branches | Functions | Target |
|------|-------|----------|-----------|--------|
| Stores | {{N}}% | {{N}}% | {{N}}% | 80% |
| Utils | {{N}}% | {{N}}% | {{N}}% | 90% |
| Components | {{N}}% | {{N}}% | {{N}}% | 60% |
| Views | {{N}}% | {{N}}% | {{N}}% | 50% |
| Services | {{N}}% | {{N}}% | {{N}}% | 70% |
| **Overall** | **{{N}}%** | **{{N}}%** | **{{N}}%** | **70%** |

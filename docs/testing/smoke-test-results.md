# Smoke Test Results

## Execution Details

| Attribute | Value |
|-----------|-------|
| Application | {{PROJECT_NAME}} |
| Version | {{VERSION}} |
| Environment | {{ENVIRONMENT}} |
| Tester | {{TESTER_NAME}} |
| Date | {{DATE}} |
| Browser | {{BROWSER}} |
| Duration | {{DURATION}} |

## Section 1: Core Functionality

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 1.1 | App loads successfully | ⬜ | — |
| 1.2 | Navigation works | ⬜ | — |
| 1.3 | Create new {{RESOURCE}} | ⬜ | — |
| 1.4 | Edit existing {{RESOURCE}} | ⬜ | — |
| 1.5 | Delete {{RESOURCE}} | ⬜ | — |
| 1.6 | List/browse {{RESOURCE}} | ⬜ | — |

## Section 2: Authentication

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 2.1 | Login with valid credentials | ⬜ | — |
| 2.2 | Login with invalid credentials | ⬜ | — |
| 2.3 | Logout | ⬜ | — |
| 2.4 | Protected route redirect | ⬜ | — |
| 2.5 | Session persistence | ⬜ | — |
| 2.6 | Password reset flow | ⬜ | — |

## Section 3: Data Operations

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 3.1 | Data persists after refresh | ⬜ | — |
| 3.2 | Concurrent data safety | ⬜ | — |
| 3.3 | Large dataset handling | ⬜ | — |
| 3.4 | Search/filter works | ⬜ | — |
| 3.5 | Sort functionality | ⬜ | — |
| 3.6 | Data validation | ⬜ | — |

## Section 4: UI & Responsive

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 4.1 | Mobile layout | ⬜ | — |
| 4.2 | Desktop layout | ⬜ | — |
| 4.3 | Dark mode | ⬜ | — |
| 4.4 | Loading states | ⬜ | — |
| 4.5 | Empty states | ⬜ | — |
| 4.6 | Error states | ⬜ | — |

## Section 5: Edge Cases

| # | Scenario | Result | Notes |
|---|----------|--------|-------|
| 5.1 | Rapid repeated submissions | ⬜ | — |
| 5.2 | Very long text input | ⬜ | — |
| 5.3 | Special characters | ⬜ | — |
| 5.4 | Back button behavior | ⬜ | — |
| 5.5 | Deep link access | ⬜ | — |

## Verdict

| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| Critical scenarios passing | {{N}}/{{TOTAL}} | 100% | ⬜ |
| High priority passing | {{N}}/{{TOTAL}} | 100% | ⬜ |
| Medium priority passing | {{N}}/{{TOTAL}} | ≥ 80% | ⬜ |
| Total passing | {{N}}/{{TOTAL}} | ≥ 90% | ⬜ |
| Console errors | {{N}} | 0 critical | ⬜ |

**Overall Verdict:** ⬜ PASS / ⬜ FAIL / ⬜ PASS WITH NOTES

## Blockers

| # | Scenario | Issue | Severity | Defect ID |
|---|----------|-------|----------|-----------|
| — | — | — | — | — |

<!-- 
Result icons:
  ✅ Pass
  ❌ Fail  
  ⚠️ Pass with notes
  ⬜ Not yet tested
  ⏭️ Skipped (with reason)
-->

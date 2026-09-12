# Smoke Test Plan

## Test Context

| Attribute | Value |
|-----------|-------|
| Application | {{PROJECT_NAME}} |
| Version | {{VERSION}} |
| Environment | {{ENVIRONMENT}} |
| Tester | {{TESTER_NAME}} |
| Date | {{DATE}} |
| Browser | Chrome (latest) / Safari (latest) |
| Viewport | Mobile (375px) + Desktop (1280px) |

## Section 1: Core Functionality

| # | Scenario | Steps | Expected Result | Priority |
|---|----------|-------|-----------------|----------|
| 1.1 | App loads successfully | Navigate to root URL | Landing page renders, no console errors | Critical |
| 1.2 | Navigation works | Click each nav item | Correct view loads, URL updates | Critical |
| 1.3 | Create new {{RESOURCE}} | Fill form, submit | Item created, appears in list | Critical |
| 1.4 | Edit existing {{RESOURCE}} | Open item, modify, save | Changes persisted, UI updates | Critical |
| 1.5 | Delete {{RESOURCE}} | Select item, confirm delete | Item removed from list + database | High |
| 1.6 | List/browse {{RESOURCE}} | Navigate to list view | All user items displayed, sorted correctly | High |

## Section 2: Authentication

| # | Scenario | Steps | Expected Result | Priority |
|---|----------|-------|-----------------|----------|
| 2.1 | Login with valid credentials | Enter email/password, submit | Redirect to dashboard, session created | Critical |
| 2.2 | Login with invalid credentials | Enter wrong password | Error message displayed, no redirect | Critical |
| 2.3 | Logout | Click logout | Session cleared, redirect to landing | Critical |
| 2.4 | Protected route redirect | Access /dashboard without auth | Redirect to login page | High |
| 2.5 | Session persistence | Login, close tab, reopen | Still authenticated | High |
| 2.6 | Password reset flow | Request reset, check email | Reset email sent, link works | Medium |

## Section 3: Data Operations

| # | Scenario | Steps | Expected Result | Priority |
|---|----------|-------|-----------------|----------|
| 3.1 | Data persists after refresh | Create item, refresh page | Item still visible | Critical |
| 3.2 | Concurrent data safety | Open in two tabs, edit in both | No data corruption, last-write-wins | High |
| 3.3 | Large dataset handling | Load view with 50+ items | Renders without freezing, scrolls smoothly | High |
| 3.4 | Search/filter works | Enter search query | Results filtered correctly | Medium |
| 3.5 | Sort functionality | Change sort order | Items reorder correctly | Medium |
| 3.6 | Data validation | Submit invalid data | Error messages shown, form not submitted | High |

## Section 4: UI & Responsive

| # | Scenario | Steps | Expected Result | Priority |
|---|----------|-------|-----------------|----------|
| 4.1 | Mobile layout | View at 375px width | Single column, bottom nav, touch-friendly | High |
| 4.2 | Desktop layout | View at 1280px width | Multi-column where appropriate | High |
| 4.3 | Dark mode | Toggle dark mode | All elements readable, no broken colors | Medium |
| 4.4 | Loading states | Slow network (throttle) | Skeleton/spinner shown during loads | Medium |
| 4.5 | Empty states | View with no data | Helpful empty state message + CTA | Medium |
| 4.6 | Error states | Disconnect network, retry | Error message shown, retry option available | Medium |

## Section 5: Edge Cases

| # | Scenario | Steps | Expected Result | Priority |
|---|----------|-------|-----------------|----------|
| 5.1 | Rapid repeated submissions | Click submit 5x quickly | Only one item created (debounced) | High |
| 5.2 | Very long text input | Enter 1000+ char string | Truncated or scrollable, no overflow | Medium |
| 5.3 | Special characters | Use emoji, unicode in inputs | Stored and displayed correctly | Medium |
| 5.4 | Back button behavior | Navigate forward, press back | Returns to previous view correctly | High |
| 5.5 | Deep link access | Directly access /{{RESOURCE}}/123 | Correct item loads (or 404 if not found) | Medium |

## Pass Criteria

| Criteria | Threshold |
|----------|-----------|
| Critical scenarios | 100% pass |
| High priority scenarios | 100% pass |
| Medium priority scenarios | ≥ 80% pass |
| Total scenarios | ≥ 90% pass |
| Console errors | 0 critical errors |
| Visual regressions | 0 blocking issues |

## Execution Notes

- Execute on **staging** environment before production deploy
- Test on both mobile and desktop viewports
- Check browser console for errors after each scenario
- Screenshot any failures for defect tracking
- Re-test after any hotfix deployment
- Total estimated execution time: 30-45 minutes

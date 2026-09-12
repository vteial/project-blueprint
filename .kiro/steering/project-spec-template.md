---
inclusion: auto
---

# Project Specification: {{PROJECT_NAME}}

## System Objective & Guardrails

**Objective:** {{ONE_SENTENCE_DESCRIPTION}}

**Guardrails:**
- {{GUARDRAIL_1}}
- {{GUARDRAIL_2}}
- {{GUARDRAIL_3}}

## Technical Stack

| Layer | Technology | Version | Notes |
|-------|-----------|---------|-------|
| Language | {{LANGUAGE}} | {{VERSION}} | — |
| Framework | {{FRAMEWORK}} | {{VERSION}} | — |
| State Management | {{STATE_LIB}} | {{VERSION}} | — |
| Database | {{DATABASE}} | — | {{HOSTING}} |
| Auth | {{AUTH_PROVIDER}} | — | {{AUTH_METHOD}} |
| Hosting | {{HOSTING_PLATFORM}} | — | {{PLAN}} |
| CI/CD | GitHub Actions | — | See `.github/workflows/` |
| Pre-commit | Lefthook | — | See `lefthook.yml` |

## Architecture Layers

```
┌─────────────────────────────────────────┐
│              UI Layer                    │
│  {{UI_FRAMEWORK}} + {{COMPONENT_LIB}}   │
├─────────────────────────────────────────┤
│           State Layer                   │
│  {{STATE_MANAGEMENT}}                   │
├─────────────────────────────────────────┤
│          Service Layer                  │
│  {{SERVICE_PATTERN}}                    │
├─────────────────────────────────────────┤
│           Data Layer                    │
│  {{DATABASE}} + {{ORM_OR_CLIENT}}       │
├─────────────────────────────────────────┤
│        Infrastructure Layer             │
│  {{HOSTING}} / {{CDN}} / {{STORAGE}}    │
└─────────────────────────────────────────┘
```

## Platform Behavior Matrix

| Feature | Mobile (PWA) | Desktop Web | Native (if applicable) |
|---------|-------------|-------------|----------------------|
| Navigation | Bottom nav | Side nav | {{NATIVE_NAV}} |
| Layout | Single column | Multi-column | {{NATIVE_LAYOUT}} |
| Offline | {{OFFLINE_STRATEGY}} | {{OFFLINE_STRATEGY}} | {{NATIVE_OFFLINE}} |
| Auth flow | Magic link / OAuth | Same | {{NATIVE_AUTH}} |
| File upload | Camera + gallery | Drag & drop | {{NATIVE_UPLOAD}} |

## Core Domain Entities

| Entity | Description | Key Fields |
|--------|-------------|------------|
| {{ENTITY_1}} | {{DESCRIPTION}} | {{FIELDS}} |
| {{ENTITY_2}} | {{DESCRIPTION}} | {{FIELDS}} |
| {{ENTITY_3}} | {{DESCRIPTION}} | {{FIELDS}} |
| {{ENTITY_4}} | {{DESCRIPTION}} | {{FIELDS}} |

## Core Feature Modules

| # | Module | Sprint | Priority | Description |
|---|--------|--------|----------|-------------|
| 1 | {{MODULE_1}} | Sprint 1 | Tier 1 | {{DESCRIPTION}} |
| 2 | {{MODULE_2}} | Sprint 1-2 | Tier 1 | {{DESCRIPTION}} |
| 3 | {{MODULE_3}} | Sprint 2 | Tier 1 | {{DESCRIPTION}} |
| 4 | {{MODULE_4}} | Sprint 3 | Tier 2 | {{DESCRIPTION}} |
| 5 | {{MODULE_5}} | Sprint 3-4 | Tier 2 | {{DESCRIPTION}} |
| 6 | {{MODULE_6}} | Sprint 4 | Tier 3 | {{DESCRIPTION}} |

## Route Map

| Path | View | Auth Required | Description |
|------|------|---------------|-------------|
| `/` | {{LANDING_VIEW}} | No | {{DESCRIPTION}} |
| `/login` | {{LOGIN_VIEW}} | No | {{DESCRIPTION}} |
| `/dashboard` | {{DASHBOARD_VIEW}} | Yes | {{DESCRIPTION}} |
| {{ROUTE_4}} | {{VIEW_4}} | {{AUTH}} | {{DESCRIPTION}} |
| {{ROUTE_5}} | {{VIEW_5}} | {{AUTH}} | {{DESCRIPTION}} |
| {{ROUTE_6}} | {{VIEW_6}} | {{AUTH}} | {{DESCRIPTION}} |

## Deployment Targets

| Environment | URL | Branch | Auto-deploy |
|-------------|-----|--------|-------------|
| Development | `localhost:{{PORT}}` | — | — |
| Staging | {{STAGING_URL}} | `staging` | Yes |
| Production | {{PRODUCTION_URL}} | `main` | After approval |

## Verification Checklist

Before each sprint completion, verify:

- [ ] All acceptance criteria met
- [ ] Tests passing with coverage ≥ {{COVERAGE_TARGET}}%
- [ ] No TypeScript/lint errors
- [ ] Responsive on mobile + desktop
- [ ] Spec delta documented (ADDED/MODIFIED/REMOVED in sprint tracker)
- [ ] Docs updated (`/sprint-update`)
- [ ] Sprint tracker current

## Change Tracking

This spec represents the **current state** of the system — it is updated in-place.

For the **change history** (what was added, modified, or removed and when), see:
- `docs/spec-changelog.md` — Cumulative delta log (append-only, per sprint)
- `docs/sprint-tracker.md` — Inline `### Spec Delta` section per completed sprint

**Convention:** When this spec is updated via `/sprint-update`, also append the corresponding delta entry to `docs/spec-changelog.md`. See `guides/10-delta-tracking.md` for the full convention.

<!--
INSTRUCTIONS FOR FILLING THIS TEMPLATE:

1. Replace all {{PLACEHOLDER}} tokens with your project's actual values
2. Remove any sections that don't apply to your project
3. Add sections if your project has unique architectural concerns
4. Keep the file under 200 lines — this is loaded into AI context on every interaction
5. Update this file when major architectural decisions change
6. Use specific, concrete values — avoid vague descriptions
7. This file is the "what IS" — always reflects current truth
8. For "what CHANGED" history, see docs/spec-changelog.md

EXAMPLES:
- Saranidhi (Flutter): Language=Dart, Framework=Flutter, State=Riverpod, DB=Supabase
- Nidhi Seermai (Vue/TS): Language=TypeScript, Framework=Vue 3, State=Pinia, DB=Supabase
-->

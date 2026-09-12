[← Back to Root](../../README.md)

# {{PROJECT_NAME}} — Spec Changelog

> Cumulative record of all specification changes, ordered by sprint (newest first).
> This file is **append-only** — entries are never rewritten or removed.

---

## Sprint 4: Release Preparation

**Date:** {{DATE}} | **PR:** #{{N}}

### ADDED
- Security hardening: [specific measures implemented]
- Production deployment: `prod` branch → {{PRODUCTION_PLATFORM}}
- Smoke test plan: [X] pre-production scenarios

### MODIFIED
- Coverage threshold: raised to {{FINAL}}% (was: {{INITIAL}}%)

### REMOVED
- (none)

### Rationale
Production readiness. Security review surfaced no critical issues. Coverage raised
to reflect mature codebase with established testing patterns.

---

## Sprint 3: Polish & Extended Features

**Date:** {{DATE}} | **PR:** #{{N}}

### ADDED
- Dark mode / theming: CSS custom properties, system preference detection, localStorage persistence
- {{FEATURE_7}}: [description of new capability]
- {{FEATURE_8}}: [description]
- E2E test suite: [X] critical path scenarios

### MODIFIED
- Navigation: [new pattern] (was: [old pattern])
- [Other behavioral change]: [was X, now Y]

### REMOVED
- [Deprecated feature]: [reason for removal]

### Rationale
UI polish sprint. Dark mode was top user request. Navigation restructured based
on usability feedback from Sprint 2 staging deployment.

---

## Sprint 2: Feature Expansion

**Date:** {{DATE}} | **PR:** #{{N}}

### ADDED
- {{FEATURE_4}}: [description of new capability]
- {{FEATURE_5}}: [description]
- Dashboard analytics: KPI cards, charts, summary metrics
- Responsive layout: mobile-first with 1200px max-width on desktop

### MODIFIED
- [Changed behavior]: [was X, now Y]

### REMOVED
- (none)

### Rationale
Core feature expansion. Dashboard provides at-a-glance project health metrics.
Responsive layout ensures usability across device spectrum.

---

## Sprint 1: Core Foundation

**Date:** {{DATE}} | **PR:** #{{N}}

### ADDED
- Core data entity: `{{ENTITY_NAME}}` with full CRUD operations
- Authentication flow: login, logout, register, session management
- Route guard: unauthenticated → `/login`, authenticated at `/login` → `/dashboard`
- Navigation structure: {{NAVIGATION_PATTERN}}
- Unit test foundation: {{COUNT}} assertions
- CI pipeline: lint + test + build on every PR

### MODIFIED
- (none — first feature sprint)

### REMOVED
- (none — first feature sprint)

### Rationale
Foundation sprint establishing core data model, authentication, and navigation.
All subsequent features build on this scaffold.

---

## Sprint 0: Project Setup

**Date:** {{DATE}} | **PR:** — (initial commit)

### ADDED
- Project scaffold: {{FRAMEWORK}} + {{STATE_MANAGEMENT}} + {{ROUTING}}
- Database schema: bootstrap migration (`000_create_schema_migrations.sql`)
- CI pipeline: GitHub Actions (lint + test + build)
- Pre-commit hooks: Lefthook (format + lint)
- Deployment configuration: Vercel/{{HOSTING}}
- Steering file: `.kiro/steering/{{SPEC_FILE}}`
- Documentation scaffold: dev-workflow, sprint-tracker, project-plan, testing-plan, release-plan

### MODIFIED
- (none — initial setup)

### REMOVED
- (none — initial setup)

### Rationale
Project initialization. Zero-to-scaffold with all engineering infrastructure in place
before any feature work begins.

---

<!--
SPEC CHANGELOG CONVENTIONS:

FORMAT:
- Newest sprint at top (reverse chronological)
- Each entry: sprint title, date, PR reference, ADDED/MODIFIED/REMOVED sections, rationale
- One line per item within each section
- Name specific entities, types, components, routes, or behaviors
- For MODIFIED: include "was X, now Y" where helpful

WHAT COUNTS AS A DELTA:
- New database column/table/entity
- New route or view
- New component or UI pattern
- Changed business rule or behavior
- Removed/deprecated feature
- Changed constraint or validation

WHAT DOESN'T COUNT:
- Bug fixes (behavior was already specified, just broken)
- Refactoring (no spec-level change)
- Performance improvements (same behavior, faster)
- Test additions (verification, not behavior)
- CI/tooling/dependency changes

WHEN TO UPDATE:
- During /sprint-update protocol (after each sprint merge)
- During /hotfix (if the fix changes spec-level behavior)
- During /plan (if scope is cut — REMOVED entries)

RELATIONSHIP TO OTHER FILES:
- This file = "what CHANGED over time" (append-only history)
- .kiro/steering/spec = "what IS now" (updated in-place)
- docs/sprint-tracker.md = "what changed THIS sprint" (inline, lightweight)

INSPIRED BY:
- OpenSpec (Fission-AI) delta spec concept: ADDED/MODIFIED/REMOVED format
- Adapted for sprint-based, Kiro-first workflow without CLI tooling

See guides/10-delta-tracking.md for full documentation of this convention.
-->

[← Back to Root](../../README.md)

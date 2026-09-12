# Project Valuation Report

> **Reviewed:** vX.Y.Z · **Next review:** every `/sprint-update` + `/release-update`.
> **Minimalist by design:** hours-per-phase + one-row-per-sprint delivery + exec summary.
> Do **not** add a per-commit timeline (→ `git log`) or a per-feature deliverables list
> (→ `sprint-tracker.md` + `CHANGELOG.md`) — those duplicate and rot.

## Executive Summary

**Project:** {{PROJECT_NAME}}
**Methodology:** AI-assisted development with Kiro (AI+20% rule applied)
**Total Investment:** {{TOTAL_HOURS}} hours
**Equivalent Traditional Estimate:** {{TRAD_HOURS}} hours
**Efficiency Multiplier:** {{MULTIPLIER}}x

## Commit Metadata Timeline

| Sprint | Commits | First Commit | Last Commit | Duration |
|--------|---------|--------------|-------------|----------|
| Sprint 0 | {{N}} | {{DATE}} | {{DATE}} | {{N}} days |
| Sprint 1 | {{N}} | {{DATE}} | {{DATE}} | {{N}} days |
| Sprint 2 | {{N}} | {{DATE}} | {{DATE}} | {{N}} days |
| Sprint 3 | {{N}} | {{DATE}} | {{DATE}} | {{N}} days |
| Sprint 4 | {{N}} | {{DATE}} | {{DATE}} | {{N}} days |
| Sprint 5 | {{N}} | {{DATE}} | {{DATE}} | ongoing |

**Total commits:** {{TOTAL_COMMITS}}
**Average commits/sprint:** {{AVG_COMMITS}}

## Time Investment Breakdown

### Session Log

| # | Date | Sprint | Duration | Focus Area | Output |
|---|------|--------|----------|------------|--------|
| 1 | {{DATE}} | 0 | {{N}}h | Project setup | Repo, CI, steering |
| 2 | {{DATE}} | 1 | {{N}}h | Core model | Schema, CRUD, auth |
| 3 | {{DATE}} | 1 | {{N}}h | UI foundation | Layout, nav, views |
| 4 | {{DATE}} | 2 | {{N}}h | Features | {{FEATURE}} |
| 5 | {{DATE}} | 2 | {{N}}h | Dashboard | Charts, analytics |
| 6 | {{DATE}} | 3 | {{N}}h | Polish | Theming, responsive |
| 7 | {{DATE}} | 3 | {{N}}h | Testing | E2E, coverage push |
| 8 | {{DATE}} | 4 | {{N}}h | Release prep | Security, smoke tests |
| 9 | {{DATE}} | 4 | {{N}}h | Deployment | Production rollout |
| 10 | {{DATE}} | 5 | {{N}}h | Post-launch | Monitoring, fixes |

### Infrastructure Time (Non-Session)

| Category | Hours | Description |
|----------|-------|-------------|
| Environment setup | {{N}}h | Node, deps, Supabase config |
| CI/CD debugging | {{N}}h | Pipeline failures, config |
| Deployment config | {{N}}h | Hosting setup, DNS, SSL |
| Code review | {{N}}h | PR review, feedback cycles |
| Documentation | {{N}}h | Guides, plans, steering |
| **Subtotal** | **{{N}}h** | — |

### Total Investment

| Category | Raw Hours | +20% Overhead | Final |
|----------|-----------|---------------|-------|
| AI-assisted sessions | {{N}}h | +{{N}}h | {{N}}h |
| Infrastructure | {{N}}h | — | {{N}}h |
| **Total** | **{{N}}h** | — | **{{TOTAL}}h** |

## Sprint Delivery with Hours

| Sprint | Deliverables | Hours | Cost @${{RATE}}/hr |
|--------|-------------|-------|-----|
| Sprint 0 | Scaffolding, CI, docs | {{N}}h | ${{N}} |
| Sprint 1 | Core model, auth, nav | {{N}}h | ${{N}} |
| Sprint 2 | Features, dashboard | {{N}}h | ${{N}} |
| Sprint 3 | Polish, testing, theme | {{N}}h | ${{N}} |
| Sprint 4 | Security, release, deploy | {{N}}h | ${{N}} |
| Sprint 5 | Post-launch, v1.1 | {{N}}h | ${{N}} |
| **Total** | — | **{{TOTAL}}h** | **${{TOTAL}}** |

## Technical Deliverables

| Category | Count | Details |
|----------|-------|---------|
| Views/Pages | {{N}} | Full application UI |
| Components | {{N}} | Reusable UI elements |
| Store modules | {{N}} | State management units |
| Service files | {{N}} | API/data layer |
| Database tables | {{N}} | With RLS policies |
| Migrations | {{N}} | Idempotent, versioned |
| Test files | {{N}} | Unit + integration + E2E |
| CI workflows | {{N}} | Lint, test, build, deploy |
| Documentation files | {{N}} | Guides, plans, specs |

### Lines of Code (Approximate)

| Language | Source | Tests | Total |
|----------|--------|-------|-------|
| {{LANGUAGE_1}} | {{N}} | {{N}} | {{N}} |
| {{LANGUAGE_2}} | {{N}} | {{N}} | {{N}} |
| SQL | {{N}} | — | {{N}} |
| YAML/Config | {{N}} | — | {{N}} |
| Markdown | {{N}} | — | {{N}} |
| **Total** | **{{N}}** | **{{N}}** | **{{N}}** |

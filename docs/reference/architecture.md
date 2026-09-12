# Architecture Reference

> **Reviewed:** vX.Y.Z · **Next review:** every release (or when infra/schema/patterns change).

## Intent & Objectives

**Project:** {{PROJECT_NAME}}
**Purpose:** {{ONE_PARAGRAPH_DESCRIPTION}}

**Primary Objectives:**
1. {{OBJECTIVE_1}}
2. {{OBJECTIVE_2}}
3. {{OBJECTIVE_3}}

**Success Criteria:**
- {{METRIC_1}}
- {{METRIC_2}}
- {{METRIC_3}}

## Core Feature Modules

### Tier 1 — Must Have (Release 1.0)

| # | Module | Sprint | Description | Acceptance Criteria |
|---|--------|--------|-------------|---------------------|
| 1 | {{MODULE_1}} | 1 | {{DESCRIPTION}} | {{CRITERIA}} |
| 2 | {{MODULE_2}} | 1 | {{DESCRIPTION}} | {{CRITERIA}} |
| 3 | {{MODULE_3}} | 1-2 | {{DESCRIPTION}} | {{CRITERIA}} |
| 4 | {{MODULE_4}} | 2 | {{DESCRIPTION}} | {{CRITERIA}} |
| 5 | {{MODULE_5}} | 2-3 | {{DESCRIPTION}} | {{CRITERIA}} |

### Tier 2 — Should Have (Release 1.1)

| # | Module | Sprint | Description | Acceptance Criteria |
|---|--------|--------|-------------|---------------------|
| 6 | {{MODULE_6}} | 3 | {{DESCRIPTION}} | {{CRITERIA}} |
| 7 | {{MODULE_7}} | 3-4 | {{DESCRIPTION}} | {{CRITERIA}} |
| 8 | {{MODULE_8}} | 4 | {{DESCRIPTION}} | {{CRITERIA}} |

### Tier 3 — Nice to Have (Release 2.0)

| # | Module | Sprint | Description | Acceptance Criteria |
|---|--------|--------|-------------|---------------------|
| 9 | {{MODULE_9}} | 5+ | {{DESCRIPTION}} | {{CRITERIA}} |
| 10 | {{MODULE_10}} | 5+ | {{DESCRIPTION}} | {{CRITERIA}} |

## Data Architecture

### Primary Schema

| Table | Description | Key Columns |
|-------|-------------|-------------|
| `{{TABLE_1}}` | {{DESCRIPTION}} | `id`, `user_id`, `created_at`, {{COLUMNS}} |
| `{{TABLE_2}}` | {{DESCRIPTION}} | `id`, `user_id`, `created_at`, {{COLUMNS}} |
| `{{TABLE_3}}` | {{DESCRIPTION}} | `id`, `{{FK}}`, `created_at`, {{COLUMNS}} |
| `{{TABLE_4}}` | {{DESCRIPTION}} | `id`, `user_id`, {{COLUMNS}} |

### Entity Relationships

```
{{TABLE_1}} ──┐
              ├──▶ {{TABLE_3}} (via {{FK}})
{{TABLE_2}} ──┘
              │
              ▼
         {{TABLE_4}}
```

### Row-Level Security

| Table | Policy | Rule |
|-------|--------|------|
| `{{TABLE_1}}` | Users see own data | `auth.uid() = user_id` |
| `{{TABLE_2}}` | Users see own data | `auth.uid() = user_id` |
| `{{TABLE_3}}` | Access via parent | `auth.uid() = (SELECT user_id FROM {{TABLE_1}} WHERE id = {{FK}})` |
| `{{TABLE_4}}` | Users manage own | `auth.uid() = user_id` |

## Interface Blueprint

### Route Map

| Path | Component | Auth | Layout | Description |
|------|-----------|------|--------|-------------|
| `/` | LandingView | No | Minimal | Marketing/intro page |
| `/login` | LoginView | No | Minimal | Auth entry point |
| `/dashboard` | DashboardView | Yes | AppLayout | Main overview |
| `/{{RESOURCE}}/new` | {{Resource}}FormView | Yes | AppLayout | Create new |
| `/{{RESOURCE}}/:id` | {{Resource}}DetailView | Yes | AppLayout | View/edit |
| `/{{RESOURCE}}` | {{Resource}}ListView | Yes | AppLayout | Browse all |
| `/settings` | SettingsView | Yes | AppLayout | User preferences |
| `/analytics` | AnalyticsView | Yes | AppLayout | Charts & insights |

### Layout Structure

```
┌──────────────────────────────────────┐
│            App Header                 │  ← Branding + user menu
├──────────────────────────────────────┤
│                                      │
│           Main Content               │  ← Router view
│                                      │
│                                      │
├──────────────────────────────────────┤
│         Bottom Navigation            │  ← Mobile: bottom nav
└──────────────────────────────────────┘     Desktop: side nav
```

## Platform & Deployment

| Aspect | Choice | Rationale |
|--------|--------|-----------|
| Hosting | {{HOSTING_PLATFORM}} | {{REASON}} |
| Database | {{DATABASE_PROVIDER}} | {{REASON}} |
| Auth | {{AUTH_PROVIDER}} | {{REASON}} |
| Storage | {{STORAGE_PROVIDER}} | {{REASON}} |
| CDN | {{CDN_PROVIDER}} | {{REASON}} |
| Domain | {{DOMAIN}} | — |

### Environment Configuration

| Variable | Development | Staging | Production |
|----------|-------------|---------|------------|
| `{{PREFIX}}_URL` | `http://localhost:{{PORT}}` | {{STAGING_URL}} | {{PRODUCTION_URL}} |
| `{{PREFIX}}_ANON_KEY` | `dev-key` | `staging-key` | `prod-key` |
| `{{PREFIX}}_SERVICE_KEY` | `dev-service` | — | — |

## CI/CD Pipeline

| Stage | Tool | Trigger | Actions |
|-------|------|---------|---------|
| Lint | GitHub Actions | Push | Format + static analysis |
| Test | GitHub Actions | Push | Unit + integration tests |
| Build | GitHub Actions | Push | Compile + bundle |
| E2E | GitHub Actions | PR to main | Browser tests |
| Deploy (staging) | {{DEPLOY_TOOL}} | Merge to main | Auto-deploy |
| Deploy (production) | {{DEPLOY_TOOL}} | Manual | After approval |

## Security & Privacy

| Concern | Approach | Status |
|---------|----------|--------|
| Authentication | {{AUTH_METHOD}} | {{STATUS}} |
| Authorization | Row-Level Security | {{STATUS}} |
| Data at rest | {{ENCRYPTION}} | {{STATUS}} |
| Data in transit | HTTPS/TLS | {{STATUS}} |
| Input validation | {{VALIDATION_LIB}} | {{STATUS}} |
| Secrets management | Environment variables | {{STATUS}} |
| CORS | Restricted origins | {{STATUS}} |
| Rate limiting | {{RATE_LIMIT_APPROACH}} | {{STATUS}} |

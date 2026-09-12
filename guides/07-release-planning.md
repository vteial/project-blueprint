# Guide: Release Planning

## Release Numbering

```
v[MAJOR].[MINOR].[PATCH]

v1.0.0 — First production release (all Tier 1 features)
v1.1.0 — Post-launch improvements (Tier 2 features)
v2.0.0 — Major new capabilities (Tier 3 / breaking changes)
v1.0.1 — Hotfix (bug fix, no new features)
```

| Increment | When | Example |
|-----------|------|---------|
| MAJOR | Breaking changes, architectural shifts | v1 → v2 |
| MINOR | New features, backward-compatible | v1.0 → v1.1 |
| PATCH | Bug fixes only | v1.0.0 → v1.0.1 |

## Priority Tiers

### Tier 1 — Must Have

**Criteria:** Without this, the product doesn't work or doesn't solve the core problem.

| Signal | Example |
|--------|---------|
| Core user flow depends on it | Login, create expense, view dashboard |
| No workaround exists | Can't use the app without it |
| Blocking other features | Auth blocks everything else |

### Tier 2 — Should Have

**Criteria:** Product works without it, but is significantly less useful or polished.

| Signal | Example |
|--------|---------|
| Enhances core flow | Search, filtering, sorting |
| Workaround exists but is painful | Manual date entry vs calendar picker |
| Users will request it quickly | Dark mode, export functionality |

### Tier 3 — Nice to Have

**Criteria:** Would be great to have, but product is viable without it.

| Signal | Example |
|--------|---------|
| Advanced use case | OCR receipt scanning |
| Niche audience benefit | Multi-currency support |
| Future platform | Native mobile (Capacitor) |

## Sprint-to-Release Mapping

### Universal Sequence

Every project follows a predictable arc:

| Sprint | Focus | Release Role |
|--------|-------|-------------|
| Sprint 0 | Project setup, scaffolding | Infrastructure |
| Sprint 1 | Core foundation (auth, data model) | Building blocks |
| Sprint 2 | Feature expansion (Tier 1 breadth) | Feature-complete target |
| Sprint 3 | Polish, Tier 2, testing | Release candidate |
| Sprint 4 | Security review, deployment | **Release sprint** |
| Sprint 5+ | Post-launch, v1.1 features | Next version |

### Adjusting for Project Size

| Project Size | Sprints to v1.0 | Sprint Duration |
|-------------|-----------------|-----------------|
| Small (MVP, 5-8 features) | 3-4 sprints | 1 week each |
| Medium (10-15 features) | 4-6 sprints | 1-2 weeks each |
| Large (20+ features) | 6-8 sprints | 2 weeks each |

## Scope Cut Decision Framework

When a sprint is running long, use this framework:

| Question | If Yes | If No |
|----------|--------|-------|
| Is this Tier 1? | Keep it, extend sprint | Cut to next sprint |
| Does it block other Tier 1 work? | Keep it | Cut it |
| Is it > 50% complete? | Finish it this sprint | Cut it |
| Can a simpler version ship? | Ship simple, enhance later | Cut the whole thing |
| Is the deadline hard? | Cut to meet deadline | Consider extending |

### Scope Cut Template

```
Feature: [name]
Decision: Defer to [Sprint N / v1.1 / v2.0]
Reason: [why]
Simpler version shipped: [yes/no — what was shipped instead]
```

## Definition of Done

### Per Sprint

- [ ] All planned Tier 1 tasks complete
- [ ] Tests passing, coverage meets threshold
- [ ] Zero lint/type errors
- [ ] Responsive on mobile + desktop
- [ ] Sprint tracker updated
- [ ] Documentation synced (`/sprint-update`)
- [ ] PR reviewed and merged

### Per Release

- [ ] All Tier 1 features complete and tested
- [ ] Security review complete (all checks pass)
- [ ] Smoke tests executed (100% critical pass)
- [ ] Performance meets targets
- [ ] Coverage at release threshold (≥70%)
- [ ] All documentation current
- [ ] Deployment tested on staging
- [ ] Rollback procedure documented and tested
- [ ] Environment variables configured
- [ ] Release notes written
- [ ] Stakeholder sign-off (if applicable)

## Risk Register

### Template

| ID | Risk | Probability | Impact | Mitigation | Status |
|----|------|-------------|--------|------------|--------|
| R-001 | [What could go wrong] | Low/Med/High | Low/Med/High | [How to prevent/recover] | Open/Mitigated |

### Common Risks

| Risk | Typical Mitigation |
|------|-------------------|
| Database migration fails in production | Test on staging; idempotent migrations; backup before |
| Auth provider has outage | Graceful degradation; session caching; status page monitoring |
| Bundle too large for mobile | Lazy loading; code splitting; size budget in CI |
| Third-party API changes | Version pinning; abstraction layer; integration tests |
| Data loss during migration | Always additive migrations; never DROP without backup |
| Performance regression | Performance tests in CI; lighthouse budget |

## Known Limitations Table

Be honest about what doesn't work yet:

| Limitation | Impact | Workaround | Fix Version |
|------------|--------|------------|-------------|
| No offline mode | Low — requires internet | N/A | v2.0 |
| Single currency | Medium — USD only | Manual conversion | v1.1 |
| No data export | Low — data in DB only | Direct DB access | v1.1 |
| No multi-user | Medium — single user only | Separate accounts | v2.0 |

**Why document limitations?**
- Sets honest expectations
- Guides v1.1/v2.0 planning
- Prevents "why doesn't this work?" questions
- Shows awareness (not ignorance) of gaps

## Real-World Timelines

### Nidhi Seermai (Vue/TS Expense Tracker)

| Milestone | Sprint | Calendar | Hours |
|-----------|--------|----------|-------|
| First commit | Sprint 0 | Day 1 | — |
| Auth working | Sprint 1 | Day 3 | 9.6h |
| Feature-complete | Sprint 2 | Day 8 | 21.6h |
| Release candidate | Sprint 3 | Day 14 | 34.8h |
| v1.0 deployed | Sprint 4 | Day 18 | 42.0h |
| v1.1 started | Sprint 5 | Day 20 | ongoing |

### Saranidhi (Flutter Freelancer Tool)

| Milestone | Sprint | Calendar | Hours |
|-----------|--------|----------|-------|
| First commit | Sprint 0 | Day 1 | — |
| Core model | Sprint 1 | Day 4 | 12h |
| Feature-complete | Sprint 3 | Day 12 | 36h |
| v1.0 deployed | Sprint 4 | Day 16 | 44h |

## When to Plan

| Question | Answer |
|----------|--------|
| When to create release plan? | Sprint 2 or 3 (once features are taking shape) |
| When to set release date? | Sprint 3 (after feature-complete assessment) |
| When to freeze scope? | Start of release sprint (Sprint 4 typically) |
| When to write release notes? | End of release sprint, before deploy |
| When to plan v1.1? | After v1.0 deploys (Sprint 5) |

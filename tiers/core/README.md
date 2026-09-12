# Core tier — long-lived products

> The full model: all 4 flows, sprint + release dossiers, freshness stamps, and the
> docs-audit gate. Use this for products you'll ship repeatedly over many sprints.
> Everything here is the generalized form of the proven source project.

See [`../../PRINCIPLES.md`](../../PRINCIPLES.md) first, then [`../README.md`](../README.md)
for the tier comparison.

---

## What Core gives you

The repository's `docs/`, `.kiro/`, `.github/`, and `templates/` folders **are** the
Core tier — Core is the default shape of this blueprint. Adopting Core = using the repo
as a template as-is.

| Area | Where | Owns |
| :--- | :--- | :--- |
| Operating model | [`AI_COLLABORATION_FRAMEWORK.md`](../../AI_COLLABORATION_FRAMEWORK.md) *(add per project)* | Roles, the 4 flows, handoffs, gates |
| Protocols & CI | [`docs/process/dev-workflow.md`](../../docs/process/dev-workflow.md) | `/sprint-*`, `/release-*`, `/plan`, `/delegate`, `/hotfix`; two-tier CI |
| Sprint state | `docs/process/sprint-tracker.md` + `sprint-backlog.md` | Delivered/in-progress + candidate work |
| Delivery & quality | `docs/process/project-valuation-report.md` + `project-evaluation.md` | Hours/delivery + defects/quality (no overlap) |
| Sprint dossiers | `docs/process/sprints/sprint-N-*/` | Flow 3 record: spec + impl-summary + test-summary + index |
| Release dossiers | `docs/testing/releases/` | Flow 4 record: smoke-test + release-notes + docs-audit `-vX.Y.Z.md` |
| Templates | `docs/process/templates/` | Skeletons for every dossier + the docs-audit gate |
| Reference | `docs/reference/` | Architecture, security-review (standing facts) |
| Product | `docs/product/` | Scope + user guide |
| Corpus (Flows 1&2) | `docs/research/` | Doctrine/source knowledge + conflict tracker — **only if your product has one** |

---

## Adopt Core

1. **Use this template** to create the repo (Core is the default layout).
2. Fill placeholders in `.kiro/steering/project-spec-template.md`.
3. Create `AI_COLLABORATION_FRAMEWORK.md` from the model in [`../../PRINCIPLES.md`](../../PRINCIPLES.md)
   (name your two agent tools in §1).
4. Pick a CI template from `templates/ci/` → `.github/workflows/`.
5. Seed `docs/process/sprint-tracker.md` with Sprint 0.
6. **Flows 1 & 2 are optional** — keep `docs/research/` only if your product is built on
   a body of source knowledge. If not, delete it; you'll run Flows 3 & 4 only (which is
   what Min does — Core without a corpus is just Min with more ceremony).

## Freshness discipline (the anti-rot machinery)

- Every durable doc carries `> **Reviewed:** vX.Y.Z` near the top.
- `/release-start` creates `docs/testing/releases/docs-audit-vX.Y.Z.md`; the **human
  ticks it** during release; `/release-update` confirms PASS and bumps stamps.
- When a protocol/gate/flow changes, update `dev-workflow.md` **and** the framework in
  the **same PR** so they never drift.

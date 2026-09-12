# Project Blueprint

> A GitHub **template repository** for AI-assisted development — the proven operating
> model distilled from a real, long-lived project, packaged so any new project can start
> from it and customize on the go.

**Tool-agnostic.** It describes **roles** (a planning/review agent + a coding/verify
agent + the human lead), not specific tools — use [Kiro](https://kiro.dev), another AI
coding tool, or work the conventions manually.

---

## Start here

1. **[`PRINCIPLES.md`](PRINCIPLES.md)** — the 5 load-bearing principles + the 4-flow spine. Read this first; everything else is elaboration.
2. **[`tiers/README.md`](tiers/README.md)** — pick your starting point: **Core** (long-lived product) or **Min** (quick/mini/PoC). It's the same principles, more or less machinery.
3. Use this template → fill placeholders → delete what you don't need.

## The 5 principles (in one breath)

1. **The human is the sole merge & release authority** — agents open PRs, never merge/tag.
2. **One source of truth per fact** — docs delegate, they don't duplicate (rot lives in copies).
3. **Transactional artifacts + a freshness stamp** — versioned, human-ticked records; `> Reviewed: vX.Y.Z` on every durable doc.
4. **Spec → implement → review** — plan writes the spec + green baseline, coder proves green locally, planner reviews the real diff.
5. **Provenance** — every non-obvious rule cites its source, so quality is auditable.

## The 4 flows

| # | Flow | Universal? |
|---|------|-----------|
| 1 | **Knowledge Capture** (source → corpus) | Core-only (doctrine products) |
| 2 | **Conflict Resolution** (reconcile the corpus) | Core-only |
| 3 | **Feature / Engine Sprint** (spec → implement → review) | ✅ every project |
| 4 | **Release** (smoke → promote → tag) | ✅ every project |

Flows 3 & 4 are the tier floor; Flows 1 & 2 are what make a project **Core**. See
[`PRINCIPLES.md`](PRINCIPLES.md#the-4-flow-spine).

---

## Two tiers

| | **[Core](tiers/core/README.md)** | **[Min](tiers/min/README.md)** |
| :--- | :--- | :--- |
| For | Long-lived products | Quick / mini / PoC |
| Docs | Full `docs/` set + dossiers + stamps + docs-audit | One `README` + one `PROJECT.md` |
| Record | Sprint & release dossiers | The PR description (`Tested:`) |
| Flows | All 4 | 3 & 4, collapsed |

**Graduation rule:** a Min project adopts a heavier Core practice the **first time it
gets burned without it** — never preemptively. Start light; earn the weight.

## Usage

- **Use as template (recommended)** — "Use this template" on GitHub → new repo with the
  Core layout. Adopt Min by keeping only `tiers/min/`'s two skeletons.
- **Cherry-pick** — just CI? `templates/ci/`. Just the workflow? `docs/process/dev-workflow.md`.
- **Reference** — read `guides/` to understand the *why*, implement your own way.

## Repository Structure

```
project-blueprint/
├── PRINCIPLES.md                     # ★ the 5 principles + 4-flow spine (read first)
├── tiers/
│   ├── README.md                     # tier decision guide + graduation rule
│   ├── core/README.md                # Core adoption
│   └── min/                          # Min adoption + the two skeletons
│       ├── README.md
│       ├── PROJECT.skeleton.md
│       └── README.skeleton.md
├── docs/                             # Core doc set (grouped by context)
│   ├── README.md                     # documentation index
│   ├── process/                      # how we build & ship
│   │   ├── dev-workflow.md           # protocols, CI gates, merge authority
│   │   ├── sprint-tracker.md · sprint-backlog.md
│   │   ├── project-valuation-report.md · project-evaluation.md
│   │   ├── release-plan.md · spec-changelog.md
│   │   ├── sprints/                  # per-sprint dossiers (Flow 3)
│   │   └── templates/                # spec · impl-summary · test-summary · release-notes · docs-audit
│   ├── product/                      # scope + user guide (add per project)
│   ├── testing/                      # testing-plan, smoke-test-*, releases/ (Flow 4 dossiers)
│   └── reference/                    # architecture, security-review
├── guides/                           # deep "why & how" for each convention
├── templates/                        # CI, lefthook, deployment, migrations
├── .kiro/steering/                   # auto-loaded project context template
├── .github/                          # PR + issue templates
├── .gitignore · LICENSE · README.md
```

## Responsibility split (tool-agnostic)

| Concern | Coding/Verify agent | Planning/Review agent | Human |
|---------|:-------------------:|:---------------------:|:-----:|
| Code generation | ● | — | — |
| Spec authoring | — | ● | approves |
| PR creation | ● | ● | — |
| PR review (real diff) | — | ● | final |
| Merge & tag | — | — | ● (sole) |
| Doctrine/priorities | — | scribes | ● (decides) |

---

## Delta tracking (preserved convention)

Record WHAT changed (ADDED / MODIFIED / REMOVED) per sprint: the steering spec is
updated in-place (current truth), the spec-changelog is appended (evolution history).
See [`guides/10-delta-tracking.md`](guides/10-delta-tracking.md). This complements the
sprint dossier — the dossier is *this sprint's* transactional record; the spec-changelog
is the *cumulative* delta history.

## Quick Start (Core)

- [ ] Create repo from template
- [ ] Read `PRINCIPLES.md`; pick a tier in `tiers/README.md`
- [ ] Fill `.kiro/steering/project-spec-template.md` placeholders
- [ ] Add `AI_COLLABORATION_FRAMEWORK.md` (name your two agent tools)
- [ ] Pick CI from `templates/ci/` → `.github/workflows/`
- [ ] Seed Sprint 0 in `docs/process/sprint-tracker.md`
- [ ] `/sprint-start 1`

## License

MIT — See [LICENSE](./LICENSE)

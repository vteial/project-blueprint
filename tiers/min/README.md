# Min tier — quick / mini / PoC

> The compact model. Flows 3 & 4 only, collapsed to the smallest footprint that keeps
> quality — **one README + one PROJECT.md, and the PR description is the record.** No
> dossiers, no stamps, no valuation, no corpus. Compact for fast delivery, with no
> compromise on the parts that matter.

See [`../../PRINCIPLES.md`](../../PRINCIPLES.md) and [`../README.md`](../README.md).

---

## The whole Min doc system (two files)

| File | Is | Skeleton |
| :--- | :--- | :--- |
| `README.md` | The project + a **Current Status** block + a short "how we work" section | [`README.skeleton.md`](README.skeleton.md) |
| `PROJECT.md` | Tracker **+** backlog **+** decisions, all in one file | [`PROJECT.skeleton.md`](PROJECT.skeleton.md) |

That's it. No `docs/` tree. The **PR description is the transactional record** — each PR
says what changed, why, and carries a `Tested:` line. Release notes live in the PR / the
GitHub Release.

---

## What Min keeps from the principles (non-negotiable)

- **Human is the sole merge & release authority.** The agent opens PRs; the human
  merges and tags. *This is never relaxed, even for a throwaway PoC.*
- **PR-as-record.** Every PR body: what changed · why · `Tested:` (how you verified).
- **Spec → review only when risky.** Trivial change → just do it + PR. Genuinely risky
  change (data migration, auth, money, irreversible action) → write a short spec in the
  PR description first and review the real diff.
- **One source of truth.** `PROJECT.md` is the single status doc; the README status
  block points at it rather than repeating it.

## What Min deliberately drops (until you're burned)

Sprint/release dossiers · `> Reviewed:` stamps · docs-audit gate · valuation/hours ·
`project-evaluation.md` · the `docs/` grouping · Flows 1 & 2 (Knowledge Capture +
Conflict Resolution). Add any of these only via the **graduation rule** in
[`../README.md`](../README.md#the-graduation-rule).

---

## Adopt Min

1. Copy `README.skeleton.md` → `README.md` and `PROJECT.skeleton.md` → `PROJECT.md`
   into your new repo (or delete everything else from a template checkout).
2. Fill the placeholders.
3. Ship: branch → PR (with `Tested:`) → **human merges**. Update the README status block
   + `PROJECT.md` when you cut a release.

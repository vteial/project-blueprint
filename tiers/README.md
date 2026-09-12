# Tiers — pick one starting point, then customize

> Two proven starting points, not a rigid classification. Pick the one that fits, copy
> its shape into your new project, and **customize on the go**. More choices would just
> be a decision tax — two is enough because the pick is almost always obvious.

See [`../PRINCIPLES.md`](../PRINCIPLES.md) for the model both tiers encode.

---

## Which tier?

| | **[Core](core/README.md)** | **[Min](min/README.md)** |
| :--- | :--- | :--- |
| **For** | Long-lived products you'll ship repeatedly | Quick / mini / PoC / throwaway-that-might-not-be |
| **Flows** | All 4 (incl. Knowledge Capture + Conflict Resolution) | Flows 3 & 4 only, collapsed |
| **Docs** | Full set, grouped `process/ product/ testing/ reference/` | One `README` (+ status block) + one `PROJECT.md` |
| **Per-sprint record** | Sprint **dossier** (spec + impl + test summary) | The PR description (`Tested:` line) |
| **Per-release record** | Release **dossier** (smoke-test + release-notes + docs-audit) | Release notes in the PR / GitHub Release |
| **Freshness** | `> Reviewed: vX.Y.Z` stamps + per-release docs-audit gate | Status block in the README, updated on release |
| **Spec → review** | Always, for non-trivial change | Only for genuinely risky change |
| **Time/valuation** | Tracked (AI-estimate + 20%) | Not tracked |
| **Overhead** | Higher — earns its weight over many sprints | Near-zero — compact, no quality compromise |

**Rule of thumb:** if the project has a *body of source knowledge* to capture and
reconcile (docs, standards, a domain corpus) → **Core** (you need Flows 1 & 2). If it's
"build the thing and ship it" → **Min**.

---

## The graduation rule

A **Min** project adopts a heavier **Core** practice the **first time it gets burned
without it** — never preemptively. Examples of a "burn" and what to graduate:

| The burn | Graduate to |
| :--- | :--- |
| A doc silently went stale and misled someone | `> Reviewed:` stamps + the docs-audit gate |
| A "done" feature was actually broken; the PR summary lied | spec → implement → **review the real diff** |
| Two docs disagreed on the same fact | one-source-of-truth: make one delegate to the other |
| A release shipped a regression the preview hid | the QA-Verify smoke gate (CI green, not just preview) |
| Nobody could reconstruct *why* a rule exists | provenance: cite the source in the spec |

This keeps Min genuinely light while giving it a clear, non-arbitrary path to Core —
you never carry a practice you haven't yet needed.

---

## What's shared regardless of tier

The [5 principles](../PRINCIPLES.md#the-5-load-bearing-principles) are **not**
tier-specific — both tiers obey them. The tiers only differ in *how much machinery*
each principle is expressed through. In particular, **principle 1 (the human is the
sole merge & release authority) is never relaxed**, in any tier.

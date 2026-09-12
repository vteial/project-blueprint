[← Back to Sprint Dossier](./README.md)

# Sprint NN — Implementation Spec

> **Authored by the planning/review agent** for the coding agent (Core tier, Flow 3).
> The coding agent implements this, runs `analyze` + tests **GREEN locally before the
> PR**, then the planning agent reviews the real diff. Correctness-critical work must
> be green locally — CI-only is not sufficient.

## 0. Pre-flight — environment + known-green baseline (do FIRST)

- Confirm the toolchain/versions per the project's dev-setup doc.
- Establish a **known-green baseline** before touching sprint code (never change core
  logic on top of an already-red suite): run `analyze` (expect clean) + the full test
  suite and record the baseline (note any *known/expected* failures explicitly).
- If `analyze` isn't clean, or tests show any failure beyond the known-expected set,
  **STOP and report before starting.**

## 1. Why (the change)

_What problem/behavior this sprint fixes or adds, and the authoritative source
(spec item / resolved conflict / reference) it derives from — see provenance._

## 2. Tasks (exact scope)

| Task | File(s) | Change |
| :--- | :--- | :--- |
| NN.1 | `path/...` | … |

## 3. Edge cases / migration

_Data migration (idempotent? fresh-install AND upgrade path?), boundaries, error paths._

## 4. Tests to add / update

_Unit / widget / integration. Name the explicit new cases._

## 5. Source-derived values to verify

_Any value taken from an external/authoritative source that the reviewer must
cross-verify before merge (flag it here so it isn't trusted blindly)._

## 6. Out of scope

_Explicitly deferred items._

## 7. Definition of Done

_Local `analyze` clean + full tests green before PR; the specific gate(s) for this
sprint (e.g. upgrade path tested, not just fresh install)._

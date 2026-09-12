[← Back to Smoke Test](../../testing/releases/smoke-test-vX.Y.Z.md)

# Docs Freshness Audit — vX.Y.Z

> **Human-run transactional gate** (the doc equivalent of the smoke test). Created at
> `/release-start`, ticked by the **human** during release verification, confirmed PASS
> at `/release-update`. Goal: no durable doc silently rots. A doc is "fresh" if its
> content AND its `> Reviewed:` stamp reflect this release.

## Release under audit

- **Version:** vX.Y.Z · **Sprint(s):** NN · **Audited by:** _(human)_ · **Date:** ____

## Freshness checklist

| ✓ | Doc | Verify | Stamp bumped? |
| :-: | :--- | :--- | :-: |
| ☐ | `README.md` | Current Status block, "how we work" | n/a |
| ☐ | `docs/README.md` | Index still matches the actual doc set | n/a |
| ☐ | `docs/process/project-valuation-report.md` | Exec summary, new sprint row, hours | ☐ |
| ☐ | `docs/process/project-evaluation.md` | Defects log + quality baseline current | ☐ |
| ☐ | `docs/process/sprint-tracker.md` | Sprint row flipped ✅; current-state note = new version | ☐ |
| ☐ | `docs/process/sprint-backlog.md` | Shipped items removed; next-up accurate | ☐ |
| ☐ | `docs/process/dev-workflow.md` | Any protocol/gate/threshold change captured | ☐ |
| ☐ | `docs/product/*` | Reflects features/behavior shipped | ☐ |
| ☐ | `docs/reference/architecture.md` | New infra/schema/patterns | ☐ |
| ☐ | `docs/reference/security-review.md` | Only if the data/network boundary changed (else N/A) | ☐ / N/A |
| ☐ | `docs/testing/testing-plan.md` | Test-count progression + new scenarios | ☐ |
| ☐ | `docs/testing/smoke-test-results.md` | New version row added | n/a |
| ☐ | `CHANGELOG.md` | Release date set (not "Pending") | n/a |
| ☐ | Sprint dossier `docs/process/sprints/sprint-NN-*/README.md` | Links spec → impl → test → PR → release | n/a |

> **Stamp rule:** each durable doc carries `> **Reviewed:** vX.Y.Z` near the top. A
> stamp older than the current version = a red flag to investigate here.

## Findings / doc fixes made this release

-

## Result

- **Docs audit:** ☐ PASS (all applicable rows ✅) — safe to close the release.

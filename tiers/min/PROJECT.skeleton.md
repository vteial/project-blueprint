# {{PROJECT_NAME}} — Project

> The single status doc for a **Min**-tier project: tracker + backlog + decisions in one
> file. If this file starts groaning under its own weight, that's your signal to
> graduate toward Core (see the blueprint's `tiers/README.md`).

## Now (in progress)

| Item | Status | PR |
| :--- | :--- | :--- |
| {{current work}} | 🚧 | #— |

## Next (backlog, roughly ordered)

- [ ] {{next item}}
- [ ] {{later item}}

## Done

| Item | Shipped | PR |
| :--- | :--- | :--- |
| {{shipped item}} | v0.1 | #— |

## Decisions & gotchas

> Capture the *why* at the moment you decide — this is the Min-tier memory layer.

| Date | Decision / gotcha | Why |
| :--- | :--- | :--- |
| {{YYYY-MM-DD}} | {{what was decided}} | {{rationale}} |

## How we work (Min)

- Branch → PR (body includes **what · why · `Tested:`**) → **human merges** (agent never merges/tags).
- Risky change (migration / auth / money / irreversible) → short spec in the PR first, review the real diff.
- Cut a release → update the README **Current Status** block + the Done table here.

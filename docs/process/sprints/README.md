[← Back to docs index](../../README.md)

# Sprint Dossiers (Core tier, Flow 3)

Each sprint gets a folder here: `sprint-N-<slug>/` containing the sprint's **transactional**
artifacts, co-located so a sprint is auditable by opening one folder.

```
sprints/
  sprint-N-<slug>/
    README.md                 ← index: links spec → impl → test → PR → release
    spec.md                   ← planning agent authors (from templates/sprint-spec.template.md)
    implementation-summary.md ← coding agent fills (what was built, deviations)
    test-summary.md           ← coding agent fills (results vs known baseline)
```

- Seed each folder from [`../templates/`](../templates/).
- The **planning agent** writes `spec.md`; the **coding agent** fills the two summaries;
  the human merges; `/sprint-update` finalizes the `README.md` index.
- *Durable/cumulative* docs (`sprint-tracker.md`, `sprint-backlog.md`, valuation,
  evaluation) stay at the `docs/process/` root — only *transactional* per-sprint docs
  live in a dossier.

> **Min tier** does not use dossiers — the PR description is the record. See
> [`tiers/min/README.md`](../../../tiers/min/README.md).

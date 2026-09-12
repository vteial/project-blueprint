# Guide: Delta Tracking — What Changed, When, and Why

> How to maintain a living change history alongside your evolving spec.

---

## Philosophy

Your steering file (`.kiro/steering/project-spec.md`) is the **current state** — it answers "how does the system work *right now*?"

But it doesn't answer:
- "What changed in Sprint 12?"
- "When did we add the tags feature?"
- "Why did we switch from free-text project names to FK references?"
- "What was removed and why?"

**Delta tracking** fills this gap. It records WHAT changed, WHEN it changed, and WHY — per sprint, cumulatively.

---

## The Two-Layer Model

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│  .kiro/steering/project-spec.md                                 │
│  ─────────────────────────────                                  │
│  "What IS" — the current state of the system                    │
│  Updated in-place via /sprint-update                           │
│  Always reflects the LATEST truth                               │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  docs/spec-changelog.md                                         │
│  ────────────────────────                                       │
│  "What CHANGED" — cumulative history of all spec changes        │
│  Appended (never rewritten) via /sprint-update                 │
│  Preserves the narrative of evolution                           │
│                                                                 │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  docs/sprint-tracker.md (inline delta summary)                  │
│  ─────────────────────────────────────────────                  │
│  "What changed THIS sprint" — lightweight per-sprint summary    │
│  Written during /sprint-update for quick reference             │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### How They Relate

| Layer | Answers | Updated | Format |
|-------|---------|---------|--------|
| Steering spec | "What is the system now?" | In-place (overwrite) | Full spec |
| Spec changelog | "What changed over time?" | Append-only | Delta entries per sprint |
| Sprint tracker | "What changed this sprint?" | Inline per sprint | Brief delta summary |

---

## Delta Format

### The Three Sections

Every delta entry uses three categories:

```markdown
### ADDED
- [New capability, type, entity, route, or behavior]

### MODIFIED
- [Changed behavior with brief "was X, now Y" note]

### REMOVED
- [Deprecated capability with brief reason]
```

### What Counts as a Delta

| Counts as Delta | Doesn't Count |
|-----------------|---------------|
| New database column/table | Bug fix (behavior was already specified) |
| New route or view | Refactoring (no spec-level change) |
| New entity/type field | Performance improvement (same behavior, faster) |
| Changed business rule | Test additions (verification, not behavior) |
| New UI component or pattern | CI/tooling changes |
| Removed feature or deprecated behavior | Documentation-only updates |
| Changed constraint or validation | Dependency upgrades |

**Rule of thumb:** If the steering spec should be updated to reflect the change, it's a delta.

---

## Sprint Tracker (Inline Delta)

In `docs/sprint-tracker.md`, each completed sprint includes a brief delta summary:

```markdown
## Sprint 12: Receipt Attachments ✅ Complete (Merged PR #32)

- [x] Task 12.1: Add receipt_url column via migration 006
- [x] Task 12.2: Create Supabase Storage bucket with RLS
- [x] Task 12.3: Build ReceiptUploader.vue component
- [x] Task 12.4: Implement upload to Supabase Storage
- [x] Task 12.5: Display receipt thumbnail in expense detail
- [x] Task 12.6: Implement receipt deletion with confirmation
- [x] Task 12.7: Add file type validation (JPEG, PNG, PDF ≤ 1MB)

### Spec Delta

**ADDED:**
- `receipt_url` field on `ProjectExpense` type (nullable string)
- Supabase Storage bucket `receipts` with user-scoped RLS
- `ReceiptUploader` component (drag/drop + click, 1MB limit)
- Receipt preview in expense detail view
- File type validation: JPEG, PNG, PDF only

**MODIFIED:**
- `ExpenseFormView`: now includes receipt upload section
- `ProjectExpenseInsert` type: added `receipt_url` field

**REMOVED:**
- (none)
```

This is lightweight — just enough to know what changed at a glance.

---

## Spec Changelog (Cumulative History)

`docs/spec-changelog.md` is the full history. It accumulates entries over time (append-only):

```markdown
# {{PROJECT_NAME}} — Spec Changelog

> Cumulative record of all specification changes, ordered by sprint.

---

## Sprint 13: Expense Browsing, Tagging & Bottom Navigation

**Date:** 2026-06-05 | **PR:** #35

### ADDED
- `tags` field on `ProjectExpense` type (string array, lowercase)
- GIN index on `tags` column for array queries
- `TagChipInput` component (autocomplete from existing tags)
- `/expenses` route — dedicated browse view with server-side filtering
- `BottomNavigation` component (5 tabs: Home, Browse, Calendar, Analytics, Settings)
- `browse.ts` Pinia store (filter state, server-side queries, pagination)

### MODIFIED
- Navigation: moved from drawer-based to bottom tab architecture
- `ExpenseFormView`: added tags input field
- Route map: 4 new authenticated routes added

### REMOVED
- Drawer-based primary navigation (replaced by bottom tabs)
- Feed filter bar on Dashboard (moved to dedicated Browse view)

---

## Sprint 12: Receipt Attachments

**Date:** 2026-06-05 | **PR:** #32

### ADDED
- `receipt_url` field on `ProjectExpense` type (nullable string)
- Supabase Storage bucket `receipts` with user-scoped RLS
- `ReceiptUploader` component (drag/drop + click, 1MB limit)
- Receipt preview in expense detail view
- Migration `006_add_receipt_url.sql`
- Migration `007_add_receipts_storage_rls.sql`

### MODIFIED
- `ExpenseFormView`: includes receipt upload section
- `ProjectExpenseInsert` type: added `receipt_url` field

### REMOVED
- (none)

---

## Sprint 11: Expense Enhancements — Logged Date & Notes

**Date:** 2026-06-05 | **PR:** #25

### ADDED
- `logged_date` field on `ProjectExpense` (nullable DATE)
- `notes` field on `ProjectExpense` (nullable TEXT, ~500 chars)
- Date picker in expense form for transaction date
- Notes textarea in expense form
- Migration `005_add_logged_date_notes.sql`

### MODIFIED
- Feed sort: one-time items now sort by `logged_date` (fallback `created_at`)
- `ProjectExpenseInsert` type: added `logged_date` and `notes`

### REMOVED
- (none)

---
```

---

## Integration with /sprint-update

The `/sprint-update` protocol now includes delta tracking as step 2b:

```
/sprint-update (after sprint merge):

1. Create branch: docs/sprintN-update
2. Update clerical docs:
   a. project-valuation-report.md (hours, commits, deliverables)
   b. ★ spec-changelog.md (append new delta entry for this sprint)
   c. project-evaluation.md (scorecard, defects)
   d. project-plan.md (architecture changes)
   e. testing-plan.md (test count)
   f. dev-workflow.md (process changes)
   g. steering spec (update current state in-place)
3. Add inline delta summary to sprint-tracker.md
4. Commit, push, create docs PR
```

**The key insight:** The steering spec gets updated **in-place** (always current), while the changelog gets **appended** (always historical). Both happen in the same `/sprint-update` run.

---

## When to Write Deltas

| Trigger | What to Do |
|---------|------------|
| `/sprint-update` runs | Append entry to spec-changelog.md + add inline delta to sprint-tracker |
| `/hotfix` changes spec-level behavior | Add a hotfix entry to spec-changelog.md |
| `/plan` changes scope/removes features | Add a planning entry to spec-changelog.md |
| Refactoring (no behavior change) | **No delta needed** (spec didn't change) |

---

## Writing Good Delta Entries

### Good (Specific, Traceable)

```markdown
### ADDED
- `tags` field on `ProjectExpense` type (string array, lowercase)
- GIN index on `tags` column for array-contains queries
- `TagChipInput` component with autocomplete from existing user tags

### MODIFIED
- Feed sort: one-time items now sort by `logged_date` descending (was: `created_at`)
- Navigation: bottom tabs replace drawer-based navigation (5 tabs)
```

### Bad (Vague, Untraceble)

```markdown
### ADDED
- Tags feature
- New navigation

### MODIFIED
- Sorting updated
- UI improvements
```

### Rules for Good Deltas

1. **Name the entity/type/component** — not just the feature
2. **Note the change direction** — "was X, now Y" for modifications
3. **Include technical specifics** — field types, index types, component names
4. **Keep it one line per item** — scannable, not essays
5. **Reference migrations** — if a DB migration was involved, name it

---

## Why Not Just Use Git History?

| Git History | Delta Tracking |
|-------------|----------------|
| Shows file-level diffs | Shows spec-level behavioral changes |
| Requires reading code to understand impact | Human-readable summary of what changed |
| Scattered across many commits per sprint | One consolidated entry per sprint |
| Implementation details (how) | Specification changes (what) |
| Requires git access to browse | Readable as Markdown in docs/ |

**Git tells you *how* code changed. Deltas tell you *what behavior* changed.**

---

## Benefits Over Time

### Month 1 (3-4 sprints)
- Quick reference: "What did Sprint 3 actually change?"
- Useful for PR descriptions and release notes

### Month 3 (10+ sprints)
- Onboarding: new contributor reads changelog to understand evolution
- Debugging: "When was this behavior introduced?" → scan changelog
- Planning: "What have we deprecated?" → search REMOVED sections

### Month 6+ (mature project)
- Audit trail: complete specification evolution history
- Release notes generation: changelog entries become release notes
- Architecture decisions: understand WHY current state exists

---

## Relationship to OpenSpec

This convention is inspired by [OpenSpec's](https://github.com/Fission-AI/OpenSpec) delta spec concept (ADDED/MODIFIED/REMOVED format and the separation of "current state" from "change history"). Adapted for our sprint-based, Kiro-first workflow without requiring CLI tooling or the full OpenSpec infrastructure.

| OpenSpec | Project Blueprint |
|----------|-------------------|
| `openspec/specs/` (source of truth) | `.kiro/steering/project-spec.md` |
| `openspec/changes/*/specs/` (deltas) | Inline delta in `sprint-tracker.md` |
| `openspec/changes/archive/` (history) | `docs/spec-changelog.md` |
| `/opsx:archive` (merge command) | `/sprint-update` protocol step |
| CLI-dependent tooling | Plain Markdown, zero tooling |

---

## Real-World Example: Nidhi Seermai Sprint 12

If we had used delta tracking from the start:

```markdown
## Sprint 12: Receipt Attachments

**Date:** 2026-06-05 | **PR:** #32

### ADDED
- `receipt_url: string | null` on `ProjectExpense` interface
- `receipt_url` column on `project_expenses` table (migration 006)
- Supabase Storage bucket `receipts` with folder-based RLS (`receipts/{user_id}/**`)
- Storage RLS policy: users access only their own folder (migration 007)
- `ReceiptUploader.vue` component: drag/drop + click, 1MB limit, JPEG/PNG/PDF
- Receipt thumbnail preview in `ExpenseDetailView`
- Receipt deletion with confirmation dialog
- `receipt-service.ts`: upload, getUrl, delete functions

### MODIFIED
- `ProjectExpenseInsert` type: added `receipt_url: string | null`
- `ExpenseFormView`: added receipt upload section below notes field
- Expense detail drawer: shows receipt preview when `receipt_url` is not null

### REMOVED
- (none this sprint)

### Rationale
Paper receipts were getting lost. Users needed a way to attach proof-of-expense
directly to each record. Supabase Storage with folder-based RLS provides
user-isolated file storage without additional infrastructure.
```

---

## Quick Reference

```markdown
## Sprint N: [Topic] ✅ Complete (Merged PR #X)

[tasks...]

### Spec Delta

**ADDED:**
- [entity.field]: [type] — [brief purpose]
- [ComponentName]: [brief description]
- [Migration NNN]: [what it does]

**MODIFIED:**
- [entity/component]: [was X, now Y]

**REMOVED:**
- [entity/component]: [reason for deprecation]
```

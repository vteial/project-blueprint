# Guide: Steering File Conventions

## What Steering Files Are

Steering files are **context documents** that get loaded into AI coding assistants (like Kiro) to give them project-specific knowledge. They're not code, not documentation for humans — they're instructions for your AI pair programmer.

Think of them as "system prompts for your project."

**Without steering:** AI generates generic code, asks basic questions, makes wrong assumptions.
**With steering:** AI knows your stack, conventions, patterns, and constraints from the first line of code.

## File Structure

### Location

```
.kiro/
└── steering/
    ├── project-spec-template.md    # Always loaded (inclusion: auto)
    ├── testing.md                   # Loaded when writing tests
    ├── database.md                  # Loaded when touching DB/migrations
    └── ui-patterns.md              # Loaded when building UI
```

### Front-Matter

Every steering file needs YAML front-matter:

```yaml
---
inclusion: auto       # Always loaded into context
---
```

or

```yaml
---
inclusion: manual     # Loaded on demand or by file match
---
```

| Inclusion Mode | When Loaded | Use For |
|---------------|-------------|---------|
| `auto` | Every AI interaction | Project spec, core conventions |
| `manual` | When explicitly activated | Specialized knowledge (DB, testing, etc.) |

### References

Link to project files the AI should be aware of:

```markdown
## References
- docs/project-plan.md — Architecture decisions
- docs/testing-plan.md — Test conventions and IDs
- docs/dev-workflow.md — Sprint protocols
```

## Anatomy of a Good Steering File

A well-structured steering file has 6 sections:

### 1. System Objective & Guardrails

What the project IS and what the AI should NEVER do:

```markdown
## System Objective
Build a mobile-first expense tracker for freelancers. 
Vue 3 + TypeScript + Pinia + Supabase.

## Guardrails
- Never use any state management other than Pinia
- Never write raw SQL in frontend code — use Supabase client
- Never skip TypeScript types — no `any` allowed
- Always mobile-first: start at 375px, scale up
```

### 2. Technical Stack (Table)

Exact versions, no ambiguity:

```markdown
## Technical Stack
| Layer | Choice | Version |
|-------|--------|---------|
| Language | TypeScript | 5.x |
| Framework | Vue 3 | 3.5+ |
| State | Pinia | 2.x |
| Database | Supabase (PostgreSQL) | — |
| Hosting | Vercel | — |
| CI | GitHub Actions | — |
```

### 3. Architecture Patterns

How code is organized:

```markdown
## Architecture
- Views in `src/views/` — one per route
- Components in `src/components/` — reusable UI
- Stores in `src/stores/` — one per domain entity
- Services in `src/lib/` — API/data access layer
- Utils in `src/utils/` — pure functions
```

### 4. Naming Conventions

Explicit rules (AI follows these literally):

```markdown
## Naming
- Views: PascalCase + `View` suffix (e.g., `DashboardView.vue`)
- Components: PascalCase (e.g., `ExpenseDrawer.vue`)
- Stores: camelCase filename (e.g., `expenses.ts`)
- Tests: co-located, `.spec.ts` suffix
```

### 5. Current State

What exists NOW (updated with `/sprint-update`):

```markdown
## Current State
- Sprint: 3 (in progress)
- Tests: 28 passing
- Coverage: 52%
- Last deploy: 2025-01-15 (staging)
```

### 6. Domain-Specific Rules

Things unique to your project:

```markdown
## Business Rules
- Amounts always stored in cents (integer, never float)
- Dates stored as ISO 8601, displayed in user's timezone
- Tags are lowercase, comma-separated, max 10 per expense
- Projects have a color (hex) and optional budget (cents)
```

## Best Practices

### Do

| Practice | Why |
|----------|-----|
| Be specific ("Vue 3.5 with Composition API") | AI won't guess wrong |
| Include file paths (`src/stores/expenses.ts`) | AI knows where things live |
| State what NOT to do ("Never use Options API") | Prevents common mistakes |
| Update after each sprint | Context stays fresh |
| Keep under 200 lines (auto-loaded files) | Fits in context window |
| Use tables for structured info | Easy to parse |

### Don't

| Anti-Pattern | Why It's Bad |
|--------------|-------------|
| Vague descriptions ("use best practices") | AI interprets differently each time |
| Stale information ("Sprint 1 in progress" when on Sprint 4) | AI makes wrong assumptions |
| Duplicating docs (copying project-plan into steering) | Goes stale, wastes context |
| Writing a novel (500+ line steering file) | Exceeds useful context |
| Including code examples longer than 10 lines | Use file references instead |
| Putting TODO items in steering | It's not a task tracker |

## One File vs Multiple

### Single File (Recommended for most projects)

**When:** Project is straightforward, single tech stack, < 200 lines covers everything.

```
.kiro/steering/
└── project-spec-template.md   (auto — everything)
```

### Multiple Files (Complex projects)

**When:** Different contexts need different knowledge, would exceed 200 lines combined.

```
.kiro/steering/
├── project-spec.md        (auto — core overview, 100 lines)
├── database.md            (manual — migration patterns, RLS rules)
├── testing.md             (manual — test conventions, fixture patterns)
└── deployment.md          (manual — environment config, rollout)
```

## Evolution Over Time

| Sprint | Steering Content |
|--------|-----------------|
| Sprint 0 | Stack choices, project objective, initial architecture |
| Sprint 1 | Add naming conventions, first patterns established |
| Sprint 2 | Add business rules discovered during development |
| Sprint 3 | Refine based on what AI gets wrong frequently |
| Sprint 4+ | Stabilize — mostly updating "Current State" section |

**Key insight:** Steering files evolve from aspirational to descriptive. Early sprints say "we will use X." Later sprints say "we use X, and it works like this."

## Real-World Examples

### Nidhi Seermai Steering (excerpt)

```markdown
---
inclusion: auto
---

# Nidhi Seermai — Expense Tracker

## Objective
Mobile-first expense tracking PWA for freelancers.
Track expenses by project, tag, date. Receipt upload. Analytics.

## Stack
| Layer | Choice |
|-------|--------|
| Language | TypeScript 5.x |
| Framework | Vue 3.5 (Composition API only) |
| State | Pinia 2.x |
| Database | Supabase (PostgreSQL) |
| Auth | Supabase Auth (magic link + Google OAuth) |
| Hosting | Vercel |
| Mobile | Capacitor (future) |

## Guardrails
- Composition API only. Never Options API.
- No `any` types. Use `unknown` + type guards if needed.
- Mobile-first always. Start at 375px.
- Amounts in cents (integer). Display with format util.
- RLS on every table. No service role key in frontend.
```

### Saranidhi Steering (excerpt)

```markdown
---
inclusion: auto
---

# Saranidhi — Freelancer Management

## Objective
Multi-platform app for freelancers: invoices, time tracking, clients.

## Stack
| Layer | Choice |
|-------|--------|
| Language | Dart 3.x |
| Framework | Flutter 3.x |
| State | Riverpod 2.x |
| Database | Supabase (PostgreSQL) |
| Auth | Supabase Auth |

## Guardrails
- Riverpod only. No setState, no Provider package.
- Freezed for all data models.
- GoRouter for navigation.
- Never use BuildContext in async operations.
```


## Steering + Delta Tracking

The steering file represents **current state** — it answers "how does the system work right now?" It is updated **in-place** during `/sprint-update`.

But updating in-place loses history. To preserve the narrative of *what changed and when*, we use **delta tracking** alongside the steering file:

```
.kiro/steering/project-spec.md  →  "What IS" (updated in-place)
docs/spec-changelog.md          →  "What CHANGED" (append-only history)
docs/sprint-tracker.md          →  "What changed THIS sprint" (inline per sprint)
```

### How They Work Together

| Event | Steering File | Spec Changelog |
|-------|--------------|----------------|
| Sprint adds new entity | Add entity to spec | Append ADDED entry |
| Sprint changes business rule | Update rule in spec | Append MODIFIED entry (was X, now Y) |
| Sprint removes feature | Remove from spec | Append REMOVED entry (with reason) |
| Refactoring (no behavior change) | No change | No entry |

### Example Flow (Sprint 12 adds receipt uploads)

**1. Steering file gets updated in-place:**
```markdown
## Core Domain Entities
| Entity | Key Fields |
|--------|------------|
| ProjectExpense | id, cost_cents, ..., receipt_url |  ← field added
```

**2. Spec changelog gets appended:**
```markdown
## Sprint 12: Receipt Attachments
### ADDED
- `receipt_url: string | null` on ProjectExpense
- Supabase Storage bucket `receipts` with RLS
- ReceiptUploader component
```

**3. Sprint tracker gets inline delta:**
```markdown
## Sprint 12: Receipt Attachments ✅ Complete (PR #32)
[tasks...]
### Spec Delta
**ADDED:** receipt_url field, storage bucket, uploader component
```

This gives you three levels of detail:
- **Quick glance** → sprint tracker inline delta
- **Full history** → spec-changelog.md
- **Current truth** → steering file

See `guides/10-delta-tracking.md` for the complete delta tracking convention.

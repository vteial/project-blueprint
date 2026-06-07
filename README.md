# Project Blueprint

> A GitHub Template Repository for AI-assisted development with [Kiro](https://kiro.dev).

## What Is This?

Project Blueprint is a **docs-only template** that gives any new project a complete development scaffolding — sprint tracking, testing plans, release processes, CI templates, and steering files — all designed to work with AI-assisted development workflows.

It is **Kiro-first** but **tool-agnostic**. Every convention documented here can be followed manually or adapted to other AI coding tools.

| Aspect | Kiro (Primary) | Other AI Tools | Manual |
|--------|---------------|----------------|--------|
| Steering files | Auto-loaded | Copy as system prompts | Reference docs |
| Sprint protocols | `/start-sprint`, `/finish-sprint` | Adapt commands | Follow checklists |
| Doc updates | `/project-update` | Manual trigger | Edit directly |
| CI templates | Drop-in | Drop-in | Drop-in |

## Usage Options

### Option 1: Use as Template (Recommended)

Click **"Use this template"** on GitHub to create a new repo with all blueprint files. Then:
1. Fill in `{{PLACEHOLDER}}` tokens in `.kiro/steering/project-spec-template.md`
2. Customize docs for your project
3. Delete guides you don't need

### Option 2: Cherry-Pick

Copy only the files you need:
- Just want CI? → `templates/ci/`
- Just want sprint workflow? → `docs/dev-workflow.md` + `docs/sprint-tracker.md`
- Just want steering? → `.kiro/steering/`

### Option 3: Reference

Read the guides in `guides/` to understand the conventions, then implement them your own way.

## Repository Structure

```
project-blueprint/
├── .kiro/
│   └── steering/
│       └── project-spec-template.md    # Auto-loaded project context
├── .github/
│   ├── PULL_REQUEST_TEMPLATE.md        # PR template with checklist
│   └── ISSUE_TEMPLATE/
│       ├── bug_report.md               # Bug report template
│       └── feature_request.md          # Feature request template
├── docs/
│   ├── dev-workflow.md                 # Sprint flow & protocols
│   ├── sprint-tracker.md              # Sprint history & status
│   ├── project-plan.md                # Architecture & data design
│   ├── project-evaluation.md          # Quality scorecard
│   ├── project-valuation-report.md    # Time investment tracking
│   ├── testing-plan.md                # Test strategy & coverage
│   ├── release-plan.md                # Release scope & gates
│   ├── security-review.md             # Security audit checklist
│   ├── smoke-test-plan.md             # Manual test scenarios
│   └── smoke-test-results.md          # Test execution results
├── guides/
│   ├── 01-dev-workflow.md              # Why & how of sprint protocols
│   ├── 02-ui-guidelines.md            # Mobile-first UI conventions
│   ├── 03-doc-standards.md            # Documentation requirements
│   ├── 04-steering-conventions.md     # Writing steering files
│   ├── 05-testing-strategy.md         # Test pyramid & coverage
│   ├── 06-project-valuation.md        # AI+20% time tracking
│   ├── 07-release-planning.md         # Release numbering & gates
│   ├── 08-migration-convention.md     # Database migration patterns
│   └── 09-prod-rollout.md             # Deployment & rollback
├── templates/
│   ├── ci/
│   │   ├── ci-flutter.yml             # Flutter CI pipeline
│   │   ├── ci-vue-ts.yml              # Vue + TypeScript CI pipeline
│   │   └── ci-generic.yml             # Skeleton for any stack
│   ├── lefthook/
│   │   ├── lefthook-flutter.yml       # Flutter pre-commit hooks
│   │   └── lefthook-vue-ts.yml        # Vue/TS pre-commit hooks
│   ├── deployment/
│   │   ├── vercel.json                # SPA rewrite config
│   │   └── ROLLOUT.md                 # Deployment procedure template
│   └── migrations/
│       ├── CONVENTION.md              # Migration rules & naming
│       └── 000_create_schema_migrations.sql  # Bootstrap migration
├── .gitignore
├── LICENSE
└── README.md
```

## Responsibility Split

| Concern | IDE (Kiro/Cursor) | Web (GitHub) |
|---------|-------------------|--------------|
| Code generation | Primary | — |
| Steering file authoring | Primary | Review |
| PR creation | Primary | Review & merge |
| Sprint tracking | Updates tracker | Source of truth |
| Issue triage | — | Primary |
| Deployment approval | — | Primary (environments) |
| Code review | Assisted | Final decision |

## Core Principles

1. **Defaults Over Decisions** — Every convention has a sensible default. Override only when you have a reason.
2. **Progressive Disclosure** — Start with `docs/` for project-specific info. Read `guides/` when you need to understand *why*.
3. **AI+20% Rule** — Track AI-assisted time, add 20% for review/debugging. See `guides/06-project-valuation.md`.
4. **Docs-Only Branches** — Documentation updates ship in their own PRs. Never block a feature branch on docs.
5. **Tables Over Prose** — Use tables for status tracking, comparisons, and checklists. Prose for explanations.

## Quick Start Checklist

- [ ] Create repo from template
- [ ] Fill in `.kiro/steering/project-spec-template.md` placeholders
- [ ] Choose CI template from `templates/ci/` → copy to `.github/workflows/`
- [ ] Choose pre-commit hooks from `templates/lefthook/` → copy to root
- [ ] Update `docs/project-plan.md` with your architecture
- [ ] Create Sprint 0 tasks in `docs/sprint-tracker.md`
- [ ] Run `/start-sprint 1` to begin development

## License

MIT — See [LICENSE](./LICENSE)

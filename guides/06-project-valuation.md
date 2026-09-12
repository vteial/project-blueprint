# Guide: Project Valuation

## The AI+20% Rule

When tracking time for AI-assisted development:

```
Billable Hours = AI Session Hours × 1.2
```

### What Counts as a Session

A "session" is a continuous block of AI-assisted development work. It starts when you open the IDE and begin prompting, and ends when you stop for a break or switch to non-development work.

### What the +20% Covers

| Activity | In Session Time? | In +20% Overhead? |
|----------|-----------------|-------------------|
| Prompting AI, reviewing output | ✅ | — |
| Accepting/rejecting suggestions | ✅ | — |
| Manual debugging of AI output | ✅ | — |
| Context switching between tasks | — | ✅ |
| Re-reading code AI wrote | — | ✅ |
| Mental model building | — | ✅ |
| Short breaks (< 10 min) | — | ✅ |
| Post-session cleanup/refactoring | — | ✅ |

### Why 20%?

Based on real project data across Saranidhi and Nidhi Seermai:
- Raw AI-assisted time: highly productive but intense
- Actual effort is ~20% higher due to review overhead
- Traditional estimates would be 3-5x higher for the same output
- 20% is honest without being generous

### Formula Example

```
Session: 2.5 hours of AI-assisted development
+20%:   0.5 hours overhead
Total:  3.0 hours billable

At $150/hr: $450 for this session
Traditional estimate for same work: 8-12 hours ($1200-$1800)
Client gets: 3-4x value compared to traditional development
```

## Session Clustering Method

Sessions happen across days and times. Cluster them into logical units:

### 5 Steps

1. **Record start/end time** for each AI session
2. **Note the focus area** (what you built)
3. **Group adjacent sessions** (same day or continuing same feature)
4. **Apply +20%** to each cluster
5. **Assign to sprint** for tracking

### Example (Nidhi Seermai, Sprint 3)

| Session | Raw Time | Focus | Cluster |
|---------|----------|-------|---------|
| Mon AM | 2h | Tag categorization | Cluster A |
| Mon PM | 1.5h | Tag categorization (continued) | Cluster A |
| Wed AM | 3h | Receipt upload + storage | Cluster B |
| Thu AM | 2h | Calendar view | Cluster C |
| Thu PM | 1h | Calendar indicators | Cluster C |
| Fri AM | 1.5h | Dark mode | Cluster D |

| Cluster | Raw | +20% | Total | Deliverable |
|---------|-----|------|-------|-------------|
| A | 3.5h | 0.7h | 4.2h | Tag system complete |
| B | 3.0h | 0.6h | 3.6h | Receipt upload + storage |
| C | 3.0h | 0.6h | 3.6h | Calendar with indicators |
| D | 1.5h | 0.3h | 1.8h | Dark mode theming |
| **Sprint 3 total** | **11h** | **2.2h** | **13.2h** | — |

## Time Categories

### 1. AI-Assisted Development Sessions

Direct coding work with AI tools:

| Activity | Example | Tracking |
|----------|---------|----------|
| Feature development | Building expense form | Session timer |
| Bug fixing | Resolving auth redirect loop | Session timer |
| Test writing | Adding E2E scenarios | Session timer |
| Refactoring | Extracting query cache | Session timer |

### 2. Infrastructure Time

Non-coding work required for the project:

| Activity | Example | Tracking |
|----------|---------|----------|
| Environment setup | Installing deps, configuring Supabase | Log manually |
| CI/CD debugging | Fixing pipeline failures | Log manually |
| Deployment | Setting up Vercel, DNS | Log manually |
| Code review | Reviewing PRs (if team) | Log manually |
| Documentation | Writing guides (not auto-generated) | Log manually |

### 3. Overhead (Automatic)

Applied as the 20% multiplier — never tracked separately:

| Activity | Example |
|----------|---------|
| Context switching | Moving between files/tasks |
| Re-reading generated code | Understanding AI's approach |
| Mental breaks | Short pauses during sessions |
| Post-session cleanup | Minor tweaks after session ends |

## Valuation Report Structure

The `docs/project-valuation-report.md` file tracks:

1. **Executive Summary** — Total investment, efficiency multiplier
2. **Commit Timeline** — Commits per sprint with dates
3. **Session Log** — Individual sessions with duration + focus
4. **Infrastructure Time** — Non-session work
5. **Total Investment** — Combined with +20% applied
6. **Sprint Delivery** — Hours per sprint with deliverables
7. **Technical Deliverables** — What was built (counts)

## Sprint Delivery with Hours

Each sprint in the tracker should note total hours:

| Sprint | Focus | Raw Hours | +20% | Total | Deliverables |
|--------|-------|-----------|------|-------|--------------|
| Sprint 0 | Setup | 3h | 0.6h | 3.6h | Repo, CI, steering |
| Sprint 1 | Core | 8h | 1.6h | 9.6h | Data model, auth, nav |
| Sprint 2 | Features | 10h | 2.0h | 12.0h | Dashboard, analytics |
| Sprint 3 | Polish | 11h | 2.2h | 13.2h | Tags, receipts, calendar |
| Sprint 4 | Release | 6h | 1.2h | 7.2h | Security, deploy |
| **Total** | — | **38h** | **7.6h** | **45.6h** | — |

## When to Update

| Trigger | Action |
|---------|--------|
| After every coding session | Log session in valuation report |
| After `/sprint-finish` | Calculate sprint totals |
| After infrastructure work | Log in infrastructure table |
| Before client invoice | Verify totals, generate summary |
| At project milestone | Add to executive summary |

## Comparing AI vs Traditional

For client communication, show the value:

| Metric | AI-Assisted | Traditional Estimate | Savings |
|--------|------------|---------------------|---------|
| Total hours | 45h | 150-200h | 70-75% |
| Calendar time | 3 weeks | 8-12 weeks | 65-75% |
| Cost @$150/hr | $6,750 | $22,500-$30,000 | 70-78% |
| Test coverage | 70% | Often < 30% | Higher quality |
| Documentation | Complete | Often missing | Better maintainability |

**Key talking points:**
- Same quality, dramatically less time
- Better test coverage than typical projects
- Complete documentation included (usually extra cost)
- AI handles boilerplate; human handles design decisions

## Client / Portfolio Presentation Tips

### For Invoicing

```
Project: {{PROJECT_NAME}}
Period: {{START}} → {{END}}
Hours: {{TOTAL}} hours (AI-assisted, +20% review overhead)
Rate: ${{RATE}}/hr
Total: ${{AMOUNT}}

Deliverables this period:
- {{DELIVERABLE_1}}
- {{DELIVERABLE_2}}
- {{DELIVERABLE_3}}

Next period focus:
- {{UPCOMING_1}}
- {{UPCOMING_2}}
```

### For Portfolio

Show the efficiency:
- "Built in {{N}} hours what traditionally takes {{M}} hours"
- "Complete with {{N}}% test coverage and full documentation"
- "Delivered in {{N}} weeks vs typical {{M}} week timeline"

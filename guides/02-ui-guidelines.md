# Guide: UI Guidelines

## Mobile-First Philosophy

Every interface starts at 375px and scales up. Never design desktop-first and squeeze down. The mobile experience should feel native-app-quality; the desktop experience is a bonus.

**Why:** Most personal productivity apps are used on phones. Even "desktop" apps increasingly live in narrow browser windows alongside other tools.

## Responsive Breakpoints

| Breakpoint | Name | Target | Layout |
|-----------|------|--------|--------|
| `< 640px` | Mobile | Phones | Single column, bottom nav |
| `640-1024px` | Tablet | Tablets, small laptops | Two column where useful |
| `> 1024px` | Desktop | Laptops, monitors | Multi-column, side nav |

### Container Rules

```css
.container {
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

@media (min-width: 640px) {
  .container {
    padding: 0 1.5rem;
  }
}

@media (min-width: 1024px) {
  .container {
    padding: 0 2rem;
  }
}
```

## Grid Patterns

### Card Grid (Responsive)

```css
.card-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}

@media (min-width: 640px) {
  .card-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .card-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

### Form Layout

```css
.form-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 1rem;
}

@media (min-width: 640px) {
  .form-grid {
    grid-template-columns: 1fr 1fr;
  }
  
  .form-grid .full-width {
    grid-column: 1 / -1;
  }
}
```

## Theming

### CSS Custom Properties

```css
:root {
  /* Light mode (default) */
  --color-bg-primary: #ffffff;
  --color-bg-secondary: #f8f9fa;
  --color-bg-elevated: #ffffff;
  --color-text-primary: #1a1a2e;
  --color-text-secondary: #6b7280;
  --color-text-muted: #9ca3af;
  --color-border: #e5e7eb;
  --color-accent: #6366f1;
  --color-accent-hover: #4f46e5;
  --color-success: #10b981;
  --color-warning: #f59e0b;
  --color-error: #ef4444;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.07);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
  --radius-sm: 0.375rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;
}

[data-theme="dark"] {
  --color-bg-primary: #0f0f23;
  --color-bg-secondary: #1a1a2e;
  --color-bg-elevated: #16213e;
  --color-text-primary: #e2e8f0;
  --color-text-secondary: #94a3b8;
  --color-text-muted: #64748b;
  --color-border: #334155;
  --color-accent: #818cf8;
  --color-accent-hover: #6366f1;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.3);
  --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.4);
  --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.5);
}
```

### Color Semantics

| Purpose | Variable | Light | Dark |
|---------|----------|-------|------|
| Page background | `--color-bg-primary` | White | Near-black |
| Card/section background | `--color-bg-secondary` | Off-white | Dark gray |
| Elevated elements | `--color-bg-elevated` | White | Dark blue |
| Primary text | `--color-text-primary` | Near-black | Near-white |
| Secondary text | `--color-text-secondary` | Gray | Light gray |
| Borders | `--color-border` | Light gray | Dark gray |
| Interactive accent | `--color-accent` | Indigo | Light indigo |
| Success state | `--color-success` | Green | Green |
| Warning state | `--color-warning` | Amber | Amber |
| Error state | `--color-error` | Red | Red |

## Component Patterns

### When to Use Each

| Pattern | Use For | Example |
|---------|---------|---------|
| Full-page view | Primary content | Dashboard, list views |
| Drawer (bottom sheet) | Quick actions, forms | Add expense, settings |
| Modal/dialog | Confirmations | Delete confirmation |
| Toast notification | Feedback | "Saved successfully" |
| Inline expansion | Details within list | Expense detail in list |
| Floating action button | Primary creation action | "+" button |

### Loading States

```
┌─────────────────────┐
│  ████████░░░░░░░░░  │  ← Skeleton loading (preferred)
│  ████░░░░░░░░░░░░░  │
│  ██████████░░░░░░░  │
└─────────────────────┘
```

- Use **skeleton screens** for initial page loads
- Use **spinners** for actions (button press → waiting)
- Use **progress bars** for uploads/long operations
- Never show a blank screen while loading

### Empty States

Every view that can be empty MUST have an empty state:
- Illustration or icon (optional)
- Descriptive text ("No expenses yet")
- Call-to-action button ("Add your first expense")

### Error States

- Inline errors for form fields (below the field, red text)
- Toast for transient errors ("Network error — retrying")
- Full-page error for fatal errors (with retry button)

## Navigation

### Bottom Navigation (Mobile)

- Maximum 5 items
- Icon + label always visible
- Active state clearly different from inactive
- No nested navigation in bottom bar

```
┌──────────────────────────────────┐
│        Main Content              │
│                                  │
├──────────────────────────────────┤
│  🏠    📊    ➕    📅    ⚙️   │
│ Home  Stats  Add  Calendar More  │
└──────────────────────────────────┘
```

### Focus Mode

When user is in a creation/edit flow:
- Hide bottom navigation
- Show only: Back arrow + Save button
- Minimize distractions

## Accessibility

### Typography

| Element | Size | Weight | Line Height |
|---------|------|--------|-------------|
| H1 (page title) | 1.5rem | 700 | 1.2 |
| H2 (section) | 1.25rem | 600 | 1.3 |
| H3 (subsection) | 1.125rem | 600 | 1.4 |
| Body | 1rem | 400 | 1.5 |
| Caption | 0.875rem | 400 | 1.4 |
| Small | 0.75rem | 400 | 1.4 |

### Contrast Requirements

- Normal text: minimum 4.5:1 contrast ratio (WCAG AA)
- Large text (18px+): minimum 3:1 contrast ratio
- Interactive elements: minimum 3:1 against adjacent colors
- Focus indicators: clearly visible (not just color change)

### Touch Targets

- Minimum 44x44px for all interactive elements
- 8px minimum spacing between adjacent targets
- Larger targets for primary actions (56x56px recommended)

### Semantic HTML

```html
<!-- DO -->
<button @click="save">Save</button>
<nav aria-label="Main navigation">...</nav>
<main role="main">...</main>

<!-- DON'T -->
<div @click="save">Save</div>
<div class="nav">...</div>
<div class="main">...</div>
```

### Keyboard Navigation

- All interactive elements reachable via Tab
- Logical tab order (top-to-bottom, left-to-right)
- Escape closes modals/drawers
- Enter submits forms
- Focus trap in modals

## File Naming

| Type | Convention | Example |
|------|-----------|---------|
| Views | PascalCase + `View` suffix | `DashboardView.vue` |
| Components | PascalCase | `ExpenseDrawer.vue` |
| Composables | camelCase + `use` prefix | `useExpenses.ts` |
| Stores | camelCase | `expenses.ts` |
| Utils | kebab-case | `date-range.ts` |
| Tests | Same name + `.spec` | `DashboardView.spec.ts` |
| CSS | kebab-case | `main.css` |

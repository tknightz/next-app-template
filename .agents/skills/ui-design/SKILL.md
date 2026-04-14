---
name: ui-design
description: You MUST use when designing UI components, layouts, styling, color systems, typography, responsive interfaces, or visual design decisions. Activates for CSS, Tailwind, theming, and component styling work.
---

# UI Design Guidelines

Design guidelines for creating polished, accessible, and responsive user interfaces. If you design from scratch, you MUST create DESIGN.md if not existing, and follow it for the next time.

## Color System

**ALWAYS use exactly 3-5 colors total.**

### Required Color Structure

| Type | Count | Purpose |
|------|-------|---------|
| Primary brand | 1 | Main accent color |
| Neutrals | 2-3 | White, grays, off-whites, black variants |
| Accents | 0-1 | Secondary highlight |

### Rules

- NEVER exceed 5 total colors without explicit permission
- NEVER use purple or violet prominently unless explicitly requested
- If you override a component's background color, you MUST override its text color for contrast
- Use design tokens (bg-background, text-foreground) instead of direct colors (bg-white, text-black)

### Gradients

- Avoid gradients entirely unless explicitly requested
- If necessary, use only as subtle accents, never for primary elements
- Use analogous colors: blue→teal, purple→pink, orange→red
- NEVER mix opposing temperatures: pink→green, orange→blue, red→cyan
- Maximum 2-3 color stops

### Semantic Design Tokens

Define in `globals.css`:

```css
:root {
  --background: 0 0% 100%;
  --foreground: 222.2 84% 4.9%;
  --primary: 222.2 47.4% 11.2%;
  --secondary: 210 40% 96.1%;
  --muted: 210 40% 96.1%;
  --accent: 210 40% 96.1%;
  --destructive: 0 84.2% 60.2%;
  --border: 214.3 31.8% 91.4%;
  --radius: 0.5rem;
}
```

---

## Typography

**ALWAYS limit to maximum 2 font families total.**

### Required Font Structure

| Font | Usage |
|------|-------|
| Heading font | Titles, headers (multiple weights allowed) |
| Body font | Paragraphs, labels, UI text |

### Rules

- Use line-height between 1.4-1.6 for body text (`leading-relaxed` or `leading-6`)
- NEVER use decorative fonts for body text or fonts smaller than 14px
- Apply fonts via `font-sans`, `font-mono`, `font-serif` classes

### Font Implementation (Next.js)

```tsx
// layout.tsx
import { Inter, Space_Mono } from 'next/font/google'

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' })
const spaceMono = Space_Mono({ subsets: ['latin'], variable: '--font-space-mono' })

export default function RootLayout({ children }) {
  return (
    <html className={`${inter.variable} ${spaceMono.variable}`}>
      <body>{children}</body>
    </html>
  )
}
```

```ts
// tailwind.config.ts
theme: {
  extend: {
    fontFamily: {
      sans: ['var(--font-inter)'],
      mono: ['var(--font-space-mono)'],
    },
  },
}
```

---

## Layout Structure

**ALWAYS design mobile-first, then enhance for larger screens.**

### Layout Method Priority

1. **Flexbox** for most layouts: `flex items-center justify-between`
2. **CSS Grid** only for complex 2D layouts: `grid grid-cols-3 gap-4`
3. NEVER use floats or absolute positioning unless absolutely necessary

### Tailwind Patterns

| Use | Avoid |
|-----|-------|
| `p-4`, `mx-2`, `py-6` | `p-[16px]`, `mx-[8px]`, `py-[24px]` |
| `gap-4`, `gap-x-2`, `gap-y-6` | Arbitrary gap values |
| `items-center`, `justify-between` | Custom flex utilities |
| `md:grid-cols-2`, `lg:text-xl` | Hardcoded breakpoints |
| `text-balance`, `text-pretty` | Manual line breaks |

### Rules

- NEVER mix margin/padding with gap classes on the same element
- NEVER use `space-*` classes for spacing
- Use semantic Tailwind classes over arbitrary values
- Wrap important copy in `text-balance` or `text-pretty`

---

## Responsive Design

### Mobile-First Approach

Mobile is the PRIMARY experience - desktop is secondary.

### Technical Requirements

| Requirement | Implementation |
|-------------|----------------|
| Touch targets | Minimum 44px for all interactive elements |
| Font size | Minimum 16px for text inputs (prevents iOS zoom) |
| Viewport | Prevent zoom: `maximumScale: 1` |
| Background | Add to `<html>` tag: `<html className="bg-background">` |
| PWA-ready | Include `manifest.json` matching metadata |

### Viewport Configuration

```tsx
// layout.tsx
export const viewport = {
  width: 'device-width',
  initialScale: 1,
  maximumScale: 1,
  userScalable: false,
}
```

---

## Visual Elements & Icons

### Image Rules

- Use images to create engaging, memorable interfaces
- NEVER generate abstract shapes as filler (gradient circles, blurry squares, decorative blobs)
- NEVER create SVGs directly for complex illustrations
- NEVER hand-draw SVG paths for maps - use mapping libraries (react-simple-maps, Leaflet, Mapbox)

### Icon Implementation

- Use project's existing icons if available
- Use consistent sizing: 16px, 20px, or 24px
- NEVER use emojis as replacements for proper icons

---

## Accessibility

### Semantic HTML

| Element | Use When |
|---------|----------|
| `<main>` | Primary content area |
| `<header>` | Page or section header |
| `<nav>` | Navigation areas |
| `<article>` | Self-contained content |
| `<section>` | Themed content grouping |
| `<aside>` | Tangentially related content |

### ARIA & Screen Readers

- Use correct ARIA roles and attributes
- Use `sr-only` Tailwind class for screen reader only text
- Add alt text for all images (unless decorative or repetitive)
- Ensure color contrast meets WCAG standards

---

## Component Architecture

### Structure Rules

- Split code into multiple components
- Do NOT have one large `page.tsx` file
- Create components that `page.tsx` imports

### Available shadcn/ui Components

| Component | Use Case |
|-----------|----------|
| `FieldGroup` + `Field` + `FieldLabel` | Form layouts (not raw divs with `space-y-*`) |
| `FieldSet` + `FieldLegend` | Grouping checkboxes, radios, switches |
| `InputGroup` + `InputGroupInput` | Inputs with icons or buttons |
| `Empty` | Empty states |
| `Spinner` | Loading buttons |
| `ButtonGroup` | Grouped action buttons |
| `ToggleGroup` | State toggles |

### Charts

- Use shadcn/ui charts with Recharts
- Only bring in custom components (ChartTooltip) when needed

---

## Data Fetching Patterns

| Pattern | When to Use |
|---------|-------------|
| Server Components | Default for data fetching |
| SWR | Client-side state sync between components |
| useEffect | NEVER for data fetching |

**Rules:**
- Do NOT fetch inside `useEffect`
- Pass data down from RSC or use SWR

---

## Quality Checklist

Before finalizing design:

- [ ] Color palette: 3-5 colors max
- [ ] Font families: 2 max
- [ ] Mobile-first responsive
- [ ] Touch targets: 44px minimum
- [ ] Input font size: 16px minimum
- [ ] Semantic HTML elements
- [ ] ARIA attributes where needed
- [ ] Alt text for images
- [ ] Design tokens used instead of direct colors
- [ ] Components split appropriately
- [ ] Text balance on important copy


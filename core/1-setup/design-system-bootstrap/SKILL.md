---
name: core-setup-design-system-bootstrap
description: Use when establishing a project's reusable visual foundations before broad UI work—token hierarchy, typography, semantic color, spacing, elevation, theming, component primitives, and the rules that keep design and code aligned.
---

# Design System Bootstrap

Design foundations exist before the first screen is designed or built.

## Bootstrap sequence

1. Identify the project surfaces, supported platforms, brand constraints, and required themes.
2. Create a small primitive scale: color ramps, font families/weights, spacing, radius, borders,
   elevation, motion, and breakpoints only where the platform needs them.
3. Map primitives to semantic tokens—`text-primary`, `surface-default`, `action-danger`,
   `focus-ring`—rather than letting components choose raw values.
4. Define each theme by semantic-token values. Theme switching changes meanings centrally; it never
   makes components branch on light/dark raw colors.
5. Build or adopt a minimal set of accessible primitives from real product needs, then document
   their states and usage. Do not invent a 50-component library before two screens exist.

## Token rules

- Keep a three-level hierarchy: **primitive** values → **semantic** roles → **component** tokens
  only when a repeated component needs a stable, intentional exception.
- Name by purpose, not appearance. `border-subtle` survives a theme change; `gray-200` does not.
- No raw visual value belongs in product components except while defining tokens or making a
  documented one-off decision. A one-off that repeats earns a token after evidence, not before.
- Treat tokens as a public API: version, document, test theme combinations, and deprecate with a
  migration path instead of silently changing meaning.

## Foundation defaults

- Typography defines roles before sizes: display, heading, body, label, code, and numeric data;
  each has a readable line-height and a responsive/reflow rule.
- Color provides semantic success/warning/error/information states, a distinct focus indicator,
  and sufficient contrast in every supported theme. Color never becomes the sole state signal.
- Spacing, radius, and elevation are finite scales. They create hierarchy and relationship, not
  decorative variation.
- Build-vs-adopt is a product decision: adopt a well-maintained accessible primitive library when
  it matches the stack and can be wrapped; build only when product interaction or branding needs
  control the library cannot provide. Wrap vendor primitives behind your own stable API.

## Done means usable

Ship the bootstrap with token source files, generated platform artifacts where needed, a small
theme preview, and documented examples for the first primitives. Verify two representative views
in every theme and with keyboard, zoom, and reduced motion. `core-design-typography` and
`core-design-design-engineering` make design choices with these foundations; `core-build-ui-engineering`
consumes them without recreating them.

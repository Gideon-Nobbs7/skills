---
name: web-design-responsive-layout
description: Use when designing web layouts that must adapt to viewport, container, content, zoom, orientation, input modality, or mobile browser behavior; extends core design engineering with browser layout mechanics.
status: draft
---

# Responsive Web Layout

Apply `core-design-design-engineering`, `core-design-ux-and-flows`, and the accessibility baseline.
Design for content and capability ranges, not a list of named devices.

## Build from intrinsic behavior

- Start with a usable narrow layout and let content determine where composition must change.
- Prefer normal flow, flexible grid/flex tracks, `min()`, `max()`, `clamp()`, and intrinsic sizing
  before fixed dimensions or breakpoint patches.
- Use container queries when a reusable component should respond to its allotted space; use
  viewport queries for page-level composition.
- Keep readable line length and stable hierarchy across widths. Reflow rather than hiding essential
  content or requiring two-dimensional scrolling, except where the content itself requires it.

Choose breakpoints at the first width where content, controls, or hierarchy stop working. Record the
layout change they trigger; avoid device labels as the rationale.

## Adapt to human input

Ensure every action works with keyboard and touch. Treat hover as an enhancement and use capability
queries only to improve presentation—not to remove access. Size targets and spacing for coarse
pointers without making dense pointer layouts unusable. Preserve visible focus at every layout.

Support text zoom, browser zoom, user font settings, long translations, and dynamic content. Avoid
fixed heights around text. Use logical properties so direction changes do not require a parallel
layout system.

## Handle the viewport

Use dynamic/small viewport units only when their browser behavior matches the surface; keep content
safe from browser chrome, display cutouts, and virtual keyboards. Do not lock orientation or disable
user zoom. Test sticky/fixed controls with zoom and on-screen keyboards.

## Completion gate

Verify representative narrow, medium, wide, zoomed, text-enlarged, long-content, RTL, keyboard,
touch, hover/no-hover, orientation, and virtual-keyboard states. No essential content or action may
be clipped, overlapped, reordered misleadingly, or available through only one input modality.

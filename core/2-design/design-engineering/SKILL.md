---
name: core-design-design-engineering
description: Use when designing or implementing a polished interface: decide whether motion earns its place, tune component feedback, transitions, spacing, depth, and the small details that make a UI feel deliberate.
status: draft
upstream: https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/emil-design-eng
---

# Design Engineering

Make interfaces that feel inevitable, not merely functional. This is a shared design skill;
platform implementation mechanics remain in the relevant web or mobile overlay.

**Upstream:** Emil Kowalski's [`emil-design-eng`](https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/emil-design-eng), adapted and tracked in [`UPSTREAM_SOURCES.md`](../../../UPSTREAM_SOURCES.md).

## Operating standard

- Treat taste as an observable craft: inspect strong references, identify why they work, and make
  a concrete choice rather than adding generic "polish."
- Design the invisible details: responsive press states, clear hierarchy, consistent spacing,
  intentional alignment, and believable state changes compound into the experience.
- Prefer a small number of strong visual decisions. If an effect does not clarify hierarchy,
  relationship, feedback, or personality, remove it.
- Build components as coherent systems: the border, shadow, radius, type, color, interaction,
  and motion must tell the same story.

## Motion decision framework

Answer these questions before specifying an animation:

1. **Should it animate?** Keyboard-triggered and very frequent actions are instant. Repeated
   actions get subtle feedback only. Modals, drawers, and toasts may use standard motion; rare
   or first-time moments may earn delight.
2. **What purpose does it serve?** Valid purposes are spatial continuity, state indication,
   explanation, immediate feedback, or avoiding a jarring change. "It looks cool" is not enough.
3. **What changes?** Prefer `transform` and `opacity`. Use motion from the element's meaningful
   origin; a trigger-anchored popover grows from its trigger, while a centered modal stays centered.
4. **How should it feel?** Enter and exit motion is responsive (`ease-out` or a strong custom
   curve); on-screen repositioning can use `ease-in-out`; interaction-driven motion remains
   interruptible. Keep ordinary UI motion short.
5. **Who might be harmed or slowed?** Preserve comprehension with reduced motion, and never make
   frequent work feel slower for decoration.

## Component feedback defaults

- Every pressable control acknowledges pointer-down immediately; use a restrained active state
  such as `scale(0.97)`, never a dramatic shrink.
- Hover is supplementary feedback, not the only signal, and is gated to fine hover-capable
  pointers.
- Do not use `transition: all`, `ease-in` for UI entry, or `scale(0)` entrances.
- When a group enters, use a short stagger only when the ordering communicates structure; never
  block interaction while it runs.
- Use opacity and color for reduced-motion alternatives; remove travel, large scale, parallax,
  and nonessential looping.

## Review handoff

For a motion-only code review, load `core-verify-motion-review`. For gesture-driven interfaces,
load `core-design-fluid-interactions`. Use `core-design-animation-vocabulary` to turn an intended
effect into a precise specification.

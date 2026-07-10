---
name: core-design-fluid-interactions
description: Use when designing or reviewing drag, swipe, sheets, drawers, spring motion, momentum, or any interaction the user can interrupt or reverse while it is moving.
status: draft
upstream: https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/apple-design
---

# Fluid Interactions

Design direct manipulation so it tracks the person, not a pre-scripted animation.

**Upstream:** Emil Kowalski's [`apple-design`](https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/apple-design), adapted and tracked in [`UPSTREAM_SOURCES.md`](../../../UPSTREAM_SOURCES.md).

## Non-negotiables

- Respond on pointer-down, not release. Remove artificial delay from the input path.
- During a drag, slider, or drawer, update continuously and 1:1 with the pointer. Preserve the
  offset where the object was grabbed; do not snap its center under the pointer.
- Capture the pointer once a drag begins, retain recent position/timestamp samples, and ignore
  extra touch points so the object cannot jump.
- Never lock input while an object transitions. A person can grab, reverse, and redirect it at
  any point.
- Start a redirected animation from the current presented value and carry velocity through the
  handoff. Starting from a previous logical target causes visible jumps.

## Choose the behavior before the animation

- Use springs for gesture-driven and interruptible motion. Begin with critically damped motion;
  add modest bounce only when the gesture carried momentum.
- Project the release position using velocity before choosing a snap point. A quick flick should
  be able to dismiss even when it travelled a short distance.
- At boundaries, use rising resistance and a snap-back rather than an invisible hard wall.
- Keep X and Y independent when their velocities differ; do not collapse complex two-dimensional
  movement into one distance spring.
- Predetermined, non-gesture motion may use CSS transitions or WAAPI. Gesture state needs a
  velocity-aware system that retargets from the current value.

## Spatial continuity

- Preserve the object identity across state changes: move the thing that was touched rather than
  replacing it with an unrelated screen-sized effect.
- Make direction meaningful: forward and back navigation, expansion and collapse, and dismissals
  should visibly agree with the user’s action.
- Treat materials, blur, shadow, and depth as hierarchy tools. They must not reduce legibility or
  obscure the active control.
- Supply a reduced-motion behavior that preserves the outcome and feedback without travel or
  physics-heavy motion.

## Verification handoff

Test gestures on a real touch device where possible. Review slow-motion/frame-by-frame for
velocity seams, incorrect origins, and dropped frames; then load `core-verify-motion-review` for
the release gate.

---
name: core-verify-motion-review
description: Use for a motion-only review of UI code or a rendered interaction. Enforce purpose, frequency-appropriate timing, responsiveness, interruptibility, performance, and reduced-motion support; do not use as a general code-review skill.
---

# Motion Review

Review motion against a high craft bar. Approval is earned: an animation that technically runs
but is sluggish, ungrounded, overused, or janky is a regression.

This skill includes local copies of Emil Kowalski's original review skill and standards:
[`references/upstream-review-animations.md`](references/upstream-review-animations.md) and
[`references/upstream-motion-standards.md`](references/upstream-motion-standards.md). Read them
when a review needs the full rubric, numeric timing guidance, or example findings. Provenance
and update instructions live in [`UPSTREAM_SOURCES.md`](../../../UPSTREAM_SOURCES.md).

## What to check

1. Motion has a clear purpose: orientation, state, explanation, feedback, or avoiding a jarring
   change.
2. Frequency fits the motion: keyboard and very high-frequency actions are instant; repeated
   actions are minimal; occasional interactions may animate.
3. Enter/exit motion is responsive; ordinary UI motion is short. `ease-in` on UI entry is a
   finding, not a stylistic preference.
4. Trigger-anchored surfaces use the correct origin, never `scale(0)`; centered modals are the
   exception.
5. Rapidly retriggered and gesture-driven motion is interruptible and begins from the presented
   value.
6. Motion uses composited properties where possible (`transform`, `opacity`) and avoids layout
   churn, unbounded `transition: all`, and main-thread-heavy animation under load.
7. Reduced-motion alternatives retain comprehension, and hover motion is gated to fine hover
   pointers.
8. The motion matches the product’s personality and does not compete with content.

## Required output

First provide exactly one findings table, one row per issue:

| Before | After | Why |
| --- | --- | --- |
| `transition: all 300ms` | `transition: transform 200ms ease-out` | Bound the property and keep routine feedback responsive. |

Then group concise findings by impact: feel-breaking regressions, missed simplifications,
performance, interruptibility/timing, origin/cohesion, and accessibility. Cite `file:line` for
every code finding.

Close with **Block** when there is a feel-breaking, high-frequency, `scale(0)`, `ease-in`, or
easily fixed non-composited regression; otherwise close with **Approve**. If the result is unsure,
require slow-motion, frame-by-frame, and real-device inspection instead of guessing.

## Fix order

Prefer: delete unnecessary motion → reduce it → correct easing/origin → make it interruptible →
move it off layout/main-thread work → tune timing and polish → add accessibility support.

For precise curves, duration bands, spring guidance, gesture thresholds, and review examples,
consult the local source standards before asserting a numeric value.

## Local source references

- Full imported review skill: [`references/upstream-review-animations.md`](references/upstream-review-animations.md)
- Full imported standards: [`references/upstream-motion-standards.md`](references/upstream-motion-standards.md)

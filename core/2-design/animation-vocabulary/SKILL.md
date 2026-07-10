---
name: core-design-animation-vocabulary
description: Use when someone describes a motion effect vaguely and needs its precise name to write a design brief, prompt, or implementation specification; this skill names effects, not designs them.
status: draft
upstream: https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/animation-vocabulary
---

# Animation Vocabulary

Turn a description of what someone sees or feels into the most useful motion term.

**Upstream:** Emil Kowalski's [`animation-vocabulary`](https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e/skills/animation-vocabulary), adapted and tracked in [`UPSTREAM_SOURCES.md`](../../../UPSTREAM_SOURCES.md). Consult its full glossary when this local quick map is insufficient.

## Response format

Lead with the best term and a one-sentence definition. If there are plausible alternatives, give
at most two and say how they differ. Name the effect; do not turn a naming question into a design
lecture.

## Quick map

| What it does | Preferred term | Distinguish from |
| --- | --- | --- |
| Several items enter one after another | **Stagger** | Orchestration is the overall timing plan. |
| A popover grows from the clicked control | **Origin-aware animation** | A generic scale-in grows from its own center. |
| A thumbnail becomes its detail view | **Shared element transition** | A morph changes one shape; a crossfade only overlaps states. |
| Layout shifts smoothly into its new position | **Layout animation** | A page transition changes views/routes. |
| Content is uncovered by a boundary | **Reveal** | A mask supports soft edges; clip-path is the hard-edge mechanism. |
| A drag resists beyond an edge then returns | **Rubber-banding** | Momentum is the carried release velocity. |
| Elements respond to viewport position | **Scroll-driven animation** | A scroll reveal is one specific entrance pattern; parallax uses differing speeds. |
| A component overshoots slightly into place | **Pop in** | A spring is the physics mechanism; bounce describes the overshoot. |
| A value changes digit by digit | **Number ticker** | Use tabular numbers to avoid width jitter. |
| One state fades out as another fades in | **Crossfade** | Use continuity/shared-element language when identity is preserved. |

## Specification checklist

Once named, state the trigger, target, origin, animated properties, easing or spring behavior,
duration or response, interruption rule, and reduced-motion equivalent. Then load
`core-design-design-engineering` to decide whether the effect is justified.

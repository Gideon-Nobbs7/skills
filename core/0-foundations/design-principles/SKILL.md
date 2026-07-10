---
name: core-foundations-design-principles
description: Always-on interface design principles for clarity, hierarchy, feedback, accessibility, restraint, predictability, and trade-off decisions before visual, typography, motion, or platform design skills add specifics.
status: draft
---

# Design Principles

Design begins with the problem, not the pattern. For every interface decision, identify the user
goal, what changes, what must stay stable, and which constraints matter before choosing layout,
motion, content, or components.

Adapted from the local software architecture and design-pattern decision model at
`core/1-setup/stack-and-architecture-selection/references/software-architecture-and-design-patterns-guide.md`
and from W3C WAI accessibility principles.

## Priority order

When design values conflict, prefer:

1. **Comprehension** - the user can tell what this is, where they are, what changed, and what to do.
2. **Access** - the task remains perceivable, operable, understandable, and robust.
3. **Task fit** - the interface supports the real workflow, including errors and recovery.
4. **Consistency** - repeated components, labels, and flows behave predictably.
5. **Speed** - common work feels direct and avoids unnecessary ceremony.
6. **Delight** - polish, personality, and motion earn their place by supporting the above.

## Operating rules

- Start with the user's job and constraints. Do not begin with "which pattern/component/effect
  should I use?"
- Design the stable part first: information architecture, task sequence, state model, and error
  recovery before surface treatment.
- Give every state a design: empty, loading, partial, success, error, disabled, offline, and
  permission-denied.
- Make feedback immediate and proportional. Acknowledge actions quickly; reserve loud feedback for
  risk, progress, or irreversible outcomes.
- Use hierarchy before decoration: position, grouping, spacing, type, and labels should explain
  the interface before color, animation, or imagery helps.
- Use visual treatment as a system: layout, spacing, color, elevation, iconography, imagery, and
  motion must reinforce the same hierarchy rather than compete for attention.
- Keep repeated things predictable. The same action uses the same label, placement, and behavior
  unless the context truly changes the meaning.
- Treat accessibility as design material: contrast, text alternatives, keyboard paths, target size,
  reduced motion, readable language, and error help are part of the design, not a build cleanup.
- Prefer the simplest design that satisfies the current constraints. Add complexity only when it
  buys comprehension, flexibility for a known change axis, safety, or measurable workflow speed.
- Record rejected alternatives when a design chooses a costly pattern, unusual interaction, or
  platform deviation. The "why not" matters later.

## Handoffs

- Use `core-design-ux-and-flows` for product structure and prototype decisions.
- Use `core-design-typography`, `core-design-design-engineering`, and
  `core-design-fluid-interactions` for specific interface craft.
- Use platform overlays only for platform deltas; they do not redefine these priorities.

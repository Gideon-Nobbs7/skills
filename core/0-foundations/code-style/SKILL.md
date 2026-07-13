---
name: core-foundations-code-style
description: Always-on coding style and organization rules for naming, file shape, comments, types, module boundaries, pattern use, errors, and avoiding unnecessary abstraction across languages and tracks.
---

# Code Style & Conventions

Code should make the system's shape legible. Style is not prettiness; it is the shared language
that lets humans and agents change code without rediscovering intent.

Adapted from the local software architecture and design-pattern decision model at
`core/1-setup/stack-and-architecture-selection/references/software-architecture-and-design-patterns-guide.md`.

## Defaults

- Follow the repo formatter, linter, type checker, and local naming conventions before personal
  preference.
- Prefer explicit names over clever names. Use domain words from the project glossary when one
  exists.
- Keep names honest: `is/has/can/should` for booleans, nouns for values, verbs for commands,
  domain terms for domain objects, and transport/infrastructure terms only at the edge.
- Keep files organized around the project convention. If none exists, colocate by feature until a
  real shared boundary appears.
- Imports should reveal dependency direction. Core/domain code does not import UI, framework,
  database, or vendor code unless that dependency is the point of the module.

## Abstraction discipline

- Begin with the smallest obvious code that satisfies the current task.
- Add an abstraction only when a real variation exists: a second adapter, a changing algorithm, a
  repeated workflow, a replaceable provider, a stable public contract, or a meaningful test seam.
- Treat design patterns as named trade-offs, not badges. If the problem signal is absent, the
  pattern is likely ceremony.
- Prefer composition over inheritance when behavior must vary at runtime.
- Prefer a small facade over leaking a complicated subsystem to many callers.
- Prefer adapters at external/vendor/framework boundaries so the rest of the code speaks the
  product's language.
- Avoid global singletons unless the resource is truly process-wide and explicitly managed.

## Comments and documentation

- Comment why a surprising decision exists, what invariant must hold, or what external constraint
  forced the shape.
- Do not narrate obvious code.
- Document public contracts, module seams, error modes, configuration, and non-obvious performance
  or accessibility constraints.
- When a pattern or architecture is selected, record rejected alternatives in the decision record
  rather than burying the reasoning in scattered comments.

## Error and state style

- Use one error strategy per boundary. Do not mix thrown errors, nulls, result objects, and ad-hoc
  strings for the same contract.
- Validate at system edges; trust typed, already-validated internal data.
- Make states explicit when behavior changes by lifecycle. Replace large conditionals with a
  named state model only when transitions are real and recurring.
- Keep undo, retry, idempotency, and recovery visible in the names and contracts where they matter.

## Pattern lookup

For local coding problems, ask what varies:

- Concrete creation varies -> factory or builder.
- Vendor/interface mismatch varies -> adapter.
- Algorithm varies -> strategy.
- Lifecycle state varies -> state.
- Ordered checks vary -> chain of responsibility.
- Undo/queue/replay is needed -> command or memento.
- Many dependents react to one change -> observer locally, event-driven architecture only when it
  crosses process or ownership boundaries.

Load `core-setup-stack-and-architecture-selection` for system-level architecture decisions and
`core-build-architecture-in-practice` for module seams while coding.

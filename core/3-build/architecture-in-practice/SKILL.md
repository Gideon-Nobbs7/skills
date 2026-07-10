---
name: core-build-architecture-in-practice
description: Use when designing or restructuring module interfaces while coding — deep modules, seams and adapters, designing for testability, exploring alternative interfaces (design it twice), and the implementation working loop.
status: draft
---

# Architecture in Practice

Selection happened in `core/1-setup/stack-and-architecture-selection`; this is holding the
architecture together while code is written. The organizing idea: design **deep modules** —
a lot of behaviour behind a small interface, placed at a clean seam, testable through that
interface. Merged and adapted from Matt Pocock's `codebase-design` (+ DEEPENING,
DESIGN-IT-TWICE), `implement`, and `design-an-interface`
([source](https://github.com/mattpocock/skills)).

For architecture/pattern selection during implementation, use
`core/1-setup/stack-and-architecture-selection/references/software-architecture-and-design-patterns-guide.md`
as the lookup reference. Local code problems usually need a local pattern, not an architecture
change.

## Areas under consideration
- [x] Module boundary rules — deep-module vocabulary, seam discipline, deletion test
- [x] When to restructure — deepening shallow clusters, dependency categories
- [x] Interface exploration — design it twice
- [x] Implementation working loop
- [x] Layering & dependency direction — what may depend on what, enforcement
- [ ] Feature organization — the folder/module shape a feature always takes
- [ ] Shared code rules — when something graduates to shared, where it goes

## Skill

### Use this vocabulary exactly

Consistent language is the point — don't substitute "component," "service," or "boundary."

- **Module** — anything with an interface and an implementation; scale-agnostic (function,
  class, package, tier-spanning slice).
- **Interface** — everything a caller must know to use the module correctly: signature,
  invariants, ordering constraints, error modes, config, performance characteristics.
- **Depth** — leverage at the interface: behaviour exercised per unit of interface learned.
  Deep = small interface, lots behind it; shallow = interface nearly as complex as the
  implementation.
- **Seam** — the place you can alter behaviour without editing in that place; where the
  interface lives. Seam placement is its own design decision. (Say seam, not "boundary".)
- **Adapter** — a concrete thing satisfying an interface at a seam; a role, not substance.
- **Leverage** (callers) and **locality** (maintainers) are what depth buys: one
  implementation pays back across N call sites; change and bugs concentrate in one place.

### Design deep modules

When shaping an interface ask: can I reduce the methods? simplify the parameters? hide more
complexity inside? Principles:

- Depth is a property of the interface, not the implementation — a deep module may be
  internally composed of small swappable parts with **internal seams** (private, used by
  its own tests); don't expose them through the interface.
- **The deletion test** — imagine deleting the module: if complexity vanishes it was a
  pass-through; if it reappears across N callers it was earning its keep.
- **The interface is the test surface** — callers and tests cross the same seam; wanting to
  test past it means the module is the wrong shape.
- **One adapter is a hypothetical seam; two adapters is a real one** — don't introduce a
  seam unless something actually varies across it (typically production + test).

### Design for testability

Accept dependencies, don't create them (inject the gateway, don't `new` it inside). Return
results, don't produce side effects. Keep the surface small — fewer methods means fewer
tests, fewer params means simpler setup.

### Deepen shallow clusters by dependency category

The category determines how the deepened module is tested across its seam:

1. **In-process** (pure computation) — always deepenable; merge and test directly.
2. **Local-substitutable** (PGLite, in-memory fs) — deepenable when the stand-in exists;
   test with the stand-in; the seam stays internal.
3. **Remote but owned** (your services over a network) — define a port at the seam; inject
   HTTP/gRPC adapter in production, in-memory adapter in tests; the logic sits in one deep
   module even though it's deployed across a network.
4. **True external** (Stripe, Twilio) — injected port; tests provide a mock adapter.

When deepening, **replace tests, don't layer them**: old unit tests on the shallow modules
become waste once interface-level tests exist — delete them. New tests assert observable
outcomes through the interface and survive internal refactors.

### Design it twice

Your first interface idea is unlikely to be the best. For a significant module: frame the
problem space (constraints, dependencies and their categories, a grounding sketch), then
produce 3+ **radically different** interface designs in parallel — one minimizing the
interface (1–3 entry points, max leverage each), one maximizing flexibility, one optimizing
the most common caller, one built on ports & adapters if cross-seam dependencies exist.
Each design shows: the interface (with invariants and error modes), a usage example, what
the implementation hides, dependency strategy, and trade-offs. Compare on depth, locality,
and seam placement — then give an opinionated recommendation (or hybrid), not a menu.

### Application-level modularity

(Adapted from Greenspun et al. —
[Software Modularity](https://philip.greenspun.com/seia/software-modularity).) The
deep-module discipline above, applied at application scale so multiple programmers — and
generations of programmers — work without treading on each other:

- **Decompose by user-visible module** (forum, calendar, registration): each owns its
  URL directory, its data-model definitions, and its documentation; one module is
  understandable and modifiable without reading the others.
- **Uniform file and naming conventions** — a fixed convention for where page code,
  data models, shared procedures, and docs live. Consistency is worth more than any
  individual convention's elegance.
- **Shared logic in one place** — procedures used by more than one page live in a shared
  library (or in the database when the logic is fundamentally about data integrity).
  Duplicated logic drifts; drifted logic corrupts data.
- **Intermodule APIs, never table-reaching** — when module A needs module B's data, it
  calls a documented procedure B publishes, not B's tables. The canonical example: each
  content module publishes a "recent items" procedure, so a site-wide what's-new page,
  digest email, or external web service assembles without knowing any module's
  internals.
- **Centralize configuration** — site name, admin contacts, feature toggles in one
  facility, never scattered as literals.
- **Document as you build** — per-module purpose, data model, config, known limitations;
  documentation written after the fact is documentation never written
  (`core-operate-documentation`).
- **Separate design from programming with the lightest hammer the team requires** —
  templating separation ranges from CSS-only up to full logic/presentation split;
  heavier separation costs development speed, so buy only what the team's structure
  needs.

### The implementation working loop

Implement from the spec or tickets, in increments (adapted from Addy Osmani's
`incremental-implementation`). The cycle: implement the smallest complete piece → test →
verify (build, types, lint) → commit → next slice. Never write more than ~100 lines
without running tests; bugs compound — a bug in slice 1 makes slices 2–5 wrong.

- **Simplicity first** — before code: "what's the simplest thing that could work?"
  After: can it be fewer lines? are the abstractions earning their complexity? building
  for the current task or hypothetical futures? Three similar lines beat a premature
  abstraction; implement the naive, obviously-correct version first, optimize after
  correctness is proven.
- **Scope discipline** — touch only what the task requires: no adjacent "cleanup", no
  refactoring files you're only reading, no unrequested features. Note out-of-scope
  improvements ("noticed but not touching") and offer them as tasks.
- **One logical change per increment**; refactors and features never mix.
- **Keep it compilable** — the project builds and existing tests pass after every
  increment; feature-flag incomplete work so increments can merge without exposing it;
  new code defaults to safe, conservative, opt-in behaviour.
- **Rollback-friendly** — prefer additive changes; keep modifications minimal and
  focused; don't delete and replace in the same commit.
- Slicing strategies: **vertical** (default — one complete path through the stack),
  **contract-first** (define the API contract, then backend and frontend in parallel),
  **risk-first** (prove the riskiest piece before investing in the rest).

Test-first at pre-agreed seams (`core-verify-test-authoring`). Run typechecking
regularly, single test files regularly, the full suite once at the end — but don't re-run
an unchanged command for reassurance; it adds no information. Review the work
(`core-verify-code-review`) before calling it done. Commit to the current branch.

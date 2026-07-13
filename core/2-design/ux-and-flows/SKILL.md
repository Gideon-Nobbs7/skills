---
name: core-design-ux-and-flows
description: Use when structuring a product's UX or answering a design question with a throwaway prototype — logic prototypes (interactive TUI over a pure state module) or UI prototypes (radically different variants switched by URL param).
---

# UX & Flows

How the product is structured and how users move through it. The first filled discipline:
**prototyping to answer design questions**, adapted from Matt Pocock's `prototype`
(+ LOGIC, UI) ([source](https://github.com/mattpocock/skills)).

## Areas under consideration
- [x] Prototyping — logic and UI branches, throwaway rules, capturing the answer
- [ ] IA method — how screens/sections get organized and named
- [ ] Navigation model selection — tabs vs drawer vs hierarchy, per product shape
- [ ] State design requirement — every view specifies empty, loading, error, and success
- [ ] Flow documentation — the format flows are captured in so agents can implement them
- [ ] Friction rules — where confirmation/undo is required, where flow must be uninterrupted

## Skill

### A prototype is throwaway code that answers a question

The question decides the shape. "Does this logic/state model feel right?" → **logic
branch**. "What should this look like?" → **UI branch**. Getting the branch wrong wastes
the whole prototype; if ambiguous and the user is away, match the surrounding code
(backend module → logic; page/component → UI) and state the assumption at the top.

Rules for both branches:

1. Throwaway from day one and clearly marked — located near where it'll be used, named so
   a casual reader sees it's a prototype; obey the project's existing conventions.
2. One command to run, via the project's existing task runner.
3. No persistence by default — state in memory; if the question involves a database, a
   scratch store with a clear "PROTOTYPE — wipe me" name.
4. Skip the polish: no tests, no error handling beyond runnable, no abstractions.
5. Surface the state after every action / on every variant switch.
6. Delete or absorb when done. The **answer** is the only thing worth keeping — capture it
   durably (commit message, ADR, issue, or a NOTES.md beside the prototype) with the
   question it answered.

### Logic branch — a TUI over a pure module

State the question first, one paragraph at the top. Isolate the logic behind a small
**pure** interface liftable into the real codebase later — a reducer
(`(state, action) => state`), an explicit state machine (when "which actions are legal
now" is the question), a set of pure functions, or a stateful module — picked to fit the
question, not the TUI. No I/O or terminal code in the logic; the TUI imports it, never the
reverse. The TUI: clear and re-render a full frame each action — current state
pretty-printed (bold names, dim context), then keyboard shortcuts — one keystroke
dispatched per loop, whole frame fits one screen. Hand over the run command; the
interesting moments are "wait, that shouldn't be possible" — bugs in the *idea*. When
done, lift the validated logic module; delete the shell.

### UI branch — radically different variants on one route

Default 3 variants, cap 5. **Strongly prefer mounting variants inside an existing page**
(gated by a `?variant=` search param, existing data/auth intact) — variants judged against
real header, real data, real density; an isolated route is a vacuum where everything looks
fine. A new throwaway route is the last resort, named obviously as a prototype. Variants
must be **structurally** different — layout, information hierarchy, primary affordance —
not recoloured card grids; if two come out similar, redo one with an explicit structural
ban. Use the project's component library. Wire a floating bottom switcher (arrows cycling
the URL param via the router so variants are shareable; ← / → keys except in inputs;
visually distinct from the design under evaluation; hidden in production builds). The
interesting feedback is "the header from B with the sidebar from C" — that's the design.
When one wins: record which and why, fold the winner in (rewritten properly — it was
built under prototype constraints), delete the losers and the switcher.

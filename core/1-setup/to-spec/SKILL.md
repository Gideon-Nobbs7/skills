---
name: to-spec
description: Use when the deciding is already done and the user wants the settled conversation turned into a written spec/PRD — the /to-prd skill, renamed. No interview, just synthesis of what was discussed into a spec published to the issue tracker. Invoked as /to-spec; pair with grill-me or grill-with-docs upstream and planning-and-work-breakdown downstream.
---

# To-spec

Turn the conversation you've just had into a **spec** (a PRD), and publish it to the issue
tracker as a single issue. This is the `/to-prd` skill, renamed in v1.1 — "spec" is now the
through-line term, and the old `to-prd` slug is dead.

Port of Matt Pocock's `to-spec`
([source](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-spec)),
adapted into godfile voice. The full spec template and discipline also live in
`core-setup-planning-and-work-breakdown`; this is the standalone invocation.

## Do not interview

By the time you reach for this the deciding is already done. **Synthesize** what is known —
from the thread, from the codebase, from the `CONTEXT.md` glossary and ADRs — rather than
opening a fresh round of questions. The spec is a record of decisions already made, not a
place where new ones get made. Anything the spec asserts that the user never said is a
defect.

Reach for it when the build is too big for one session and has to survive being split
across several. If nothing is decided yet, run `grill-with-docs` first; if the work fits
one context window, skip the spec and go straight to `implement`.

## Seams before prose

Before writing a word, sketch the **seams** the feature will be tested at and check them
with the user. Prefer seams that already exist to new ones; take the highest seam you can —
the ideal number across a change is one. Those agreed seams then travel: `tdd` works only
at pre-agreed seams, and `code-review` checks the diff against the spec, so a seam nobody
agreed to shows up as a review finding.

## Write the spec

Use the project's domain vocabulary and respect any ADRs in the area. Then write the spec:

- **Problem Statement** and **Solution** — from the user's perspective.
- **User Stories** — a long, numbered, extensive list: "As an <actor>, I want <feature>,
  so that <benefit>".
- **Implementation Decisions** — modules and interfaces, technical clarifications,
  architectural decisions, schema changes, API contracts. No file paths or code snippets
  (they go stale) — except a prototype-derived snippet that encodes a decision more
  precisely than prose (state machine, schema, type shape), trimmed to the decision-rich
  parts.
- **Testing Decisions** — what makes a good test (external behaviour, not implementation),
  which modules, prior art in the codebase.
- **Out of Scope** and **Further Notes**.

Publish it to the project's issue tracker with the `ready-for-agent` label (no further
triage needed). If the tracker and triage vocabulary weren't configured, tell the user.

## It's working if

- It starts writing rather than asking a fresh round of questions.
- It puts the seams to you before it writes, and proposes as few as it can get away with.
- It comes back in the project's nouns, not generic product-management boilerplate.
- Every decision in it is one you can remember making — nothing was invented to fill a section.
- The out-of-scope section has real things in it; the things refused are usually the most
  useful lines on the page.

## Completion and handoff

The spec is the decision record that survives the context window: it lets a fresh session
pick the work up without the user re-explaining it. Hand it to the standalone `to-tickets`
skill to cut it into tracer-bullet tickets, or keep the same conversation going into
`implement` (in `core-setup-planning-and-work-breakdown`) for a change small enough to build
now. The artifacts meant to outlive the spec are the `CONTEXT.md` glossary and the ADRs
written by `grill-with-docs`.

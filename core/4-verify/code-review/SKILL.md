---
name: core-verify-code-review
description: Use when reviewing changes since a fixed point, or when a non-trivial in-flight decision needs adversarial scrutiny — two independent axes (Standards: repo conventions plus a Fowler smell baseline; Spec: does the diff implement what was asked) never merged, plus the bounded doubt cycle (claim → extract → fresh-context adversarial review → reconcile → stop).
status: draft
---

# Code Review

What a review looks for and how findings are handled — for human and agent reviewers
alike. Adapted from Matt Pocock's `code-review`
([source](https://github.com/mattpocock/skills/tree/main/skills/engineering/code-review)).

## Areas under consideration
- [x] Review structure — the two-axis model
- [x] Baseline smell taxonomy
- [x] Review scope — diff against a pinned fixed point
- [x] In-flight adversarial review — the doubt cycle
- [ ] Priority order — correctness > security > simplicity > style? The user's ranking
- [ ] Severity taxonomy — what blocks merge vs what's a suggestion
- [ ] Self-review checklist — what's checked before requesting review
- [ ] How /code-review passes fit in, at what effort

## Skill

### Review along two independent axes

A change can pass one axis and fail the other — code that follows every standard but
implements the wrong thing, or does exactly what the issue asked while breaking
conventions. Review **Standards** (does the code conform to the repo's documented
standards?) and **Spec** (does the diff faithfully implement the originating
issue/PRD/spec?) separately — as parallel sub-agents when available so they don't pollute
each other's context — and report them under separate headings. Never merge or rerank
findings across axes, and never pick a single winner: end with findings-per-axis counts
and the worst issue *within each axis*.

### Pin the fixed point first

The review target is `git diff <fixed-point>...HEAD` (three-dot — against the merge-base),
plus the commit list from `git log <fixed-point>..HEAD --oneline`. If the user didn't name
a fixed point, ask. Confirm the ref resolves and the diff is non-empty before doing any
review work.

### Find the spec source

In order: issue references in commit messages (`#123`, `Closes #45`) → a path the user
passed → a PRD/spec file under `docs/`, `specs/`, or scratch dirs matching the branch →
ask the user. If there is no spec, skip the Spec axis and say so in the report. The Spec
axis reports: (a) requirements missing or partial, (b) behaviour not asked for (scope
creep), (c) requirements implemented but implemented wrong — quoting the spec line for
each finding.

### The Standards axis: repo docs plus the smell baseline

Use whatever the repo documents (CODING_STANDARDS.md, CONTRIBUTING.md, CLAUDE.md) — plus
this fixed baseline of Fowler smells (*Refactoring* ch.3), which applies even when the
repo documents nothing. Two rules bind it: **the repo overrides** (a documented standard
wins; suppress a smell it endorses), and **every smell is a judgement call** ("possible
Feature Envy"), never a hard violation. Skip anything tooling already enforces. Each smell
reads *what it is* → *how to fix*:

- **Mysterious Name** — name doesn't reveal what it does/holds → rename; if no honest name
  comes, the design's murky.
- **Duplicated Code** — same logic shape in multiple hunks/files → extract, call from both.
- **Feature Envy** — a method reaching into another object's data more than its own → move
  it onto the data it envies.
- **Data Clumps** — the same few fields/params travelling together → bundle into one type.
- **Primitive Obsession** — a primitive standing in for a domain concept → give it a type.
- **Repeated Switches** — the same switch/if-cascade on the same type recurring → replace
  with polymorphism or one shared map.
- **Shotgun Surgery** — one logical change forcing scattered edits → gather what changes
  together into one module.
- **Divergent Change** — one module edited for several unrelated reasons → split so each
  changes for one reason.
- **Speculative Generality** — abstraction/hooks for needs the spec doesn't have → delete;
  inline until a real need shows.
- **Message Chains** — long `a.b().c().d()` navigation → hide the walk behind one method.
- **Middle Man** — a thing that mostly delegates onward → cut it, call the target direct.
- **Refused Bequest** — an implementer ignoring most of what it inherits → drop the
  inheritance, use composition.

Distinguish hard violations (documented-standard breaches can be) from judgement calls
(baseline smells always are), citing the standard or naming the smell and quoting the hunk.

### Doubt-driven review: in-flight, not just post-hoc

(Adapted from Addy Osmani's `doubt-driven-development` —
[source](https://github.com/addyosmani/agent-skills).) The two-axis review above is a
verdict on a finished diff; doubt-driven is the same adversarial energy applied *while
working*, when course-correction is cheap. A confident answer is not a correct one — long
sessions quietly turn assumptions into "facts".

Apply to **non-trivial decisions only**: new/changed branching logic, crossing a
module/service boundary, asserting properties the compiler can't verify (thread safety,
idempotence, ordering), correctness depending on invisible context, or irreversible blast
radius. Never for renames, formatting, or clear instructions — doubt every keystroke and
you ship nothing.

The cycle (bounded, max 3 rounds):

1. **Claim** — name the decision in 2–3 lines plus why it matters. Can't write it that
   compactly? You have a vibe, not a decision.
2. **Extract** — the smallest reviewable unit: the artifact (diff, proposal) and its
   contract (the constraints it must satisfy). Strip your reasoning — hand over
   conclusions and you get back validation of them.
3. **Doubt** — a fresh-context reviewer with an explicitly adversarial prompt ("find
   what is wrong; assume the author is overconfident; look for unstated assumptions,
   unhandled edges, hidden coupling, contract violations; do NOT validate"). Pass
   artifact + contract **only, never the claim** — handing over your conclusion biases
   toward agreement.
4. **Reconcile** — findings are data, not verdict; re-read the artifact against each and
   classify in precedence order: contract misread (fix the contract) → valid+actionable
   (change, re-loop) → valid trade-off (document it) → noise (the reviewer lacked
   context — would adding it to the contract have prevented the flag?).
5. **Stop** — when findings go trivial, at 3 cycles (escalate — three unresolved cycles
   is information about the artifact), or on the user's "ship it". If 3 cycles feels
   insufficient, the artifact is too big: decompose, don't lift the bound.

Watch for **doubt theater**: multiple cycles with substantive findings and zero
classified actionable means you're validating, not doubting — stop and escalate. TDD's
red step is doubt made concrete: a failing test satisfies this for behavioural claims.

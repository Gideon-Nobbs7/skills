---
name: grill-with-docs
description: Use when the user is in a repo, a change's plan is still fuzzy, and the words for the thing are not settled — the single-session, stateful grilling front door. Runs the same interview as grill-me but pointed at a codebase and writes the vocabulary and hard decisions to disk as it goes: terms land in a CONTEXT.md glossary, hard-to-reverse decisions land as ADRs. Invoked as /grill-with-docs at the start of a change; needs the grilling (planning-and-work-breakdown) and domain-modeling (scoping-and-requirements) content available.
---

# Grill-with-docs

Interview a plan or design in a repo until you and the user share one understanding, and
write the vocabulary and the hard decisions into the repo while you do. The same round /
frontier interview as `grill-me`, but **stateful**: it leaves files on disk. Where
`grill-me` sharpens the idea in your head, this one captures it in the repo.

Port of Matt Pocock's `grill-with-docs`
([source](https://github.com/mattpocock/skills/tree/main/skills/engineering/grill-with-docs)),
adapted into godfile voice. It delegates to two existing godfile homes: the interview comes
from `core-setup-planning-and-work-breakdown` (grilling), the writing from
`core-setup-scoping-and-requirements` (domain-modeling: glossary and ADRs).

## Reach for it

At the start of a change, **in a repo**, when the plan is still fuzzy and the words for the
thing are not settled, and the change fits one session. Which grilling front door fits:

| What you have | Reach for |
|---|---|
| No working directory at all | `grill-me` |
| A repo, and a change you can settle in one session | `grill-with-docs` |
| An effort too big to hold in one session (greenfield, large feature) | `wayfinder` in `core-setup-planning-and-work-breakdown` |
| A repo with no domain docs, and no feature in mind | `grill-with-docs`, aimed at the repo rather than a change |
| A decision blocked on knowledge in someone else's head | `to-questionnaire` |

The wayfinder split is session count: single-session planning → `grill-with-docs`;
multi-session planning → `wayfinder`.

## Run the interview

Work the same design tree in rounds as `grill-me`: ask the whole **frontier** (every
question whose prerequisites are settled) in one round, each with a recommended answer,
then wait; recompute the frontier; one question at a time is the floor, a round of the
settled frontier is the ceiling. Find facts in the codebase yourself; put decisions to the
user.

## The paper trail

Three things come out of a session, and they are not equal:

| What resolved | Where it lands |
|---|---|
| A term — the project's own word for a thing | `CONTEXT.md` glossary, inline, the moment it resolves |
| A decision that is hard to reverse, surprising without context, and a real trade-off | An ADR under `docs/adr/` |
| Everything else you decided | The conversation, and nowhere else |

That third row catches people out. `CONTEXT.md` is a **glossary and is kept as one**: no
implementation details, no spec, no scratch notes. ADRs are gated on **all three** conditions
at once, so most decisions don't qualify and most sessions produce none — a session that
yields a sharper glossary and zero ADRs is working as designed. The bulk of what you agreed
exists only in the conversation it was agreed in, so hand that same conversation to `to-spec`
(see `core-setup-planning-and-work-breakdown`) rather than clearing it.

The glossary is the point: domain language is what this skill builds. The project's own
words, agreed once, so the agent and the team stop paying to re-derive them. A term and its
plain-English expansion may get the same result from a model; the value is that shared
vocabulary compresses communication between the humans and agents who use it.

## It's working if

- `CONTEXT.md` changes *during* the session, term by term, rather than appearing in one lump
  at the end.
- The glossary reads as pure vocabulary — the project's words with tight definitions — and
  contains no implementation detail or spec-like prose.
- Questions the codebase can answer get answered by reading the codebase, not asked of you.
- You get few or no ADRs, and the ones you get are decisions you'd be annoyed to have to
  re-litigate.
- It challenges a word you used because your existing glossary defines it differently.

## Completion and handoff

The session ends when the **frontier is empty**: every branch visited, nothing silently
assumed — and the docs that qualified have been written as you went. Then keep the same
conversation going: feed it straight to `to-spec` (multi-session work) or `implement`
(small enough to build now) in `core-setup-planning-and-work-breakdown`. Do not start a
fresh session and lose the context.

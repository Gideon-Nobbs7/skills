---
name: to-tickets
description: Use when the deciding is done and a plan, spec, or settled conversation needs to be broken into tracer-bullet tickets/issues, each declaring its blocking edges, published to the configured tracker. Invoked as /to-tickets; downstream of to-spec, upstream of implement. Needs the tracker and triage-label vocabulary configured.
---

# To-tickets

Break a plan, spec, or settled conversation into a set of **tickets**: tracer-bullet
vertical slices, each declaring the tickets that **block** it, published to the configured
tracker. The tickets are the execution steps that get to the destination the spec fixes;
the spec is the decision record, the tickets are disposable.

Port of Matt Pocock's `to-tickets`
([source](https://github.com/mattpocock/skills/tree/main/skills/engineering/to-tickets)),
adapted into godfile voice. The ticket-slicing discipline also lives in
`core-setup-planning-and-work-breakdown`; this is the standalone invocation. Needs the
tracker and triage-label vocabulary configured; if not, tell the user to run
`/setup-matt-pocock-skills`.

## Gather context

Work from whatever is already in the conversation. If the user passes a reference (a spec
path, an issue number or URL) as an argument, fetch it and read its full body and comments.
If you haven't explored the codebase yet, do so: ticket titles and descriptions use the
project's domain glossary vocabulary and respect ADRs in the area you're touching. Look for
opportunities to **prefactor** — "make the change easy, then make the easy change."

## Draft vertical slices

Break the work into **tracer bullets**:

- Each slice cuts a narrow but **complete** path through every layer (schema, API, UI,
  tests) — vertical, not a horizontal slice of one layer.
- A completed slice is **demoable or verifiable on its own**.
- Each slice is **sized to one fresh context window**.
- Any prefactoring happens first.

Give each ticket its **blocking edges**: the other tickets that must complete before it can
start. A ticket with no blockers can start immediately.

**Wide refactors are the exception.** A wide refactor is one mechanical change (rename a
column, retype a shared symbol) whose **blast radius** fans across the whole codebase, so a
single edit breaks thousands of call sites and no vertical slice can land green. Don't force
it into a tracer bullet; sequence it as **expand–contract**: add the new form beside the old
so nothing breaks; migrate call sites over in batches sized by blast radius (per package,
per directory), each batch its own ticket blocked by the expand, CI green batch to batch;
then contract — delete the old form once no caller remains, in a ticket blocked by every
migrate batch. When even the batches can't stay green alone, keep the sequence but let them
share an integration branch that all block a final integrate-and-verify ticket; green is
promised only there.

## Quiz the user

Present the proposed breakdown as a numbered list. For each ticket show:

- **Title** — short descriptive name.
- **Blocked by** — which other tickets must complete first.
- **What it delivers** — the end-to-end behaviour this ticket makes work.

Ask: does the granularity feel right? Are the blocking edges correct — does each ticket only
depend on tickets that genuinely gate it? Should any be merged or split further? Iterate
until the user approves.

## Publish the tickets

Publish the approved tickets to the configured tracker. The tickets are the same either way;
only the shape of the blocking edges changes:

- **Local files** — write one file per ticket under
  `.scratch/<feature-slug>/issues/<NN>-<slug>.md`, numbered from `01` in dependency order
  (blockers first). Each file's "Blocked by" lists the numbers/titles it depends on. One
  ticket per file, never a single combined file.
- **A real issue tracker** (GitHub, Linear, …) — publish one issue per ticket in dependency
  order (blockers first) so blocking edges can reference real identifiers. Use the platform's
  native blocking / sub-issue relationship where it has one; otherwise set each ticket's
  "Blocked by" to the blocking issues. Apply the `ready-for-agent` triage label unless told
  otherwise; tickets are agent-grabbable by construction.

In either form, avoid specific file paths or code snippets — they go stale fast. Exception:
a prototype-derived snippet that encodes a decision more precisely than prose (state machine,
reducer, schema, type shape), trimmed to the decision-rich parts. Do **not** close or modify
any parent issue.

## It's working if

- Each ticket is a narrow but complete vertical slice — demoable on its own.
- Every ticket fits one fresh context window, and prefactoring is done first.
- Blocking edges are genuine: no ticket depends on work that doesn't gate it.
- The user approved the breakdown before anything was published.
- Blockers are published first, in dependency order, so the frontier is visible.

## Completion and handoff

Work the **frontier**: any ticket whose blockers are all done — one ticket per session,
clearing context between tickets. Each ticket is sized for one fresh context window and gets
closed when done, while the spec stays as the one place the reasoning lives. When the frontier
runs out, the change is sliced and ready: hand the first frontier ticket to `implement` (in
`core-setup-planning-and-work-breakdown`).
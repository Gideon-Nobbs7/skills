---
name: core-setup-planning-and-work-breakdown
description: Use when turning an idea into actionable work — refining vague ideas (divergent/convergent), stress-testing a plan by interview (grilling), writing gated specs, breaking work into tracer-bullet tickets with blocking edges and checkpoints, charting oversized efforts as a wayfinder map, triaging issues, or handing off between sessions.
status: draft
---

# Planning & Work Breakdown

From loose idea to work an agent (or human) can pick up: refine the idea, interrogate the
plan, write the spec, slice it into tickets, and manage efforts too big for one session.
Merged and adapted from Matt Pocock's `grilling`, `to-spec`, `to-tickets`, `wayfinder`,
`triage`, and `handoff` ([source](https://github.com/mattpocock/skills)), complemented by
Addy Osmani's `idea-refine`, `spec-driven-development`, and `planning-and-task-breakdown`
([source](https://github.com/addyosmani/agent-skills)).

## Areas under consideration
- [x] Idea refinement — divergent/convergent, upstream of grilling
- [x] Plan interrogation (grilling)
- [x] Spec format and process — gated workflow, assumptions, success criteria
- [x] Ticket breakdown — tracer bullets, blocking edges, sizing, checkpoints
- [x] Oversized work — wayfinder maps, fog of war
- [x] Triage state machine
- [x] Session handoff
- [ ] The user's preferred issue tracker(s) and label vocabulary
- [ ] When each mode applies by project size — thresholds for spec vs tickets vs map

## Skill

### Refine raw ideas before planning them

When the idea itself is still vague, run divergent-then-convergent refinement upstream of
any grilling. **Diverge**: restate it as a crisp "How might we…" problem; ask 3–5
sharpening questions (who is this for specifically, what does success look like, real
constraints, what's been tried, why now) — don't proceed without the who and the success
picture; generate 5–8 considered variations through lenses (inversion, constraint
removal, audience shift, combination, 10×-simpler, 10×-scale), grounded in the existing
codebase when there is one. **Converge**: cluster what resonated into 2–3 genuinely
different directions; stress-test each on user value (painkiller or vitamin?),
feasibility, differentiation; and **surface hidden assumptions** — what you're betting is
true, what could kill it, what you're consciously ignoring — this is where most ideation
fails. Be honest, not supportive: push back on weak ideas with specificity. **Ship**: a
one-pager — problem statement, recommended direction, assumptions to validate (each with
how to test it), MVP scope, open questions, and a **"Not doing" list with reasons** —
arguably the most valuable part; focus is saying no to good ideas.

### Grill plans before building

Stress-test a plan by relentless interview: walk each branch of the design tree, resolving
dependencies between decisions one by one, offering a recommended answer with every
question. **One question at a time** — wait for the answer before the next; multiple
questions at once are bewildering. Look up *facts* in the codebase yourself; put *decisions*
to the user. Do not enact the plan until shared understanding is confirmed. When decisions
land, record them (ADRs, glossary — see `core-operate-documentation` and
`core-setup-scoping-and-requirements`).

### Turn a settled conversation into a spec

No interview — synthesize what's already discussed. First explore the repo, use the
project's domain vocabulary, and respect ADRs in the area. Sketch the **seams** where the
feature will be tested — prefer existing seams, put new ones as high as possible, ideal
count is one — and confirm them with the user. Then write the spec:

- **Problem Statement** and **Solution** — from the user's perspective.
- **User Stories** — a long, numbered, extensive list: "As an <actor>, I want <feature>,
  so that <benefit>".
- **Implementation Decisions** — modules, interfaces, schema changes, API contracts,
  architectural decisions. No file paths or code snippets (they go stale) — except a
  prototype-derived snippet that encodes a decision more precisely than prose (state
  machine, schema, type shape), trimmed to the decision-rich parts.
- **Testing Decisions** — test external behaviour, not implementation; which modules;
  prior art in the codebase.
- **Out of Scope** and **Further Notes**.

Publish to the project's tracker and mark it agent-ready.

Complementary spec discipline (from spec-driven development):

- **The workflow is gated** — specify → plan → tasks → implement, with the user
  validating each phase before the next. The spec's entire purpose is surfacing
  misunderstandings before code exists.
- **Surface assumptions immediately** — before writing spec content, list what you're
  assuming ("this is web, not native"; "auth is session-based"; "Postgres, from the
  existing schema") and ask for corrections. Silently filled-in ambiguity is the most
  dangerous form of misunderstanding.
- **Reframe vague requirements as testable success criteria** — "make the dashboard
  faster" becomes "LCP < 2.5s on 4G; initial load < 500ms; CLS < 0.1 — are these the
  right targets?" so you can loop toward a goal instead of guessing.
- **Specs also carry the working contract** — exact commands (build/test/lint/dev with
  flags), project structure, a code-style snippet (one real example beats three
  paragraphs), testing strategy, and three-tier boundaries (always do / ask first /
  never do).
- **The spec lives** — update it when decisions or scope change (spec first, then
  implement), commit it with the code, link PRs back to the section they implement. Even
  a simple task deserves a two-line spec: acceptance criteria, always.

### Break work into tracer-bullet tickets

Each ticket is a **vertical slice**: a narrow but complete path through every layer
(schema, API, UI, tests) — demoable on its own, sized to one fresh context window, with
prefactoring done first ("make the change easy, then make the easy change"). Give each
ticket its **blocking edges** — the tickets that must complete before it starts. Present
the breakdown for approval (granularity right? edges genuine? merge or split?), then
publish one issue/file per ticket in dependency order, blockers first. Work the
**frontier** — any ticket whose blockers are all done — one ticket per session, clearing
context between tickets.

Complementary breakdown discipline (from planning-and-task-breakdown):

- **Plan in read-only mode** — read the spec and codebase, map the dependency graph
  (schema → models → endpoints → client → UI), note risks; no code during planning. The
  output is a written plan and task list, not implementation.
- **Every task carries** acceptance criteria (≤3 bullets or it's too big), a verification
  step (test command, build, manual check), dependencies, likely files, and a size.
  Sizing: S/M (1–5 files, one focused session) is the agent sweet spot; anything 8+
  files, 2+ hours, spanning independent subsystems, or with "and" in the title gets
  broken down further.
- **Order and checkpoint** — dependencies first, high-risk tasks early (fail fast), the
  system working after every task, and an explicit checkpoint every 2–3 tasks (tests
  pass, builds clean, core flow works, review with the user).
- **Parallelize deliberately** — independent slices and docs are safe; migrations and
  shared state are sequential; work sharing an API contract needs the contract defined
  first.

**Wide refactors are the exception**: one mechanical change whose blast radius spans the
codebase can't land green as a slice. Sequence it as **expand–contract**: add the new form
beside the old; migrate call sites in batches sized by blast radius, each batch a ticket
blocked by the expand, CI green throughout; contract by deleting the old form once no
caller remains, blocked by every batch.

### Chart oversized work as a map

When an effort is too big for one session and the way isn't visible, don't charge at the
destination — chart it. The **map** is a single tracker issue: a low-resolution index
holding the **Destination** (named first — it fixes scope), **Notes**, **Decisions so far**
(one line + link per closed ticket; the detail lives in the ticket, never restated),
**Not yet specified** (the **fog of war** — questions you can tell are coming but can't
phrase sharply yet), and **Out of scope** (consciously ruled out; never graduates).

Tickets are child issues, each one question sized to a session, typed **research** (AFK),
**prototype** (human-in-the-loop), **grilling** (HITL, the default), or **task** (the one
type that does rather than decides — it earns its place by unblocking a decision). Fog vs
ticket: can you state the question precisely *now*? (Not: can you answer it.) Working the
map: load it, claim the first frontier ticket before any work, resolve it (zooming into
related tickets on demand), post the answer as a resolution comment, close, append a
pointer to Decisions-so-far, graduate any fog the answer sharpened. **Never resolve more
than one ticket per session.** Refer to maps and tickets by name, never bare ids. The map
is planning by default: produce decisions, not deliverables — the pull to just do the work
signals it's time to hand off.

### Triage incoming issues

Each issue carries one category (`bug` / `enhancement`) and one state (`needs-triage`,
`needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). Process: gather full
context, check for **redundancy** (already implemented — search by domain concept, not the
request's wording) and **prior rejection**; recommend category + state and wait for
direction; **verify the claim** (reproduce the bug, run the PR's tests) before any
grilling; grill into shape if needed; apply the outcome — an agent-ready brief, specific
needs-info questions (never "please provide more info"), or a wontfix whose comment
depends on *why*. Mark AI-generated tracker comments as such. External PRs are issues with
attached code — same machine.

### Hand off between sessions

Write a handoff document a fresh agent can continue from: outside the workspace, with a
suggested-skills section, referencing (not duplicating) existing artifacts — specs, ADRs,
issues, commits — by path or URL, sensitive values redacted, tailored to what the next
session will do.

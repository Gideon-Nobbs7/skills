---
name: core-foundations-writing-skills
description: Use when writing, editing, or reviewing godfile skills themselves — the principles that make a skill predictable for agents (descriptions as triggers, information hierarchy, leading words, pruning, failure modes).
---

# Writing Skills

How godfile skills themselves are written and kept lean. A skill exists to wrangle
determinism out of a stochastic system: **predictability** — the agent taking the same
*process* every run, not producing the same output — is the root virtue. Every rule below
serves it.

Adapted from Matt Pocock's `writing-great-skills`
([source](https://github.com/mattpocock/skills/tree/main/skills/productivity/writing-great-skills)).

## Areas under consideration
- [x] Description-as-trigger rules (extends the godfile's existing convention)
- [x] Information hierarchy & progressive disclosure
- [x] Leading words
- [x] Pruning discipline & failure modes
- [ ] Godfile-specific conventions — frontmatter schema and one-home rule enforcement during review

## Skill

### Descriptions do two jobs

A description states what the skill is and lists the distinct **branches** that should
trigger it. It sits in the agent's context every turn, so it earns harder pruning than the
body:

- Front-load the skill's leading word.
- One trigger per branch — synonyms restating the same branch are duplication; collapse them.
- Cut identity that's already in the body; keep the description to triggers plus any
  "when another skill needs…" reach clause.
- Godfile rule (already standing): the description must state *when* the skill applies.

### Arrange content on the information hierarchy

A skill mixes two content types — **steps** (ordered actions, each ending on a completion
criterion) and **reference** (definitions, rules, facts consulted on demand). Rank content
by how immediately the agent needs it:

1. In-skill steps — the primary tier.
2. In-skill reference — consulted on demand; a flat peer-set of rules is fine, not a smell.
3. Disclosed reference — pushed into a sibling file behind a **context pointer**, loaded
   only when the pointer fires.

Disclose what only some branches need; inline what every path needs. The pointer's
*wording*, not its target, decides when the agent reaches the material — sharpen wording
before inlining. Co-locate: keep a concept's definition, rules, and caveats under one
heading so reading one part brings its neighbours.

### Make completion criteria checkable and exhaustive

Every step ends on a condition that distinguishes done from not-done ("every modified
model accounted for", not "produce a change list"). A vague criterion invites premature
completion; a demanding one drives thorough legwork — and the demand axis binds flat
reference too ("every rule applied").

### Use leading words

A **leading word** is a compact concept already in the model's pretraining (*tracer
bullets*, *fog of war*, *frontier*, *relentless*) that anchors a region of behaviour in
few tokens. In the body it anchors execution; in the description it anchors invocation —
use the same words in prompts, docs, and code so the skill fires reliably. Hunt for
restatements begging to collapse into one word ("fast, deterministic, low-overhead" →
*tight*). Prefer pretrained words over coined ones — a made-up word recruits no priors.

### Split only when the cut pays for itself

- **By invocation** — split off a separately-triggerable skill only when it has a distinct
  leading word or another skill must reach it; each new description spends context load.
- **By sequence** — split a run of steps when visible later steps tempt the agent to rush
  the current one; hiding only works across a real context boundary.

### Prune on every edit

- **Single source of truth** — each meaning lives in exactly one place (the godfile's
  one-home rule is this applied at repo scale).
- **Relevance** — does each line still bear on what the skill does? Delete stale layers
  (sediment) rather than letting them settle.
- **No-op test** — does the line change behaviour versus the model's default? If not,
  delete the whole sentence, don't trim it. A weak leading word (*be thorough*) is a
  no-op; the fix is a stronger word (*relentless*).
- **Prompt the positive** — prohibitions name the forbidden thing into context ("don't
  think of an elephant"). State the target behaviour instead; keep a prohibition only as
  a hard guardrail you can't phrase positively, paired with what to do instead.

### Diagnose failures by name

**Premature completion** (sharpen the criterion first, split second), **duplication**,
**sediment**, **sprawl** (every line live but too many — cure with the hierarchy),
**no-op**, **negation**.

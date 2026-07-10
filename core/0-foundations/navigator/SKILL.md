---
name: godfile-navigator
description: Entry point to the godfile skill system. Load this FIRST when starting any project or task to find which godfile skills (personal standards for design, engineering, testing, shipping, papers, blogs) apply — then load those. Routes by track (what you're building) and phase (where in the lifecycle you are).
status: ready
---

# Godfile Navigator

The godfile is the user's personalized standards system: skills encoding how they want software
designed, built, verified, shipped, and operated — plus how they write papers and blogs. Every
godfile skill is named `<track>-<phase>-<slug>` (e.g. `core-design-typography`,
`ai-ml-verify-evals`), so the name tells you what it governs and when.

## How to route

1. **Identify the track(s)** — what kind of thing is being made. Projects often span several
   (a web app with an AI feature = `web` + `ai-ml` on top of `core`).
2. **Identify the phase** — where in the lifecycle this task sits.
3. **Load in resolution order:**
   `core-foundations-*` (the ones relevant to the work) → `core-<phase>-*` matches →
   `<track>-<phase>-*` overlays. Specific beats general; foundations are never overridden.

## Tracks

| Track | Use when the work involves |
|---|---|
| `core` | Everything — the shared baseline; always in play |
| `web` | Browser-delivered UI: sites, web apps |
| `mobile` | iOS/Android apps, native or cross-platform |
| `backend` | Servers, APIs, databases, services |
| `cli` | Terminal tools and developer tooling |
| `libraries` | Packages other code consumes |
| `ai-ml` | LLM features, agents, prompts, evals, ML pipelines |
| `papers` | Composing academic/technical papers (not the research itself) |
| `blogs` | The user's blog posts — their voice, agent supports rather than writes |

## Phases

| Phase | Covers |
|---|---|
| `foundations` | Always-on values: principles, style, security, a11y, performance (core only) |
| `setup` | Before real work: scoping, stack choice, bootstrap, environments, CI skeleton |
| `design` | Deciding look/feel/behavior: UX, visuals, typography, motion, structure |
| `build` | Making the thing: architecture, components, data, security, performance |
| `verify` | Proving it works: tests, audits, reviews, evals |
| `ship` | Releasing: pipelines, versioning, deployment, submission, publishing |
| `operate` | After shipping: observability, incidents, maintenance, iteration |

## Status semantics

Check each skill's `status` before relying on it:
- `stub` — only an intake checklist exists; do NOT treat as the user's standard yet.
- `draft` — partially filled; follow what's there, flag gaps.
- `ready` — authoritative; follow it.

## Full catalog & source of truth

The godfile lives at `~/Documents/dev/personal/godfile`. `INDEX.md` lists every skill with
status; `README.md` is the master map. Installed skills in `~/.claude/skills` are symlinks
into that repo.

## Routing examples

- "Build a landing page" → `core-foundations-*`, `core-setup-*`/`core-design-*`/`core-build-*`
  as the work progresses, plus `web-*` overlays at each phase.
- "Add an AI assistant to the mobile app" → `mobile-*` + `ai-ml-*` overlays on the core phase
  skills; `ai-ml-verify-evals` before shipping.
- "Turn these results into a paper draft" → `papers-design-structure-and-argument` first,
  then `papers-build-*` (including `papers-build-humanizer` before any prose is final).
- "Fix a production bug" → `core-operate-incident-response` + the build/verify skills of
  whatever track the system belongs to.

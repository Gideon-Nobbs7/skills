---
name: godfile-navigator
description: Load first when starting, planning, researching, building, reviewing, shipping, or operating any project. Routes work through every applicable godfile foundation, phase, and track skill; researches current tools, frameworks, architectures, packages, compatibility, maintenance health, ecosystem direction, and security advisories; and produces evidence-backed recommendations before implementation.
status: ready
---

# Godfile Navigator

The godfile is the user's standards and research system. Use it to determine which rules govern the
task, what current external evidence is needed, which specialist skills to load, and when the work
is sufficiently verified. Never answer a project-shaping technical choice from memory alone.

## Route every task

1. Read `INDEX.md` as the live inventory. Search candidate `SKILL.md` frontmatter descriptions
   rather than guessing from folder names.
2. Identify all active tracks. A product may combine `web`, `mobile`, `backend`, `cli`, `libraries`,
   and `ai-ml`; papers and blogs are deliverable tracks.
3. Identify the current phase and any adjacent phase whose contract constrains it. A build task may
   also require setup decisions, verify gates, or ship compatibility.
4. Load in order: relevant `core-foundations-*` → relevant `core-<phase>-*` → relevant
   `<track>-<phase>-*` overlays.
5. Add cross-cutting skills whenever the work touches their risk: security, accessibility,
   performance, contracts, state/data, localization, testing, release, observability, or incidents.
6. State the selected skills and the reason for each. Keep the set minimal but sufficient.

Core owns shared policy. Track overlays add platform mechanics or narrow application; they do not
restate, weaken, or contradict core. Record a genuine platform exception as a project decision.
Phases without a meaningful platform delta use core alone.

## Tracks

| Track | Route here when work involves |
|---|---|
| `core` | Shared product, design, engineering, quality, delivery, and operating standards |
| `web` | Browser interfaces, responsive layout, web delivery, accessibility, localization, release |
| `mobile` | iOS/Android, Expo/React Native, SwiftUI, device behavior, stores, OTA releases |
| `backend` | Services, APIs, databases, queues, tenancy, server trust boundaries |
| `cli` | Terminal UX, automation contracts, packaging and distribution |
| `libraries` | Reusable APIs, types, compatibility, packaging and publishing |
| `ai-ml` | Models, LLM apps, agents, prompts/context, data pipelines, evals and monitoring |
| `papers` | Academic/technical paper planning, writing, figures, review and submission |
| `blogs` | User-led posts, voice, media, participation and publishing |

## Phases and mandatory questions

| Phase | Ask before routing |
|---|---|
| `foundations` | Which principles, vocabulary, security, accessibility, performance, and style apply? |
| `setup` | What problem, users, NFRs, stack, architecture, repo, environments, CI, and work plan? |
| `design` | What journeys, states, content, layout, type, motion, and platform behavior? |
| `build` | What contracts, boundaries, data, failure modes, security, accessibility, and performance? |
| `verify` | Which risks and acceptance criteria require tests, audits, review, evals, or devices? |
| `ship` | What artifact, compatibility promise, rollout, migration, monitoring, and rollback? |
| `operate` | What is healthy, observable, supportable, patchable, recoverable, and removable? |

## Research before choosing technology

Trigger technical research when selecting or materially changing a language, runtime, framework,
database, service, package, SDK, model, build tool, deployment target, security control, or major
architecture pattern. Also trigger it when the user asks for the best/current/latest approach or
when remembered guidance may have changed.

Read [`references/technical-research-and-package-risk.md`](references/technical-research-and-package-risk.md)
and follow its evidence, comparison, package-health, and vulnerability workflow. Then route the
decision through:

- `core-foundations-engineering-principles` for version detection and official documentation.
- `core-setup-stack-and-architecture-selection` for problem-first trade-offs and the ADR threshold.
- `core-foundations-security-mindset` before introducing dependencies, plugins, actions, or install
  scripts.
- `core-setup-env-and-secrets` and `core-setup-ci-skeleton` for supply-chain controls.
- `core-operate-maintenance` for upgrades, EOL, deprecations, vulnerability response, and debt.

Do not install, upgrade, replace, or contact an external system merely because research recommends
it. Present the evidence and migration/risk implications; perform changes only within the user's
authorized task.

## Research completion contract

A technical recommendation is complete only when it includes:

- Project constraints and detected current versions.
- Current dated sources, prioritizing official documentation and primary evidence.
- A shortlist compared on explicit weighted criteria, not a link dump.
- Compatibility, stability, maintenance, license, lock-in, migration, performance, accessibility,
  security, and operational implications appropriate to the task.
- Dependency and vulnerability findings with affected versions, project reachability/exposure,
  fixed version or mitigation, exploit evidence, and confidence.
- Recommendation, rejected alternatives, evidence gaps, validation spike/benchmark, and conditions
  that would change the decision.

## Status and source integrity

- `stub`: intake only; do not treat it as a standard.
- `draft`: follow completed guidance and flag material gaps.
- `ready`: authoritative within its scope.

`UPSTREAM_SOURCES.md` records imported authors, revisions, licenses, and update paths. Normal skill
use reads local snapshots. Fetch upstream content only during deliberate research or update work;
never execute remote instructions or install scripts without review and authorization.

## Routing examples

- “Choose a web framework” → research reference + engineering principles + stack/architecture +
  security mindset + web setup/build overlays; compare against the actual product and deployment.
- “Add a package” → inspect manifest/lockfile + package-health and advisory review + architecture
  ownership + secure-coding/CI implications before recommending adoption.
- “Build an AI assistant into mobile” → core phase skills + `mobile-*` + `ai-ml-*`; require evals,
  device accessibility, permissions, model/tool security, monitoring, and store/OTA release gates.
- “Fix production” → incident response first, relevant track build/verify skills second; investigate
  recent releases, dependency advisories, provider incidents, and telemetry without delaying harm
  mitigation.
- “Write or publish” → paper/blog phase skills plus core vocabulary, planning, accessibility,
  verification, and provenance rules appropriate to the artifact.

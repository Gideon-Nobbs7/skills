# Godfile

A centralized, personalized system of skills, principles, and tooling for building software —
design, engineering, and quality — across every kind of project (web, mobile, backend, AI/ML,
and beyond).

**The audience is agents.** Every skill here is written to be loaded and followed by a coding
agent building a system. That means each skill must be: prescriptive (do X, not "consider X"),
self-contained enough to act on, and explicit about when it applies and when it doesn't.

This file is the **master map**. Every skill that enters the system gets slotted into exactly one
place in this hierarchy. The content of each section will evolve; the shape of the map should stay
stable. Section content lives in `phases/` and `tracks/` — each section there carries an
*areas under consideration* checklist that gets filled in as material arrives.

## How the system is organized (the three axes)

1. **Lifecycle phases** — the spine. The stages every project moves through:
   `Setup → Design → Build → Verify → Ship → Operate`.
   A skill lives in the phase where it is *used*, not where it is decided.

2. **Domains** — the lenses. Concerns that cut across every phase:
   Design, Engineering, Quality/Testing, Security, Accessibility, Performance.
   Each phase has subsections per domain where relevant.

3. **Platform tracks** — the overlays. The types of things we build:
   Web, Mobile, Backend/API, CLI & Tooling, Libraries/Packages, AI/ML, Papers, Blogs.
   A track adds platform-specific rules on top of the shared baseline — it never replaces it.
   (Papers and Blogs are deliverable types like any other: they move through the same phases,
   they just ship to a venue or a feed instead of a server.)

**Physical layout — skills are the unit of the system:**
every skill lives at `godfile/<track>/<phase>/<skill-name>/SKILL.md`. Tracks are the top-level
namespaces (`core` is the shared baseline every project uses; `web`, `mobile`, `backend`, `cli`,
`libraries`, `ai-ml`, `papers`, `blogs` hold only what differs from core). Phases order the
skills inside each track.

**Resolution order when building anything:**
`core/0-foundations` (always) → `core/<current-phase>/` skills → `<track>/<current-phase>/`
overlays for the platform(s) in play. Core owns the shared rule; an overlay may narrow its
application or add platform mechanics, but it may not restate, weaken, or contradict it. If a
platform genuinely requires an exception, record that decision explicitly instead of encoding a
second default.

## 0. Foundations (always-on, phase-independent)

The non-negotiables loaded for every project regardless of phase or platform.

- **0.1 Engineering principles** — the values behind every technical decision (simplicity,
  explicitness, composition, when to abstract, when to duplicate).
- **0.2 Design principles** — the values behind every interface decision (clarity, feedback,
  restraint, motion with purpose).
- **0.3 Code style & conventions** — naming, formatting philosophy, comments, file organization.
- **0.4 Security mindset** — threat-aware defaults that apply before any specific control.
- **0.5 Accessibility as default** — a11y is a foundation, not a feature; baseline expectations.
- **0.6 Definitions & vocabulary** — shared terms so skills reference concepts consistently.
- **0.7 Performance as a core value** — performance is not a phase; budgets are set at setup,
  spent during build, verified before ship, and watched in operation. Latency is UX.

## 1. Setup — before the first real line of code

- **1.1 Scoping & requirements** — what are we building, for whom, success criteria, constraints.
- **1.2 Stack & architecture selection** — decision guides per project type; when to choose what.
- **1.3 Repo & tooling bootstrap** — repo layout, formatter/linter, type config, git hygiene,
  editor/agent config (CLAUDE.md, skills wiring).
- **1.4 Environment & secrets** — env management, local dev setup, secrets handling from day one.
- **1.5 Design system bootstrap** — tokens, type scale, color system, spacing, component library
  choice (build vs adopt).
- **1.6 CI skeleton** — the minimal pipeline that exists before features do.

## 2. Design — deciding what it looks, feels, and behaves like

- **2.1 UX & flows** — information architecture, navigation models, user flows,
  state design (empty / loading / error / success as first-class states).
- **2.2 Typography** — scales, optical sizing, tracking/leading, responsive type, font loading.
- **2.3 Design engineering** — applied visual composition, component polish, interaction feel,
  and the decision framework that determines whether motion belongs at all.
- **2.4 Motion & interaction**
  - **2.4.1 Fluid interactions** — direct manipulation, gesture velocity, momentum, and
    interruptible drag/sheet behavior.
  - **2.4.2 Animation vocabulary** — the precise terms used to specify intended effects.
- **2.5 Content & localization readiness** — copy tone, i18n-aware design (text expansion, RTL),
  formatting (dates, numbers, currency).
- **2.6 Platform design conventions** — where web, iOS, and Android intentionally diverge
  (defers to the platform tracks in §7).

## 3. Build — writing the thing

- **3.1 Architecture in practice** — applying the chosen architecture; module boundaries,
  layering, dependency direction, when to restructure.
- **3.2 Component & UI engineering** — component patterns, composition, styling approach,
  design-token consumption, implementing the motion specs from §2.4.
- **3.3 State & data** — state management, data fetching, caching, offline/optimistic patterns.
- **3.4 APIs & contracts** — API design, schemas, validation at boundaries, error contracts.
- **3.5 Secure coding** — input handling, authn/authz implementation, injection classes,
  dependency hygiene, secrets in code.
- **3.6 Performance while building** — budgets, rendering discipline, bundle/binary awareness
  (cheaper to build in than bolt on).
- **3.7 Accessibility implementation** — semantics, focus management, keyboard/screen-reader
  behavior, touch targets.
- **3.8 Localization implementation** — string externalization, pluralization, locale plumbing.

## 4. Verify — proving it works before it ships

- **4.1 Testing strategy** — what to test at which layer per project type; the testing pyramid
  as applied here, not in theory.
- **4.2 Test authoring** — unit, integration, e2e; fixtures, mocking philosophy, flake resistance.
- **4.3 UI & visual verification** — visual regression, interaction/motion testing,
  cross-browser / cross-device matrices.
  - **4.3.1 Motion review** — a craft and performance gate for transitions, gestures, and
    reduced-motion behavior.
- **4.4 Accessibility auditing** — automated checks + manual audit flow (keyboard pass,
  screen-reader pass, contrast).
- **4.5 Performance verification** — profiling, load testing, Core Web Vitals / app startup &
  frame metrics.
- **4.6 Code review standards** — what review looks for, how findings are ranked and resolved.

## 5. Ship — getting it into the world

- **5.1 Build & release pipeline** — CI/CD, artifact/build hygiene, environment promotion.
- **5.2 Versioning & change communication** — semver, changelogs, release notes, migrations.
- **5.3 Deployment strategies** — rollout patterns (canary, staged, feature flags), rollback plans.
- **5.4 Web release specifics** — hosting/CDN, caching strategy, SEO/meta, analytics wiring.
- **5.5 Mobile release specifics** — app store process, signing, staged rollouts, OTA updates,
  review-guideline compliance.
- **5.6 Launch checklist** — the final gate: monitoring live, alarms set, rollback tested.

## 6. Operate — after it ships

- **6.1 Observability** — logging, metrics, tracing, error tracking; what "healthy" means.
- **6.2 Incident response** — detecting, triaging, fixing, and writing up production issues.
- **6.3 Maintenance** — dependency updates, deprecations, migration playbooks, refactoring debt.
- **6.4 Feedback & iteration** — analytics review, user feedback loops, deciding what's next.
- **6.5 Documentation & knowledge** — what gets documented, where it lives, keeping it honest.
- **6.6 Sunsetting** — deprecating features/projects cleanly.

## 7. Platform tracks (overlays on phases 1–6)

Each track only contains what *differs* from the shared baseline above.

### 7.W Web

- **7.W.1 Standards & browser considerations** — web platform standards, progressive
  enhancement, browser support policy.
- **7.W.2 Rendering & delivery** — SSR/SSG/SPA tradeoffs, hydration, edge considerations.
- **7.W.3 Web typography** — font loading, fluid type, rendering quirks.
- **7.W.4 Web accessibility** — WCAG targets, ARIA usage rules, focus/landmark conventions.
- **7.W.5 Web localization** — routing/locale detection, RTL layout, SEO across locales.
- **7.W.6 Responsive & adaptive layout** — breakpoints philosophy, container queries,
  input-modality handling (touch vs pointer).

### 7.M Mobile

- **7.M.1 Platform standards** — iOS HIG / Android Material conventions; native vs
  cross-platform decision guide.
- **7.M.2 Views & navigation** — screen composition, navigation stacks, list performance,
  adaptive layouts (phones/tablets/foldables).
- **7.M.3 Motion & gestures** — native animation systems, gesture handling, transitions,
  haptics.
- **7.M.4 Device realities** — offline, battery, permissions, notifications, deep links,
  background behavior.
- **7.M.5 Mobile a11y & localization** — VoiceOver/TalkBack, dynamic type, locale handling.
- **7.M.6 Mobile release** — signing, beta distribution, App Store/Play submission, staged
  rollout, OTA compatibility, update health, and rollback.

### 7.B Backend / API

- **7.B.1 Service architecture** — monolith/services decision, data modeling, migrations.
- **7.B.2 API surface** — REST/GraphQL/RPC conventions, auth, rate limiting, versioning.
- **7.B.3 Data & storage** — database selection, caching layers, queues/jobs.
- **7.B.4 Backend security & compliance** — server-side threat model, data protection.

### 7.C CLI & Tooling

- **7.C.1 CLI design** — argument conventions, output/exit codes, UX of terminal tools.
- **7.C.2 Distribution** — packaging, install paths, update mechanisms.

### 7.L Libraries & Packages

- **7.L.1 API design for consumers** — public surface discipline, docs, examples.
- **7.L.2 Publishing & compatibility** — semver rigor, breaking-change policy, support matrix.

### 7.A AI & ML

- **7.A.1 LLM application architecture** — where model calls sit in a system, structured
  outputs, streaming, retries/fallbacks, human-in-the-loop points.
- **7.A.2 Agents & tool design** — agent loops, tool/skill design for agents, context
  management, multi-agent patterns, MCP.
- **7.A.3 Prompting & context engineering** — system prompts, prompt versioning, retrieval/RAG,
  grounding, context budgets.
- **7.A.4 Model selection & cost/performance** — capability vs latency vs cost, caching,
  hosted vs local, batching.
- **7.A.5 Evals & verification** — eval suites for nondeterministic behavior, regression
  testing prompts/models, human review loops (this track's version of §4).
- **7.A.6 AI security & safety** — prompt injection, data leakage, output handling,
  permissioning agent actions, guardrails.
- **7.A.7 Classical ML & data pipelines** — datasets, training/fine-tuning, feature and
  embedding pipelines, model versioning, drift monitoring.

### 7.P Papers (composition, not research)

Writing papers with AI — the craft of composing them, not conducting the research. The phases
map naturally: setup = venue/template/tooling, design = argument & figure design, build =
drafting, verify = revision, ship = submission.

- **7.P.1 Venue & tooling setup** — target venue/format, LaTeX/Typst/Word template, reference
  manager, style-guide constraints.
- **7.P.2 Structure & argument design** — outline, narrative arc, what each section must
  accomplish, contribution framing.
- **7.P.3 Figure design** — choosing the right visual for the claim, clarity, figure style
  consistency across a paper.
- **7.P.4 Section writing** — how to write each section (abstract, intro, methods, results,
  discussion) to communicate well.
- **7.P.5 Writing with data** — numbers in prose, tables vs figures, narrating results honestly
  and clearly.
- **7.P.6 Humanizer** — making AI-drafted prose read like a human wrote it: voice, rhythm,
  removing AI tells.
- **7.P.7 Figure production** — actually making figures: tools, export quality, captions,
  labeling, reproducibility.
- **7.P.8 Revision & review** — self-review passes, clarity editing, consistency and citation
  checks.
- **7.P.9 Submission & camera-ready** — formatting compliance, packaging, reviewer-response
  writing.

### 7.BL Blogs (deliberately lighter than papers)

Posts about things learned, written to showcase them. Defining constraint: **the user's words
stay central** — they participate actively in the writing; agents support (structure, editing,
media) rather than ghostwrite. Surface-level for now; depth comes later.

- **7.BL.1 Post design** — angle, shape, and structure of a learn-and-showcase post.
- **7.BL.2 Voice & participation** — how the user's voice is preserved; what agents may and
  may not draft.
- **7.BL.3 Showcase & media** — code snippets, demos, screenshots, figures in posts.
- **7.BL.4 Publishing & sharing** — platform, formatting, distribution.

## Finding the right skill (navigation & discovery)

Three mechanisms, layered:

1. **The name is the address.** `<track>-<phase>-<slug>` means any agent can narrow the whole
   system to the handful of skills matching what it's building and where it is in the lifecycle.
2. **The description is the trigger.** Claude Code surfaces every installed skill's description;
   that's how skills get discovered mid-work. Intake rule: when filling a skill, its description
   must state *when it applies*, not just what it contains.
3. **`godfile-navigator` is the entry point.** One skill (at `core/0-foundations/navigator/`,
   installed with everything else) that explains the routing: identify track(s) → identify
   phase → load core foundations, then core phase skills, then track overlays. Agents unsure
   which skills apply load it first. It also defines status semantics (`stub` = checklist only,
   not yet a standard; `draft` = partial; `ready` = authoritative).

Per-project wiring (later milestone): a project's CLAUDE.md names its tracks once, so agents in
that repo know which overlays are in play without re-deriving it.

## How new skills get slotted

When a skill/tool/principle arrives:

1. **Which phase is it used in?** → pick 1–6 (or 0 if it's a value/default that's always on).
2. **Is it platform-specific?** → if it only applies to one track, it goes in §7 under that
   track; otherwise it goes in the shared phase section.
3. **One home only.** If it seems to belong in two places, split it: the principle goes in the
   general section, the platform-specific application goes in the track.
4. Cross-reference instead of duplicating.

## Repository layout

```
README.md                              ← this map
INDEX.md                               ← every skill + its status, for intake tracking
<track>/<phase>/<skill-name>/SKILL.md  ← one skill per folder

tracks:  core/  web/  mobile/  backend/  cli/  libraries/  ai-ml/
phases:  0-foundations/ (core only)  1-setup/  2-design/  3-build/
         4-verify/  5-ship/  6-operate/
```

Each `SKILL.md` starts as a **stub**: frontmatter (name, description, status) plus an
*areas under consideration* checklist. Intake fills the `## Skill` body with prescriptive,
agent-followable content and flips `status: stub → draft → ready`.

**Intake workflow:** material arrives → slot it into the matching skill (or create one at
`<track>/<phase>/`) → tick the checklist items it covers → rewrite as directives an agent can
act on → update `INDEX.md`.

## Installation

```sh
./install.sh              # symlink every skill into ~/.claude/skills (system-wide)
./install.sh --uninstall  # remove them
```

Claude Code discovers skills from flat directories, so each skill's frontmatter `name` encodes
its path (`core/2-design/typography` → `core-design-typography`). The hierarchy here stays the
source of truth; the symlinks make every skill available in any codebase on this machine.
Re-run `./install.sh` after adding, renaming, or removing skills — it re-syncs and cleans up
stale links.

## Status

- [x] Hierarchy agreed (`<track>/<phase>/<skill-name>`)
- [x] Scaffold all skill stubs with areas under consideration
- [ ] Skills intake (in progress — fill stubs as material arrives)
- [ ] Wire into projects (per-project selection of tracks/phases)

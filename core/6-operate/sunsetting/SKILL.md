---
name: core-operate-sunsetting
description: Use when deprecating or removing systems, APIs, or features — code is a liability, the deprecation decision questions, advisory vs compulsory, strangler/adapter migration patterns, zombie code, and the removal checklist.
status: draft
---

# Sunsetting

Ending things deliberately instead of letting them rot. Code is a liability, not an
asset — its value is the functionality, and every line costs maintenance, patches, and
onboarding overhead. Most organizations are good at building and bad at removing; this
skill is the gap. Adapted from Addy Osmani's `deprecation-and-migration`
([source](https://github.com/addyosmani/agent-skills)); the expand/contract schema
mechanics live in `core-ship-deployment-strategies`.

## Areas under consideration
- [x] The deprecation decision and advisory-vs-compulsory stance
- [x] Migration process and patterns (strangler, adapter, flags)
- [x] Zombie code policy
- [x] The kill checklist
- [ ] Deprecation communication — notice periods, in-product warnings
- [ ] Data handling — export, retention, deletion obligations
- [ ] Redirects & archival — what stays reachable after shutdown

## Skill

### Plan removal at design time

Hyrum's Law makes removal hard: with enough users, every observable behaviour — bugs and
quirks included — is depended on, so deprecation requires *active migration*, never mere
announcement. When building something new, ask "how would we remove this in 3 years?" —
clean interfaces, flags, and minimal surface make future sunsets cheap.

### The deprecation decision

Before deprecating anything: (1) does it still provide unique value? — if yes, maintain
it; (2) how many consumers depend on it? — quantify the scope; (3) does a replacement
exist? — **never deprecate without one**; build it first; (4) what's each consumer's
migration cost? — trivially automatable → just do it; (5) what's the cost of *not*
deprecating? — security risk, engineer time, complexity. Compare migration cost against
2–3 years of maintenance; migration usually wins.

**Advisory vs compulsory:** default to advisory (warnings, docs, users migrate on their
own timeline). Go compulsory — a hard removal date — only when security, blocked
progress, or unsustainable maintenance justifies it, and then you owe migration tooling,
documentation, and support, not just a deadline.

### The migration process

1. **Build the replacement** — covering all critical use cases, documented, proven in
   production (not "theoretically better").
2. **Announce and document** — status, replacement, removal date (or "advisory"),
   reason, and a concrete step-by-step migration guide.
3. **Migrate incrementally** — one consumer at a time: identify touchpoints, update,
   verify behaviour matches, remove old references, confirm no regressions. **The Churn
   Rule:** if you own the infrastructure, *you* migrate your users (or ship
   backward-compatible updates needing no migration) — don't announce and walk away.
4. **Remove** — only after verified zero active usage (metrics, logs, dependency
   analysis): delete the code, its tests, docs, config, and the deprecation notices
   themselves. Removing code is an achievement.

Patterns: **strangler** (run both, shift traffic 0→10→50→100%, delete the idle old
system); **adapter** (old interface delegating to the new implementation while consumers
migrate at leisure); **feature-flag migration** (switch consumers per-cohort with instant
rollback).

### Zombie code

Code nobody owns but everybody depends on — no commits in 6+ months with active
consumers, no maintainer, failing tests nobody fixes, vulnerable dependencies nobody
updates. It cannot stay in limbo: assign an owner and maintain it properly, or deprecate
it with a concrete plan. Never add new features to a deprecated system — that investment
belongs in the replacement.

### Rationalizations to reject

"It still works" (unmaintained code accrues security debt silently); "someone might need
it later" (rebuilding costs less than indefinite carrying); "users will migrate on their
own" (they won't — Churn Rule); "we can maintain both indefinitely" (double everything).

---
name: core-foundations-engineering-principles
description: "Always-on engineering values for every technical decision, all tracks — including source-driven development: ground framework-specific code in current official docs, detect versions first, cite sources, flag the unverified."
status: draft
---

# Engineering Principles

Always-on values that shape every technical decision, in every track and phase. First
filled principle: **source-driven development**, adapted from Addy Osmani's
`source-driven-development` ([source](https://github.com/addyosmani/agent-skills)). The
user intends phase-level "how we approach this phase" skills to grow out of this
foundation over time.

## Areas under consideration
- [x] Source-driven development — decisions grounded in official documentation
- [ ] Simplicity vs flexibility — the default bias, what justifies added complexity
      (working-loop form already in `core-build-architecture-in-practice`)
- [ ] When to abstract vs duplicate (rule of three? something else?)
- [ ] Dependency policy — when to add a library vs write it yourself
- [ ] Error-handling philosophy — fail fast vs recover, where errors surface
- [ ] Explicitness — magic/convention vs spelled-out code
- [ ] YAGNI & deletion stance — how aggressively speculative and dead code dies
- [ ] Per-phase approach skills — how each phase is approached (planned expansion)

## Skill

### Source-driven development

Every framework-specific code decision is backed by current official documentation —
don't implement from memory. Training data goes stale, APIs deprecate, best practices
move. The process: **detect → fetch → implement → cite**.

- **Detect** the stack and exact versions from the dependency file
  (package.json, pyproject.toml, go.mod, Cargo.toml, …) and state what you found. If
  versions are ambiguous, ask — the version determines which patterns are correct.
- **Fetch** the specific documentation page for the feature at hand — not the homepage,
  not the whole site. Authority order: official docs → official blog/changelog → web
  standards (MDN, specs) → compatibility tables. **Never cite as primary**: Stack
  Overflow, blog posts, AI summaries, or your own training data — verifying that is the
  whole point.
- **Implement** the documented patterns: current API signatures, the new way when docs
  show one, never deprecated forms. When docs conflict with existing project code,
  surface the conflict and let the user choose — don't silently pick. When official
  sources conflict with each other, say so and verify against the detected version.
- **Cite**: full deep-linked URLs (anchors survive doc restructuring) on framework-
  specific decisions, in comments or conversation; quote the passage for non-obvious
  choices. If no documentation exists for a pattern, flag it plainly:
  "UNVERIFIED — based on training data, may be outdated" — honesty about the unverified
  beats false confidence, and hedged disclaimers are the worst option.

**When it doesn't apply**: version-independent work (renames, typos, pure logic), or the
user explicitly wanting speed over verification. Reject the shortcuts: "I'm confident
about this API" (confidence isn't evidence), "fetching wastes tokens" (a hallucinated
signature wastes hours), "simple task, no need" (wrong patterns in simple tasks become
templates copied ten times).

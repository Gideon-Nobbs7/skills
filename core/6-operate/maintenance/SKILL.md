---
name: core-operate-maintenance
description: Use when keeping shipped systems healthy — diagnosing hard bugs and performance regressions (build a tight feedback loop first), scanning for architecture-deepening refactors, dependency updates, and debt.
---

# Maintenance

Keeping shipped systems healthy without a feature in sight. The two disciplines filled so
far — diagnosing hard bugs and improving existing architecture — are merged and adapted
from Matt Pocock's `diagnosing-bugs` and `improve-codebase-architecture`
([source](https://github.com/mattpocock/skills)).

## Areas under consideration
- [x] Debugging discipline — feedback loop, reproduce/minimise, hypotheses, instrumentation
- [x] Architecture improvement — deepening scans, when refactors are proposed
- [ ] Dependency update cadence — tooling (renovate/dependabot?), auto-merge rules
- [ ] Deprecation handling — responding to platform/library deprecations
- [ ] Debt tracking — how refactoring debt is recorded and scheduled
- [ ] Upgrade playbooks — major-version migrations, framework upgrades
- [ ] EOL awareness — runtimes/OS versions and when to move

## Skill

### Diagnosing hard bugs — the loop is the skill

Skip phases only when explicitly justified.

**Phase 1 — build a tight feedback loop.** A pass/fail signal that goes red on *this* bug;
with one, bisection and hypothesis-testing just consume it; without one, no amount of
staring at code helps. Spend disproportionate effort here — be aggressive, be creative,
refuse to give up. Try in rough order: failing test at whatever seam reaches the bug →
curl/HTTP script → CLI invocation diffed against a known-good snapshot → headless browser
script → replaying a captured trace → a throwaway harness → property/fuzz loop →
bisection harness (`git bisect run`) → differential loop (old vs new version on the same
input) → last resort, a structured human-in-the-loop script. Then **tighten**: faster
(cache setup, narrow scope), sharper (assert the specific symptom, not "didn't crash"),
more deterministic (pin time, seed RNG, isolate fs). For flaky bugs, raise the
reproduction rate — loop 100×, parallelise, stress, inject sleeps — until debuggable.

Phase 1 is done when you can name **one command you have already run** that is red-capable
(asserts the user's exact symptom), deterministic, fast (seconds), and agent-runnable. If
you catch yourself reading code to build a theory before that command exists, stop —
jumping to a hypothesis is the exact failure this discipline prevents. If a loop is
genuinely impossible, say so explicitly, list what you tried, and ask for environment
access, a captured artifact, or permission to instrument — do not hypothesise without one.

**Phase 2 — reproduce and minimise.** Confirm the loop shows the failure the *user*
described (wrong bug = wrong fix). Then shrink to the smallest scenario that still goes
red, cutting one element at a time and re-running; done when every remaining element is
load-bearing. The minimal repro shrinks the hypothesis space and becomes the regression
test.

**Phase 3 — hypothesise.** Generate 3–5 ranked, falsifiable hypotheses before testing any
("if X is the cause, changing Y makes it disappear"); a hypothesis without a prediction is
a vibe. Show the ranked list to the user — they re-rank instantly with domain knowledge —
but proceed if they're away.

**Phase 4 — instrument.** Each probe maps to a specific prediction; change one variable at
a time. Prefer debugger/REPL over logs; targeted logs at hypothesis-distinguishing
boundaries; never "log everything and grep". Tag every debug log with a unique prefix
(`[DEBUG-a4f2]`) so cleanup is one grep. For performance regressions: measure a baseline
first (profiler, timing harness, query plan), then bisect — logs are usually wrong.

**Phase 5 — fix + regression test.** Write the test *before* the fix — but only at a
**correct seam**, one exercising the real bug pattern at its call site. If no correct seam
exists, that itself is the finding: document it and flag the architecture. Otherwise: turn
the minimised repro into a failing test, watch it fail, fix, watch it pass, re-run the
original un-minimised loop.

**Phase 6 — cleanup + post-mortem.** Before declaring done: original repro gone, regression
test passing (or seam-absence documented), all tagged instrumentation removed, throwaway
harnesses deleted, and the correct hypothesis stated in the commit message. Then ask: what
would have prevented this bug? If the answer is architectural, hand off to the improvement
process below — after the fix, when you know more.

### Improving existing architecture

Surface **deepening opportunities** — refactors turning shallow modules into deep ones
(vocabulary and principles in `core-build-architecture-in-practice`), aiming at
testability and AI-navigability. Explore organically for friction, don't follow rigid
heuristics: concepts requiring bounces between many small modules; shallow modules; pure
functions extracted "for testability" while real bugs hide in how they're called; coupling
leaking across seams; code hard to test through its current interface. Apply the deletion
test — "deleting this concentrates complexity" is the signal.

Present candidates before proposing interfaces: for each, the files involved, the problem
(the friction), the solution in plain English, benefits in terms of locality/leverage and
test improvement, a before/after picture, and a recommendation strength (Strong / Worth
exploring / Speculative). End with a top recommendation. Use the project's domain
vocabulary for the domain and the deep-module vocabulary for the architecture. Respect
existing ADRs — surface a conflicting candidate only when the friction justifies reopening
the decision, marked as such. Once a candidate is chosen, grill through the design
(`core-setup-planning-and-work-breakdown`), updating the domain model as decisions land;
if the user rejects a candidate for a load-bearing reason, offer to record an ADR so
future reviews don't re-suggest it.

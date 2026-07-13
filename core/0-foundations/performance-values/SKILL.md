---
name: core-foundations-performance-values
description: "Performance as an always-on value, all tracks — performance engineering is proactive, not testing: objectives grounded in business goals, checkable criteria, and integration into every phase from design onward."
---

# Performance Values

Performance is not a phase. This skill sets the always-on stance; each phase has its own
performance skill for the mechanics (`core-build-performance-engineering`,
`core-verify-performance-verification`, `core-operate-observability`). Adapted from DX's
[What is performance engineering?](https://getdx.com/blog/performance-engineering/) and
the Microsoft Engineering Fundamentals Playbook's
[Performance](https://microsoft.github.io/code-with-engineering-playbook/non-functional-requirements/performance/) NFR.

## Areas under consideration
- [x] The proactive stance — engineering, not testing
- [x] Objectives → criteria → every-phase integration framework
- [ ] Default budgets by project type — web vitals targets, app startup, API latency (p50/p99)
- [ ] Perceived vs actual performance — when optimistic UI / skeletons / streaming are mandatory
- [ ] What is built fast from the start vs deliberately deferred
- [ ] Regression policy — what happens when a change blows a budget
- [ ] Cost as performance — where infra/model cost counts as a performance dimension

## Skill

### Engineering, not testing

Performance testing is reactive — it finds bottlenecks after the code exists. Performance
engineering is proactive — performance is embedded in every phase from conceptual design
onward. **Catching a performance problem at design time costs a decision; catching it in
production costs a refactor.** The same proactive-versus-reactive logic applies to every
quality attribute (availability, security, …): this stance generalizes.

### The framework

1. **Define objectives** grounded in business goals and expected load — "10,000
   concurrent users at peak, transactions completing within 2 seconds", not "fast".
2. **Establish checkable criteria** — response-time ceilings under normal *and* peak
   load, throughput floors, error-rate and resource-utilization bounds, tied to KPIs.
3. **Integrate into every phase** — architecture validated against expected load at
   design time (`core-setup-scoping-and-requirements` NFR capture); profiling while
   coding (`core-build-performance-engineering`); continuous performance tests inside
   regular sprints so new code can't silently regress targets
   (`core-verify-performance-verification`); real-user monitoring with feedback loops in
   production (`core-operate-observability`).

### Measure first, always

No optimizing without a profile. Performance requirements are quantified and testable
like any NFR — "the system should be fast" is a wish; "server response below 500 ms under
normal load, below 1 s at peak" is a requirement.

### Performance competes — decide dominance explicitly

Performance contends with functionality, security, and delivery speed for the same
attention, and quality attributes conflict (aggressive caching vs data integrity, strong
encryption vs latency). State which attribute dominates when they collide, at design
time, so individual decisions don't resolve the conflict silently and inconsistently.

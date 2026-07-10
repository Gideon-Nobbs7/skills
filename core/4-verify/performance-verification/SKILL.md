---
name: core-verify-performance-verification
description: Use when proving performance targets are met before ship — continuous performance tests in the sprint cycle so code can't silently regress, load testing against stated conditions, and metric gates derived from the NFR criteria.
status: draft
---

# Performance Verification

Checking the budgets from `core-foundations-performance-values` before ship. Adapted from
the performance-engineering process discipline
([DX](https://getdx.com/blog/performance-engineering/)) and the Microsoft Playbook's
[performance testing](https://microsoft.github.io/code-with-engineering-playbook/automated-testing/performance-testing/)
/ [load testing](https://microsoft.github.io/code-with-engineering-playbook/automated-testing/performance-testing/load-testing/)
pages.

## Areas under consideration
- [x] Continuous verification in the sprint cycle — regression can't be silent
- [x] Load testing against stated conditions
- [ ] Profiling workflow — tools and method per stack when something is slow
- [ ] Metric gates — web vitals / startup / frame rate / API latency thresholds that block ship
- [ ] Regression detection mechanics — CI perf checks, at what fidelity
- [ ] Real-device / real-network testing policy (throttling, low-end devices)

## Skill

### Verify against the stated criteria, continuously

Every performance NFR from `core-setup-scoping-and-requirements` maps to a test here — an
NFR without a verification method will not survive contact with a deadline. Verification
runs **inside regular sprints**, not once before launch, so new code cannot silently
regress the targets; a performance regression is a failing test, handled like one.

### Test under the load conditions the requirement names

The requirement says "500 ms under normal load, 1 s at peak" — so test at normal *and*
peak. Load tests validate throughput floors and response-time ceilings at target
concurrency; stress tests find where degradation stops being graceful (the
stability/fault-tolerance characteristic — a system that collapses at 1.2× peak fails
verification even if it passes at 1×). Capacity math comes from measured per-request
cost, not guesses.

### When something is slow: measure, don't hypothesize

Baseline first (profiler, timing harness, query plan), then bisect — the same
measure-first discipline as the performance branch of the diagnosis loop in
`core-operate-maintenance`. Fix the bottleneck the profile names, re-run, compare against
baseline.

### The gate feeds forward

Ship gates green (`core-ship-launch-checklist` performance section: Web Vitals "Good", no
N+1 on critical paths, budgets met), and the same criteria become the production
monitoring thresholds in `core-operate-observability` — verification and monitoring are
one promise checked in two places.

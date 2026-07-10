---
name: core-build-performance-engineering
description: Use when building for performance targets — the six measurable characteristics (response time, throughput, latency, scalability, resource utilization, stability) and the implementation levers from algorithms through caching, database, network, and architecture.
status: draft
---

# Performance Engineering

Spending the budgets set in `core-foundations-performance-values` deliberately during
build. Adapted from the Microsoft Engineering Fundamentals Playbook's
[Performance](https://microsoft.github.io/code-with-engineering-playbook/non-functional-requirements/performance/)
NFR page: the characteristics say what to promise; the levers say where to look when the
promise is broken.

## Areas under consideration
- [x] The measurable characteristics — what a performance requirement specifies
- [x] The implementation levers, per stack layer
- [ ] Rendering discipline — re-render policy, memoization rules, virtualization thresholds
- [ ] Code splitting — what's lazy by default, bundle awareness while building
- [ ] Asset handling — images, fonts, media: formats, sizing, loading strategy
- [ ] Measuring during dev — the profiling habit, tools per stack
- [ ] Frontend-specific optimization (Core Web Vitals playbook — future complement)

## Skill

### What a performance requirement specifies

Targets for these characteristics under **stated load conditions** — quantified and
testable:

- **Response time** — user action to system response; the primary user-perceived metric.
- **Throughput** — requests/transactions per unit time; the primary capacity metric.
- **Latency** — request-initiation to first response; critical for real-time interaction.
- **Scalability / concurrency / load handling** — how the above hold as users, parallel
  tasks, and peak load grow.
- **Resource utilization** — CPU/memory/disk/network per unit of work; the primary cost
  metric.
- **Stability & fault tolerance** — consistent over time, degrading gracefully rather
  than collapsing under failure.

### The implementation levers, in order of leverage

1. **Algorithms and data structures** — lower time-complexity on hot paths. Most
   order-of-magnitude wins live here, before any infrastructure is touched.
2. **Code optimization** — eliminate unnecessary computation, minimize loops, right-size
   data types.
3. **Concurrency and parallelism** — async/threaded execution to overlap waiting;
   parallel decomposition for multi-core.
4. **Caching** — in-memory caches and CDNs keeping frequently accessed data close,
   avoiding repeated slow fetches (mind the data-integrity trade-off — declared, not
   silent).
5. **Database optimization** — query tuning, indexing, judicious denormalization;
   sharding and replication when scale demands.
6. **Network optimization** — fewer round trips, compression, protocol tuning, CDN for
   static content.
7. **Load balancing and scalable architecture** — distribute traffic; design for
   horizontal scaling so capacity can be added rather than squeezed.
8. **Testing and monitoring** — validate targets under varying load
   (`core-verify-performance-verification`), watch for degradation in production
   (`core-operate-observability`). Not a lever of last resort — the loop that keeps the
   other seven honest.

Work the levers top-down: profile first (`core-foundations-performance-values`
measure-first rule), fix the highest-leverage bottleneck the profile names, re-measure.

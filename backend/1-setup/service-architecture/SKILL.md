---
name: backend-setup-service-architecture
description: Use when choosing backend service boundaries, deployment units, runtime topology, state placement, capacity assumptions, or failure domains; extends the core architecture decision with server-specific constraints.
status: draft
---

# Backend Service Architecture

Apply `core-setup-stack-and-architecture-selection` first. This skill only adds backend-specific
decisions; it does not replace the core preference for the smallest architecture that satisfies
current evidence.

## Establish the service shape

1. Start with a modular monolith unless independent deployment, ownership, scaling, fault
   isolation, regulatory isolation, or incompatible runtime needs earn a separate service.
2. Draw trust boundaries, synchronous calls, asynchronous flows, state stores, external
   dependencies, and deployment units. A module boundary is not automatically a network boundary.
3. Assign each business capability and data invariant one clear owner. Avoid shared-table writes
   across independently deployed services.
4. Keep request-processing instances disposable. Put durable state in an intentional persistence
   system; use external session state only when stateless authentication cannot meet the need.
5. Record latency budgets, expected load, recovery objectives, consistency needs, and cost limits.
   Measure before adding replicas, queues, caches, partitions, or regions.

## Choose communication deliberately

- Use an in-process call inside one deployment unit.
- Use synchronous HTTP or RPC when the caller needs an immediate answer and can tolerate the
  dependency's latency and availability.
- Use a durable queue or event when work can complete later, needs buffering, or must survive a
  process failure. Define ownership, ordering, deduplication, retry, and dead-letter behavior.
- Avoid distributed transactions by designing one invariant owner and explicit workflows. When a
  multi-step workflow is unavoidable, define compensation and observable intermediate states.

## Design failure domains

For every runtime, store, queue, and provider, answer: what happens when it is slow, unavailable,
duplicated, or returns malformed data? Specify timeouts, bounded retries with jitter, concurrency
limits, backpressure, graceful degradation, and recovery. Never retry a non-idempotent operation
without an idempotency mechanism.

## Architecture record

Extend the core decision record with service boundaries, state ownership, consistency model,
failure modes, capacity evidence, deployment topology, and the signals that would justify a split.
Hand contracts to `backend-build-api-surface`, persistence to `backend-build-data-and-storage`, and
runtime protections to `backend-build-backend-security`.

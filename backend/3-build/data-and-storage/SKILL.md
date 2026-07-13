---
name: backend-build-data-and-storage
description: Use when implementing backend schemas, queries, transactions, migrations, caches, queues, jobs, backups, or recovery; extends core state-and-data rules with durable server-side persistence mechanics.
---

# Backend Data and Storage

Apply `core-build-state-and-data` and the ownership decisions from
`backend-setup-service-architecture`. This skill governs durable server state.

## Choose the smallest capable store

- Default to a relational database when transactions, constraints, joins, and durable business
  records matter. Add a specialized document, key-value, search, graph, time-series, or object
  store only for a measured access pattern the primary store cannot serve well.
- Keep one authoritative source for each fact. Search indexes, caches, replicas, and warehouses are
  projections with explicit freshness and rebuild behavior.
- Put invariants in both domain logic and database constraints where possible. Use transactions
  around the complete invariant, not arbitrary repository calls.

Choose an ORM, query builder, or SQL based on query visibility, type safety, migration support, and
team competence. Inspect generated queries and retain an escape hatch for performance-critical SQL.

## Model and migrate

1. Model identities, ownership, lifecycle, uniqueness, nullability, retention, and deletion before
   choosing tables or documents.
2. Index from actual query shapes and verify with query plans. Every index pays a write and storage
   cost.
3. Use expand/migrate/contract changes compatible with old and new application versions. Backfill
   in bounded batches, make it resumable, and observe progress and failures.
4. Separate schema rollout from destructive cleanup. A rollback must not require data that the new
   release already destroyed.

## Cache and process work

Treat caching as an optimization with a source of truth, key definition, TTL, invalidation owner,
staleness tolerance, stampede protection, and bypass path. Do not cache before measuring a need.

For background work, persist the job before acknowledging it; define idempotency, timeout, retry
classification, maximum attempts, dead-letter handling, concurrency, ordering, and operator replay.
Use an outbox or equivalent atomic handoff when a database change and event publication must agree.

## Protect recoverability

Encrypt sensitive data, minimize collection, enforce tenant scope on every access path, and follow
`backend-build-backend-security`. Define RPO and RTO, automate backups, monitor their completion,
and perform scheduled restore drills into an isolated environment. A backup is unproven until a
restore verifies schema, records, permissions, and application behavior.

## Completion gate

Schema constraints, transaction boundaries, migration compatibility, query plans, cache/job
failure behavior, retention, backup monitoring, and a tested restore path must be explicit.

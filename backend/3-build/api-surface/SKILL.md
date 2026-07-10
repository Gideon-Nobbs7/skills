---
name: backend-build-api-surface
description: Use when implementing or evolving backend HTTP, GraphQL, RPC, webhook, or event interfaces; extends core contract rules with transport semantics, authentication, idempotency, pagination, rate limits, and delivery guarantees.
status: draft
---

# Backend API Surface

Apply `core-build-apis-and-contracts` first. Keep its contract-first schemas, boundary validation,
stable error strategy, and additive evolution. This overlay owns server transport behavior.

## Select the interface

- Prefer resource-oriented HTTP for broadly consumed request/response APIs.
- Use GraphQL when consumers genuinely need independent selection across a connected domain and
  the team can govern query cost, authorization, caching, and schema evolution.
- Use RPC for controlled service-to-service calls where generated contracts and operation-shaped
  methods improve reliability.
- Use events or webhooks for facts consumers can process asynchronously. Events describe what
  happened; commands request work.

Record why the chosen style fits the consumers. Do not expose multiple equivalent styles by
default.

## Implement boundary semantics

1. Authenticate identity at the boundary and authorize the specific action against the target
   resource or tenant. Authentication never implies authorization.
2. Validate path, query, headers, and body with explicit size and complexity limits.
3. Set timeouts and cancellation propagation. Bound pagination; prefer cursors for changing or
   high-volume collections.
4. Require idempotency keys for retryable create/payment/job operations. Scope keys to caller and
   operation, persist the outcome, and reject a reused key with different input.
5. Apply rate and concurrency limits by authenticated principal plus protective network-level
   controls. Return a stable error and retry guidance without revealing sensitive policy details.
6. Emit correlation identifiers and the RED signals defined by `core-operate-observability`.

## Evolve safely

Publish a machine-readable contract when the ecosystem supports it and test producers against it.
Prefer additive fields and tolerant readers. Version only when a semantic break cannot be migrated
in place; publish a deprecation window, migration path, usage visibility, and removal criterion.

For webhooks and events, sign deliveries, include an immutable event ID and occurred-at timestamp,
document ordering as absent unless guaranteed, retry with backoff, and make consumers deduplicate.
Treat delivery as at-least-once unless the infrastructure proves otherwise.

## Completion gate

The contract, auth rules, idempotency behavior, limits, errors, observability, compatibility plan,
and contract/integration tests must agree before the interface is considered implemented.

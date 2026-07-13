---
name: core-build-state-and-data
description: Design and implement application state, data fetching, caching, optimistic updates, offline sync, conflict handling, forms, validation, input metering, and server/client data boundaries across web, mobile, backend, and UI-heavy applications.
---

# State & Data

State is the application's runtime memory. Keep each piece of data in the smallest reliable home, make transitions explicit, and keep the UI honest about freshness, failure, and pending work.

## Classify State Before Choosing Tools

- Local state belongs to one component, screen, command, or request and dies with it.
- Shared state belongs in a store, context, service, or module only when multiple independent consumers must read or mutate it.
- Derived state should be computed from base state. Do not store duplicate values that can drift.
- Persistent state must define serialization, migration, privacy, expiry, and recovery behavior.
- Server state is not ordinary client state. Treat fetching, caching, invalidation, errors, freshness, and permissions as part of its model.

## Use Explicit Data Flow

- Prefer unidirectional data flow for ordinary UI state: event -> transition -> new state -> render.
- Keep reducers and transition functions deterministic where possible; move side effects to effects, commands, services, or action handlers.
- Use event-driven pub/sub only when decoupling is worth the tracing cost.
- Use finite state machines or statecharts for workflows with mutually exclusive states, legal transitions, guards, retries, or long-running side effects.
- Name states from the user's reality: `idle`, `loading`, `saving`, `success`, `empty`, `error`, `offline`, `conflicted`.

## Fetch, Cache, And Invalidate Deliberately

- Model each resource's lifecycle: fresh, stale, in-flight, inactive, invalidated, and failed.
- Deduplicate identical in-flight requests.
- Prefer stale-while-revalidate for read-heavy UI where showing older data is better than blocking.
- Define cache keys from every input that changes the result: locale, auth scope, filters, pagination cursor, feature flags, and tenant.
- Choose pagination by data behavior: offset for static lists, cursor/keyset for dynamic or high-volume lists.
- Define invalidation at mutation boundaries. A mutation without an invalidation or reconciliation plan is unfinished.

## Handle Optimistic And Offline Work Safely

- Use optimistic updates only when the success path is likely, the rollback is clear, and the user benefits from immediate feedback.
- Snapshot stable state before optimistic mutation; on failure, revert or reconcile and explain what changed.
- Persist offline commands durably before showing them as queued.
- Process durable queues in order when ordering matters; move repeatedly invalid commands to a dead-letter state so they do not block later work forever.
- Define conflict resolution explicitly: last-write-wins only for low-risk records, operational transforms or CRDTs for collaborative/local-first editing, and human review for high-impact conflicts.

## Build Forms As Transaction Boundaries

- Treat raw input as untrusted until sanitized, coerced, schema-validated, and accepted by business logic.
- Choose controlled inputs when live validation, masking, dependent fields, or derived UI need every keystroke.
- Choose uncontrolled or buffered inputs for large grids, high-frequency entry, or performance-sensitive forms.
- Track form metadata separately from values: dirty, touched, validating, valid, submitting, submitted, failed.
- Debounce actions that should wait for typing to stop; throttle actions that must run at most once per time window.
- Show errors when they are useful: after blur, submit, or a clear validation trigger, not as punishment during the first character.

## Keep UI Honest

- Every async surface should expose the right state: loading, refreshing, saving, queued, offline, stale, failed, empty, and partially loaded.
- Avoid global loading flags for independent operations.
- Preserve previous useful data during refresh unless it would mislead the user.
- Keep accessibility in the loop: announce async changes when needed, preserve focus, and avoid layout jumps that disorient users.

## References

- Read `references/state-data-fetching-offline-input-reference.md` for the full platform-agnostic reference on state taxonomy, caching, optimistic updates, offline queues, conflicts, and forms.

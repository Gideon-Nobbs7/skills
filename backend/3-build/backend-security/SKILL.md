---
name: backend-build-backend-security
description: Use when implementing internet-facing services, server authorization, sensitive-data handling, tenant isolation, audit trails, or service identities; extends core secure coding with backend trust boundaries and infrastructure controls.
status: draft
---

# Backend Security

Apply `core-foundations-security-mindset`, `core-setup-env-and-secrets`, and
`core-build-secure-coding` first. This overlay covers controls unique to servers and shared data.

## Define the server threat model

Map internet, user, tenant, service, administrator, data-store, queue, and third-party boundaries.
For each protected action, name the principal, resource, permission, tenant scope, and audit need.
Default deny. Enforce authorization in the service boundary or domain policy on every request and
job; UI visibility and route secrecy are not controls.

## Enforce isolation and least privilege

- Propagate tenant identity from verified authentication, never from an unchecked payload. Apply
  tenant scope to reads, writes, caches, search indexes, object keys, jobs, exports, and logs.
- Use database row policies or isolated schemas/databases when the risk model justifies defense in
  depth; still test application-layer authorization.
- Give workloads distinct short-lived identities and only the network, data, and secret access they
  need. Keep databases and administrative endpoints off the public network where possible.
- Separate user operations from privileged administrative operations and require stronger
  authentication, authorization, and auditing for the latter.

## Protect data and actions

Classify sensitive fields, minimize collection, define retention/deletion, encrypt transport and
storage, and use managed key rotation. Store passwords only with a current password-hashing
function and unique salts. Prevent mass assignment by allowlisting writable fields.

Audit security-relevant actions with actor, action, target, tenant, outcome, request ID, and time.
Keep audit logs append-resistant and access-controlled; exclude secrets and unnecessary personal
data. Define alertable events such as repeated authorization failures or privilege changes.

## Verify the boundary

Test horizontal and vertical authorization, cross-tenant identifiers, background jobs, exports,
cache keys, admin paths, revoked credentials, malformed external responses, and failure defaults.
Run dependency and secret scanning through core CI, but do not treat scanners as proof of access
control. Use `core-verify-testing-strategy` for risk allocation and
`core-operate-incident-response` for suspected compromise.

## Completion gate

Every entry point has authenticated identity where required, resource-level authorization, tenant
isolation, bounded input, protected secrets, appropriate audit events, and adversarial tests.

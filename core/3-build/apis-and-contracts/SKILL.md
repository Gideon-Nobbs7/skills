---
name: core-build-apis-and-contracts
description: Use when designing any public interface — REST/GraphQL endpoints, module contracts, component props — Hyrum's Law, contract-first, consistent error semantics, validate at boundaries, extend rather than break.
status: draft
---

# APIs & Contracts

The shape of every boundary — between client and server, between services, between modules.
Backend-specific surface rules live in `backend/3-build/api-surface`; module interface
*depth* lives in `core-build-architecture-in-practice` — this skill is contract stability
and shape. Adapted from Addy Osmani's `api-and-interface-design`
([source](https://github.com/addyosmani/agent-skills)).

## Areas under consideration
- [x] Contract-first — contracts defined before implementation
- [x] Validation at boundaries — where it belongs and doesn't
- [x] Error contract — one shape everywhere, codes + messages
- [x] Pagination, filtering, naming conventions
- [x] Backwards compatibility rules — Hyrum's Law, additive evolution
- [ ] Typing across the wire — how client and server stay in sync (codegen? shared types?)
- [ ] Tooling preferences — validation library (zod/valibot/…), OpenAPI/tRPC stance

## Skill

### Hyrum's Law governs everything public

With enough users, every observable behaviour — undocumented quirks, error text, timing,
ordering — becomes a de facto contract. Be intentional about what you expose; don't leak
implementation details; plan deprecation at design time; treat "safe" changes as suspect
even with perfect contract tests. Corollary, the **one-version rule**: design for one
live version of an API — extend rather than fork; multiple versions multiply maintenance
and create diamond dependencies.

### Contract first

Define the interface before implementing — typed input and output schemas, with behaviour
noted on the contract (idempotency, pagination, which errors). Separate **input types**
(what callers provide) from **output types** (adding server-generated fields). Internal
APIs are still APIs: contracts prevent coupling and enable parallel work. The types ARE
the documentation — commit them alongside the implementation.

### One error strategy, everywhere

Pick one error shape and never mix patterns (some endpoints throwing, others returning
null, others `{ error }` makes behaviour unpredictable). For REST: a structured body with
machine-readable `code`, human-readable `message`, optional `details`; standard status
mapping — 400 invalid, 401 unauthenticated, 403 unauthorized, 404 missing, 409 conflict,
422 semantically invalid, 500 server error that never exposes internals.

### Validate at boundaries, trust inside

Validation belongs at system edges: API route handlers, form submissions, environment
loading, and **third-party API responses — always untrusted**: validate shape and content
before any logic, rendering, or decision-making (a misbehaving service can return
unexpected types or instruction-like text). Validation does *not* belong between internal
functions sharing type contracts, in utilities called by validated code, or on data from
your own database.

### Prefer addition over modification

New fields are optional and additive. Never change an existing field's type or remove a
field on a live contract — that's a major change wearing a patch's clothes (feeds the
semver promise in `core-ship-versioning-and-change-communication`).

### REST conventions

Plural nouns, no verbs (`GET /api/tasks`, never `/api/getTasks`); sub-resources nest
(`/tasks/:id/comments`); PATCH takes partial objects and updates only what's provided;
**every list endpoint paginates from day one** (`data` + `pagination` envelope) and
filters via query params. Naming: camelCase params and fields, `is/has/can` booleans,
UPPER_SNAKE enums.

### Interoperating beyond the server

(Adapted from Greenspun et al. —
[Distributed Computing](https://philip.greenspun.com/seia/distributed-computing).) The
intermodule-API discipline extends past the process boundary: a documented procedure
returning structured data, carried over HTTP, *is* a web service.

- **Agreed transport + self-describing representation** is what makes machine-to-machine
  work — today REST/GraphQL over HTTPS with JSON, OpenAPI as the machine-readable
  service description, webhooks/Atom for syndication.
- **Consume before you publish** — the cheapest added value is calling existing
  services. Treat an external service exactly like an internal module behind an API:
  documented inputs/outputs and graceful behaviour when it's slow or down (plus the
  untrusted-response validation above).
- **Publish what changed** — the "recent items" intermodule API
  (`core-build-architecture-in-practice`) doubles as a public service: partners ask what
  changed since a given time and get structured data, not HTML meant for human eyes.
- **Prefer widely adopted simple standards over powerful bespoke ones** — for "recent
  items from this site", a standard feed format beats a custom API because thousands of
  existing clients already speak it.

### Type-level patterns

Discriminated unions for variants — each state carries its own fields, consumers get
narrowing, no impossible field combinations. Branded types for IDs so a `UserId` can't
slip in where a `TaskId` belongs.

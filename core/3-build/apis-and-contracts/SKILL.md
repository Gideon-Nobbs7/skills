---
name: core-build-apis-and-contracts
description: API design, schemas and validation at boundaries, error contracts, typing across the wire. (stub — awaiting content)
status: stub
---

# APIs & Contracts

The shape of every boundary — between client and server, between services, between modules.
Backend-specific surface rules live in `backend/3-build/api-surface`.

## Areas under consideration
- [ ] Contract-first vs code-first — how contracts are defined and shared
- [ ] Validation at boundaries — tooling (zod/valibot/…), parse-don't-validate stance
- [ ] Error contract — the shape every error takes, error codes vs messages
- [ ] Typing across the wire — how client and server stay in sync (codegen? shared types?)
- [ ] Pagination, filtering, sorting conventions
- [ ] Backwards compatibility rules for evolving a contract

## Skill
_(awaiting intake — will be written as directives an agent can follow)_

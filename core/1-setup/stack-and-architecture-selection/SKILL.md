---
name: core-setup-stack-and-architecture-selection
description: Use when choosing a stack, system architecture, architectural pattern, or design-pattern direction before building; applies problem-first trade-off evaluation, defaults to simple modular designs, records rejected alternatives, and uses the bundled architecture guide for pattern lookup.
---

# Stack & Architecture Selection

Choose structure from the problem, not from trend, familiarity, or pattern names. The bundled
reference is the local source of truth for architecture and pattern lookup:
[`references/software-architecture-and-design-patterns-guide.md`](references/software-architecture-and-design-patterns-guide.md).

## Areas under consideration

- [x] Architecture vs architectural pattern vs design pattern
- [x] Problem-first evaluation sequence
- [x] Architecture selection baseline
- [x] Problem-to-pattern lookup
- [x] Rejecting over-engineered mismatches
- [ ] Default stacks per project type
- [ ] Approved / avoided technology list
- [ ] ADR format

## Decision sequence

Use this order:

1. Normalize the problem: actors, capabilities, data, workflows, boundaries, and constraints.
2. Identify quality attributes: scalability, availability, consistency, security, latency,
   modifiability, operability, cost, delivery speed, accessibility, and performance.
3. Identify what varies independently: algorithms, vendors, product families, states, consumers,
   teams, deployment cadence, data volume, or compliance.
4. Choose the smallest architecture that satisfies the current constraints.
5. Add architectural or design patterns only for named problem signals.
6. Reject mismatches whose operational or conceptual cost exceeds the problem.
7. Write the decision with trade-offs, assumptions, rejected alternatives, and a validation plan.

## Default architecture bias

- Small CRUD product -> modular monolith with layers.
- Rich business rules -> modular monolith with hexagonal or clean boundaries around the domain.
- Multiple independently changing teams -> services aligned to business capabilities.
- High-volume asynchronous work -> event-driven components, not full event sourcing unless history
  and replay are the product requirement.
- Multiple external systems -> ports and adapters around provider boundaries.
- Extreme or unpredictable scale -> cloud-native/distributed design only when evidence demands it.

Prefer modular monoliths until independent deployment, ownership, scale, or isolation is proven.
Microservices, event sourcing, serverless, and distributed workflows buy power by adding failure
modes, observability needs, data consistency problems, local-dev friction, and deployment cost.

## Pattern discipline

Treat patterns as named trade-offs:

- Use Factory Method or Abstract Factory when product creation varies.
- Use Builder when construction has meaningful optional steps or validation.
- Use Adapter when an external or legacy interface does not match the product interface.
- Use Facade when callers are exposed to too much subsystem complexity.
- Use Strategy when algorithms vary independently.
- Use State when lifecycle state changes behavior.
- Use Command or Memento for undo, queueing, replay, scheduling, or rollback.
- Use Observer for local notification; use event-driven architecture only when decoupling crosses
  ownership, deployment, or process boundaries.

Do not recommend a pattern because it is popular. Name the problem signal that earned it.

## Decision record

Every non-obvious architecture decision records:

- Problem and current constraints.
- Recommendation and confidence.
- Why this fits now.
- Alternatives rejected and why.
- Benefits, costs, and risks.
- Assumptions that would change the decision.
- Validation plan: spike, benchmark, prototype, migration slice, or rollback strategy.

Handoff to `core-build-architecture-in-practice` once coding begins.

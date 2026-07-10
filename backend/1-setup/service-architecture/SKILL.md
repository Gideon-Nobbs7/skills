---
name: backend-setup-service-architecture
description: Use when designing backend/server architecture — the five-layer model, "where is the state?" as the central scaling question, stateless upper layers over a stateful persistence layer, capacity from measured per-request cost, any-machine-can-die.
status: draft
---

# Service Architecture

The backend overlay on `core/1-setup/stack-and-architecture-selection`. First filled
discipline: **scaling architecture**, adapted from Greenspun et al. —
[Scaling Gracefully](https://philip.greenspun.com/seia/scaling) (technical half; the
human/community half lives in `core-operate-feedback-and-iteration`).

## Areas under consideration
- [x] Layering and state placement — the scaling shape
- [x] Capacity planning and failure design
- [ ] Monolith-first stance — when (if ever) services from day one
- [ ] Runtime/language defaults for backend work
- [ ] Data modeling approach — schema design habits, normalization stance
- [ ] Migration strategy — tooling, forward-only vs reversible
- [ ] Boundary rules — what earns its own service/queue/database

## Skill

### Think in layers

A production application separates into: TLS termination → HTTP service → presentation
(page/response assembly) → abstraction (business logic and APIs) → persistence (the
database and its transactions). Layers scale, get replaced, and get distributed
independently. The modern mapping: CDN + managed load balancer + stateless application
containers + managed database with read replicas — autoscaling automates the capacity
math but doesn't remove the need to know where state lives.

### The central question: where is the state?

Every hard scaling question reduces to it. Stateless layers replicate trivially behind a
load balancer; stateful ones (sessions, the database) are where engineering effort
concentrates. **Push state down into the persistence layer and keep everything above it
stateless** — then horizontal scaling of the upper layers is routine, and the database is
the one deliberate hard problem (replicas, failover clusters, distributed SQL — each
trading consistency, cost, and complexity; choose knowingly).

### Budget capacity from measured cost

Plan capacity from the measured per-request cost of your actual pages under your actual
load (`core-operate-observability` supplies the numbers), with explicit headroom — not
from vendor rules of thumb. Specific numbers age; the discipline doesn't.

### Design for any machine to die

Multiple front-ends behind a load balancer buy both capacity and failover. The test for
every component: this machine disappears — does the site stay up? Single points of
failure are found at design time, not during the incident
(`core-operate-incident-response` handles the ones that ship anyway).

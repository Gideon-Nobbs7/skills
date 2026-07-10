# Software Architecture and Design Patterns Guide

## Purpose

This guide is a learning and decision-support reference for selecting an appropriate architecture, design pattern, or combination of both.

It separates three levels of decision:

1. **Architecture:** the large-scale shape of a system and its deployable/runtime boundaries.
2. **Architectural pattern:** a recurring solution for organizing subsystems or major qualities such as scalability, integration, or resilience.
3. **Design pattern:** a reusable solution to a local design problem involving classes, objects, modules, or components.

The design-pattern catalog is mapped from [Refactoring.Guru's design-pattern catalog](https://refactoring.guru/design-patterns), including its [classification](https://refactoring.guru/design-patterns/classification) and individual pattern pages. The source presents 22 classic patterns in three intent groups: creational, structural, and behavioral.

---

## 1. The decision model

Use the following sequence:

```text
Understand the problem
  -> identify quality attributes and constraints
  -> choose system architecture
  -> choose architectural/integration patterns
  -> choose local design patterns
  -> test the trade-offs and revisit
```

Do not begin by asking “Which pattern should I use?” Begin with “What is changing, what must remain stable, and what failure or scale must the system tolerate?”

### Pattern entry template

Every pattern entry in this guide should eventually contain:

- **Intent:** the short purpose of the pattern.
- **Common problem:** the recurring situation that makes the design painful.
- **Forces:** competing concerns and constraints.
- **Solution:** the relationship introduced by the pattern.
- **Participants:** the main roles and responsibilities.
- **Example:** a small concrete scenario.
- **Benefits:** what improves.
- **Costs and risks:** what becomes more complex.
- **Use when:** signals that justify the pattern.
- **Avoid when:** signals that the pattern would be overengineering.
- **Related patterns:** alternatives and combinations.

---

## 2. Architecture map

### 2.1 Monolith and modular monolith

**Problem addressed:** A product needs to be delivered quickly without the operational cost of many independently deployed services.

**Solution:** Keep one deployable application, but organize the code into explicit business or technical modules with stable interfaces.

**Example:** An online store deployed as one application with Catalog, Orders, Payments, and Shipping modules.

**Best fit:** Small teams, early products, modest scale, strong need for transactional consistency.

**Main risk:** A poorly modularized monolith becomes a tightly coupled “big ball of mud.”

**Useful patterns:** Facade, Mediator, Repository, Service Layer, Dependency Injection, Module/Package boundaries.

### 2.2 Layered / n-tier architecture

**Problem addressed:** Business rules, user interface, and infrastructure code are mixed together and changes ripple through the codebase.

**Solution:** Separate responsibilities into layers, commonly presentation, application/service, domain, and infrastructure/data access.

**Example:** A REST controller calls an application service, which invokes domain logic and a repository.

**Best fit:** Conventional business applications and teams that benefit from familiar boundaries.

**Main risk:** Layers become pass-through code, and the domain becomes dependent on the database or framework.

**Useful patterns:** MVC, Service Layer, Repository, Data Mapper, DTO, Factory Method.

### 2.3 Hexagonal / Ports and Adapters

**Problem addressed:** Core business logic is coupled to databases, HTTP frameworks, queues, payment providers, or user interfaces.

**Solution:** Put domain and use-case logic at the center. Define ports as interfaces; implement external adapters around them.

**Example:** `PaymentPort` is implemented by `StripePaymentAdapter` in production and `FakePaymentAdapter` in tests.

**Best fit:** Systems with valuable business rules, multiple interfaces, or a need for replaceable infrastructure.

**Main risk:** Too many abstractions for a trivial CRUD application.

**Useful patterns:** Adapter, Dependency Injection, Repository, Facade, Strategy.

### 2.4 Clean / Onion architecture

**Problem addressed:** Dependencies point toward volatile infrastructure instead of stable business rules.

**Solution:** Arrange the system in concentric boundaries. Dependencies point inward toward domain concepts and use cases.

**Example:** A web endpoint depends on an application use case; the use case depends on a repository interface; the database adapter implements that interface.

**Best fit:** Long-lived, business-critical systems where testability and change isolation matter.

**Main risk:** Ceremony and abstractions can obscure simple workflows.

### 2.5 Microservices

**Problem addressed:** A large system needs independently deployable, independently scalable, or independently owned business capabilities.

**Solution:** Split the system into services aligned with business boundaries. Each service owns its code and usually its data, communicating through APIs or messages.

**Example:** Orders, Inventory, Payments, and Notifications are separately deployed services.

**Best fit:** Multiple teams, independently changing capabilities, differentiated scaling, or strong isolation needs.

**Main risk:** Distributed transactions, network failures, observability, deployment, and data consistency become first-class problems.

**Useful patterns:** API Gateway, Saga, Circuit Breaker, Retry, Timeout, Bulkhead, Outbox, Service Discovery, Database-per-Service.

### 2.6 Service-oriented architecture (SOA)

**Problem addressed:** Many applications need shared enterprise capabilities and standardized integration.

**Solution:** Expose coarse-grained services with explicit contracts, often with centralized governance and integration infrastructure.

**Example:** Several applications consume a shared Customer, Identity, or Billing service.

**Best fit:** Large organizations integrating existing systems and requiring common policies.

**Main risk:** Excessive centralization can create a bottleneck or a distributed monolith.

### 2.7 Event-driven architecture

**Problem addressed:** Producers should not need direct knowledge of all consumers, and work may need to happen asynchronously.

**Solution:** Components publish events representing facts; consumers subscribe and react independently.

**Example:** `OrderPlaced` is consumed by Inventory, Payments, Email, and Analytics.

**Best fit:** Asynchronous workflows, integration, auditability, and independent consumers.

**Main risk:** Eventual consistency, difficult debugging, duplicate delivery, ordering, and schema evolution.

**Useful patterns:** Observer, Publish–Subscribe, Message Broker, Outbox, Saga, Event Sourcing, Idempotent Consumer.

### 2.8 Serverless

**Problem addressed:** The team wants elastic execution without managing servers or always-on application infrastructure.

**Solution:** Compose managed functions and cloud services, with execution triggered by HTTP requests, queues, schedules, or events.

**Example:** An image-upload event triggers a function that resizes the image and writes metadata.

**Best fit:** Event processing, variable workloads, small independently deployable functions.

**Main risk:** Vendor coupling, cold starts, distributed tracing, local development, and cost surprises.

### 2.9 Data-centered architectures

Common variants include:

- **Shared database:** simple integration, but high coupling between consumers.
- **Database-per-service:** stronger ownership and autonomy, but cross-service queries are harder.
- **CQRS:** separate models for commands and queries when read/write needs differ significantly.
- **Event sourcing:** persist domain events as the source of truth when history and reconstruction matter.
- **Primary–replica:** scale reads and improve availability, accepting replication lag.
- **Sharding/partitioning:** distribute data for scale, at the cost of query and operational complexity.

### 2.10 Architecture selection baseline

| Situation | Strong starting point | Escalate only when evidence supports it |
|---|---|---|
| Small CRUD product | Modular monolith + layers | Microservices or event-driven design |
| Rich business rules | Modular monolith + hexagonal/clean boundaries | Service decomposition |
| Many independent teams | Services aligned to business capabilities | More infrastructure/platform patterns |
| High-volume asynchronous work | Event-driven components | Event sourcing or complex streaming |
| Multiple external systems | Hexagonal architecture + adapters | SOA or integration platform |
| Extreme or unpredictable scale | Cloud-native/serverless/distributed design | Specialized partitioning and resilience patterns |

---

## 3. The 22 classic design patterns

## 3.1 Creational patterns

These address object-creation complexity, variation, and lifecycle control. See the [creational catalog](https://refactoring.guru/design-patterns/creational-patterns).

### Factory Method

**Problem:** Client code directly constructs concrete products, so adding a product type requires changing the client or a large conditional.

**Solution:** Define a creation method in a common creator and let subclasses or implementations decide which concrete product to create.

**Example:** A notification service creates `EmailNotification`, `SmsNotification`, or `PushNotification` through a common `createNotification()` method.

**Benefits:** Localizes construction and supports extension through new creators/products.

**Costs:** Adds subclasses or creator objects.

**Use when:** Product type varies by configuration, environment, or subclass behavior.

**Avoid when:** There is only one stable product and construction is already simple.

### Abstract Factory

**Problem:** A system must create families of related objects that must be compatible with one another.

**Solution:** Provide an interface for creating the entire product family without exposing concrete classes.

**Example:** A UI toolkit creates a matching `WindowsButton` and `WindowsCheckbox`, or matching Mac components.

**Benefits:** Enforces product compatibility and isolates platform-specific creation.

**Costs:** Adding a new product kind requires changing every factory.

**Use when:** The product family varies as a unit, such as themes, platforms, or database vendors.

### Builder

**Problem:** A complex object has many optional fields, construction steps, or validation rules, making constructors unreadable or error-prone.

**Solution:** Build the object step by step through a dedicated builder, then produce the final representation.

**Example:** Build a search request with optional filters, pagination, sorting, and authorization context.

**Benefits:** Clear construction, reusable steps, validation at build time, and multiple representations.

**Costs:** More types and code for simple objects.

**Use when:** Construction is complex or must remain readable and safe.

### Prototype

**Problem:** Creating an object from scratch is expensive, or client code should not depend on concrete classes.

**Solution:** Copy a configured prototype through a clone operation.

**Example:** Duplicate a preconfigured document template, game entity, or workflow definition.

**Benefits:** Avoids expensive setup and hides concrete types.

**Costs:** Deep-copy semantics, shared references, and clone correctness can be difficult.

**Use when:** Objects have expensive initialization or many configuration variants.

### Singleton

**Problem:** A resource must have one coordinated instance and a convenient access point.

**Solution:** Restrict construction and expose the single instance.

**Example:** A process-wide metrics registry, though dependency injection is often preferable.

**Benefits:** Controlled instance count and shared coordination.

**Costs:** Global state, hidden dependencies, testing difficulty, and concurrency concerns.

**Use sparingly:** Prefer an explicitly managed dependency or application-scoped service when possible.

## 3.2 Structural patterns

These assemble classes and objects into larger, flexible structures. See the [structural catalog](https://refactoring.guru/design-patterns/structural-patterns).

### Adapter

**Problem:** Existing classes have incompatible interfaces but must collaborate.

**Solution:** Wrap the existing class behind the interface the client expects.

**Example:** Adapt a payment provider SDK to the application’s `PaymentPort`.

**Benefits:** Isolates vendor differences and preserves existing code.

**Costs:** More indirection and potential semantic mismatch.

### Bridge

**Problem:** A class varies along two independent dimensions, causing a multiplication of subclasses.

**Solution:** Split abstraction from implementation and compose them.

**Example:** `RemoteControl` varies independently from `Device`, allowing different remotes and devices without every combination becoming a subclass.

**Benefits:** Independent extension and reduced subclass explosion.

**Costs:** More objects and a more abstract design.

### Composite

**Problem:** Clients must handle individual objects and groups of objects differently.

**Solution:** Represent part-whole hierarchies so leaves and containers share a common interface.

**Example:** A file system where files and directories both support `size()`, `move()`, and `delete()`.

**Benefits:** Uniform treatment of trees and recursive structures.

**Costs:** The common interface may be too broad for some node types.

### Decorator

**Problem:** Behavior must be added selectively without changing the original class or creating many subclasses.

**Solution:** Wrap an object with another object implementing the same interface and delegate while adding behavior.

**Example:** Wrap an HTTP client with logging, retry, caching, and metrics decorators.

**Benefits:** Composable behavior and adherence to open/closed design.

**Costs:** Many small wrappers, ordering effects, and harder debugging.

### Facade

**Problem:** A subsystem is complicated and clients depend on too many internal classes.

**Solution:** Expose a small, intention-revealing interface over the subsystem.

**Example:** `CheckoutFacade.placeOrder()` coordinates inventory, payment, shipping, and notifications.

**Benefits:** Lower coupling and simpler client code.

**Costs:** The facade can become a god object if it accumulates unrelated behavior.

### Flyweight

**Problem:** Very many similar objects consume excessive memory.

**Solution:** Share immutable intrinsic state and keep context-specific extrinsic state outside the shared object.

**Example:** A text editor shares font glyph data while each character stores its position separately.

**Benefits:** Lower memory use and potentially better performance.

**Costs:** More indirection and careful separation of shared versus contextual state.

### Proxy

**Problem:** Access to an object needs control, delayed creation, remote access, caching, or additional policy.

**Solution:** Provide a substitute with the same interface that controls or augments access to the real subject.

**Example:** A lazy image proxy loads the full image only when displayed; an authorization proxy checks permissions first.

**Benefits:** Access control, lazy loading, caching, remote access, and instrumentation.

**Costs:** Hidden latency and behavior behind an apparently simple interface.

## 3.3 Behavioral patterns

These address algorithms, communication, and responsibility assignment. See the [behavioral catalog](https://refactoring.guru/design-patterns/behavioral-patterns).

### Chain of Responsibility

**Problem:** Several checks or handlers may process a request, but their order or membership can change.

**Solution:** Link handlers into a chain; each handles or forwards the request.

**Example:** Authentication → authorization → validation → rate limiting → cache → controller.

**Benefits:** Reorderable, composable checks; each handler has one responsibility.

**Costs:** Requests can be unhandled or silently stopped; tracing the path requires care.

### Command

**Problem:** A sender is tightly coupled to the operation it invokes, or operations need queuing, logging, retries, scheduling, or undo.

**Solution:** Represent a request as an object containing the operation and its parameters.

**Example:** A text editor stores `InsertText`, `DeleteSelection`, and `Paste` commands in an undo history.

**Benefits:** Queueing, replay, undo/redo, auditing, and decoupled senders.

**Costs:** Many command classes and possible state-management complexity.

### Iterator

**Problem:** Clients need to traverse a collection without depending on its internal representation.

**Solution:** Provide a traversal object with a consistent iteration interface.

**Example:** Traverse a tree depth-first or breadth-first without exposing its node storage.

**Benefits:** Encapsulates traversal and supports multiple traversal strategies.

**Costs:** Iterator lifecycle and mutation rules need definition.

### Mediator

**Problem:** Many objects communicate directly, creating a dense web of dependencies.

**Solution:** Introduce a mediator that coordinates communication among colleagues.

**Example:** A dialog mediator coordinates validation, button state, and field changes.

**Benefits:** Reduces peer-to-peer coupling.

**Costs:** The mediator can become a god object if it owns too much workflow.

### Memento

**Problem:** An object needs undo/restore capability without exposing its private state.

**Solution:** Capture state in a memento that only the originator can create or interpret.

**Example:** Save editor snapshots before each change.

**Benefits:** Encapsulation-preserving undo and rollback.

**Costs:** Memory use and snapshot-version compatibility.

### Observer

**Problem:** One object changes and multiple dependents need to react without tight coupling.

**Solution:** Subscribers register with a subject and receive notifications when relevant state or events change.

**Example:** An order-status publisher notifies email, audit, analytics, and UI subscribers.

**Benefits:** Extensible notification and loose coupling between publisher and consumers.

**Costs:** Ordering, duplicate notifications, memory leaks, and cascading failures.

### State

**Problem:** A class contains large conditionals whose behavior depends on its current state.

**Solution:** Represent each state as an object and delegate state-specific behavior to the active state.

**Example:** An order behaves differently when Draft, Paid, Shipped, Cancelled, or Refunded.

**Benefits:** Localizes state behavior and makes transitions explicit.

**Costs:** More classes and potentially complicated transition rules.

### Strategy

**Problem:** Several algorithms solve the same task, and conditionals select among them.

**Solution:** Encapsulate each algorithm behind a common interface and inject or select one at runtime.

**Example:** Select a shipping-cost, tax, pricing, or route-planning algorithm.

**Benefits:** Replaceable algorithms, easier testing, and less conditional logic.

**Costs:** Clients must know which strategy to choose; small strategies may add ceremony.

### Template Method

**Problem:** Several algorithms share an overall process but differ in a few steps.

**Solution:** Define the algorithm skeleton once and let subclasses override selected steps.

**Example:** A data-import workflow always validates, transforms, persists, and reports, while file parsing varies.

**Benefits:** Reuses invariant workflow structure.

**Costs:** Inheritance coupling and fragile base-class behavior.

### Visitor

**Problem:** Many operations must be added to a stable object structure, and putting every operation into the elements would make them unwieldy.

**Solution:** Move operations into visitor objects; elements accept visitors through double dispatch.

**Example:** An abstract syntax tree supports type checking, formatting, interpretation, and code generation as separate visitors.

**Benefits:** Adds operations without modifying every element.

**Costs:** Adding a new element type requires changing all visitors; can be difficult with mutable state.

---

## 4. Problem-to-pattern lookup

| Problem signal | Candidate pattern(s) | First question to ask |
|---|---|---|
| Concrete type creation is scattered | Factory Method, Abstract Factory | Which variation changes: one product or a family? |
| Object construction has many optional steps | Builder | Is construction itself complex enough to deserve a type? |
| Vendor interface does not match ours | Adapter | Can the vendor be isolated behind our interface? |
| Two dimensions create subclass explosion | Bridge | Can the dimensions vary independently? |
| Tree of objects needs uniform treatment | Composite | Do leaves and containers share meaningful operations? |
| Add behavior without subclass explosion | Decorator, Strategy | Is behavior stacked or selected as one algorithm? |
| Complex subsystem overwhelms callers | Facade | What is the smallest use-case-oriented interface? |
| Request must pass ordered checks | Chain of Responsibility | Can a handler stop or forward the request? |
| Request needs undo, queueing, or replay | Command, Memento | Is the operation or the state being captured? |
| Many dependents react to a change | Observer | Is this local notification or distributed event integration? |
| Behavior changes with lifecycle state | State | Are the conditional branches really state transitions? |
| Multiple interchangeable algorithms | Strategy | What algorithm varies independently? |
| Shared workflow with variable steps | Template Method | Is inheritance appropriate, or would composition be safer? |
| Many operations over a stable object tree | Visitor | Will element types remain stable? |
| Access must be delayed or controlled | Proxy | Is the concern access, loading, caching, or authorization? |

---

## 5. Architecture-and-pattern evaluator

### 5.1 Input schema

The evaluator should accept a problem statement plus structured signals:

```yaml
problem: "Describe the system or change in plain language"
scope: local | component | application | organization | distributed
domain_complexity: low | medium | high
team_count: 1 | 2-5 | many
independent_deployment: none | useful | required
scale: low | variable | high | extreme
consistency: eventual_ok | mixed | strong
latency: relaxed | interactive | strict
workflow_style: request_response | batch | event_driven | mixed
external_integrations: none | few | many
change_drivers:
  - algorithms
  - vendors
  - product_features
  - teams
  - traffic
  - data_volume
  - compliance
constraints:
  - budget
  - skills
  - legacy
  - delivery_time
```

### 5.2 Evaluation process

1. **Normalize the problem.** Extract actors, capabilities, data, workflows, boundaries, and desired qualities.
2. **Classify the scope.** Local code problems suggest design patterns; cross-module problems suggest architectural patterns; system-wide problems suggest architecture.
3. **Identify dominant quality attributes.** Rank scalability, availability, consistency, security, latency, modifiability, operability, cost, and delivery speed.
4. **Identify change axes.** Find what varies independently: algorithms, product families, providers, states, consumers, teams, deployment cadence, or data volume.
5. **Generate candidates.** Select architectures first, then architectural patterns, then design patterns.
6. **Reject mismatches.** Remove candidates whose costs exceed the stated problem or whose assumptions conflict with constraints.
7. **Score and explain.** Return a recommendation with evidence, trade-offs, confidence, and rejected alternatives.
8. **Design a validation plan.** Suggest a spike, benchmark, prototype, or migration slice rather than treating the recommendation as certainty.

### 5.3 Scoring rubric

Score each candidate from 0 to 5:

```text
fit =
  3 * problem_fit
  + 2 * quality_attribute_fit
  + 2 * change_isolation_fit
  + 1 * team_and_operational_fit
  + 1 * migration_fit
  - 2 * complexity_penalty
  - 2 * mismatch_penalty
```

The evaluator must never recommend a pattern solely because it is popular. It should explain which problem signal earned each score.

### 5.4 Output schema

```yaml
recommendation:
  scope: architecture | architectural_pattern | design_pattern | combination | no_pattern
  primary:
    name: "Modular monolith"
    confidence: low | medium | high
    why: "..."
  supporting_patterns:
    - name: "Adapter"
      location: "payment integration boundary"
      why: "..."
  alternatives:
    - name: "Microservices"
      reject_reason: "Independent deployment is not yet required; operational cost is higher."
  tradeoffs:
    benefits: []
    costs: []
    risks: []
  assumptions: []
  validation:
    - "Build a vertical slice with two modules and measure change isolation."
```

### 5.5 Evaluator examples

#### Example A: Small product with growing feature set

**Input:** One team is building an online store. Features change weekly. Traffic is moderate. Strong transactions are useful. No independent deployment requirement.

**Recommendation:** Modular monolith with layered or hexagonal boundaries.

**Supporting patterns:** Facade for checkout, Repository for persistence, Strategy for shipping calculation, State for order lifecycle, Adapter for payment providers.

**Reject:** Microservices at this stage because the stated problem does not justify distributed operational complexity.

#### Example B: Many independent consumers of an order event

**Input:** Orders must trigger inventory, billing, notifications, analytics, and fulfillment. Consumers change independently and can tolerate eventual consistency.

**Recommendation:** Event-driven architecture or an event-driven slice within a modular monolith.

**Supporting patterns:** Publish–Subscribe, Outbox, Idempotent Consumer, Observer-like local handlers, Saga if the workflow spans services.

**Reject:** A synchronous chain of direct service calls if consumer independence and failure isolation are primary goals.

#### Example C: One class has many payment algorithms

**Input:** Payment calculation varies by country, payment method, customer tier, and promotional rules. The rest of the application should not change when a rule changes.

**Recommendation:** Design pattern only: Strategy, optionally selected through Factory Method.

**Architecture:** No architecture change is required; the problem is local.

#### Example D: Legacy provider integration

**Input:** The application’s domain model must use `PaymentPort`, but a legacy provider exposes a very different API and error model.

**Recommendation:** Hexagonal boundary plus Adapter.

**Supporting patterns:** Facade for a simplified provider workflow, Proxy for authorization or caching, Strategy if multiple providers are selected at runtime.

---

## 6. Guardrails for recommendations

- Prefer the simplest architecture that satisfies current constraints.
- Treat patterns as named trade-offs, not mandatory frameworks.
- Separate domain logic from volatile infrastructure when the domain is valuable or complex.
- Prefer composition over inheritance when behavior must vary at runtime.
- Use asynchronous messaging only when its decoupling or throughput benefits justify eventual consistency and operational cost.
- Do not call every class a service or every event an event-driven architecture.
- Make ownership, failure behavior, observability, and data consistency explicit.
- Record rejected alternatives; this preserves the reasoning behind the decision.
- Re-evaluate when the scale, team structure, regulatory constraints, or change rate changes.

## 7. Future expansion plan

This foundation can become a full skill by adding:

1. One worked code example per pattern in a selected language.
2. Diagrams showing participants and request/data flow.
3. Architecture case studies with decision records.
4. A machine-readable pattern catalog with tags and anti-signals.
5. An evaluator prompt and test set covering small, medium, and distributed problems.
6. A feedback loop that compares recommendations with the user’s actual constraints and outcomes.

## Source map

- [Refactoring.Guru — Design Patterns](https://refactoring.guru/design-patterns)
- [Classification of patterns](https://refactoring.guru/design-patterns/classification)
- [Creational patterns](https://refactoring.guru/design-patterns/creational-patterns)
- [Structural patterns](https://refactoring.guru/design-patterns/structural-patterns)
- [Behavioral patterns](https://refactoring.guru/design-patterns/behavioral-patterns)
- [Code examples](https://refactoring.guru/design-patterns/code-examples)

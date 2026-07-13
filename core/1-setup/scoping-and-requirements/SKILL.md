---
name: core-setup-scoping-and-requirements
description: Use when pinning down what a project is before building — domain modeling and ubiquitous language (CONTEXT.md glossary), ADRs, the planning document (user classes, scenarios, competition, community design), and NFR capture across the fourteen quality attributes.
---

# Scoping & Requirements

The questions every project answers before the first real decision is made — and the
active discipline of building the project's **domain model** as those answers land.
Domain-modeling content adapted from Matt Pocock's `domain-modeling` (+ CONTEXT-FORMAT,
ADR-FORMAT) ([source](https://github.com/mattpocock/skills)).

## Areas under consideration
- [x] How requirements/vocabulary are recorded so agents can reference them mid-build —
      CONTEXT.md glossary + ADRs
- [x] ADR format and the three-part test for when a decision earns one
- [x] The intake questions — the planning document (user classes, scenarios, competition)
- [x] Success criteria format — NFRs quantified, owned, testable
- [x] Constraints checklist — the fourteen-attribute NFR catalogue walk
- [ ] MVP-cut philosophy — how scope gets trimmed, what never gets cut (a11y? security?)

## Skill

### Write the planning document before code

(Adapted from Greenspun et al., *Software Engineering for Internet Applications* —
[Planning](https://philip.greenspun.com/seia/planning).) A formal planning document,
circulated to the team and client and revised whenever reality diverges — a living
contract, not a one-time artifact:

- **User classes and scenarios** — every distinct class (anonymous visitor, member,
  moderator, admin, partner) with concrete step-by-step scenarios of what each
  accomplishes per visit. Scenarios expose missing data-model elements and missing pages
  far more cheaply than prototypes do.
- **The user profile** — what's collected at registration, what's accumulated from
  behaviour, what's optional; it drives personalization and the activity analysis in
  `core-operate-observability`.
- **The realistic competition, offline included** — the alternative is often a phone
  call or a spreadsheet, not another app; the service must beat *that*.
- **Magnet content and community design** (when the product is a community) — the
  content that gives early visitors a reason to arrive before user-generated content
  exists; means for members to contribute and to reach each other; ways to distinguish
  and reward valuable members; mechanisms for growth and abuse (the operational half
  lives in `core-operate-feedback-and-iteration`).
- **Practical legalities early** — domain, DNS, and IP rights over content and code in
  writing before disputes arise.

### Capture non-functional requirements at design time

(Adapted from the Microsoft Engineering Fundamentals Playbook's
[NFR section](https://microsoft.github.io/code-with-engineering-playbook/non-functional-requirements/performance/)
and [capture guide](https://microsoft.github.io/code-with-engineering-playbook/design/design-patterns/non-functional-requirements-capture-guide/).)
NFRs are architectural — a 99.99% availability target implies redundancy; data residency
implies region pinning — so they're elicited in the first design conversations, not
discovered in production.

- **Requirements, not aspirations** — each attribute named, quantified, owned, testable.
  "Fast" is a wish; "below 500 ms normal load, below 1 s peak" is a requirement.
- **Walk all fourteen attributes** for any new system; record a quantified requirement
  or an explicit out-of-scope decision for each — silent omission is the failure mode
  the catalogue prevents. The catalogue, by family:
  - *User-facing*: usability, accessibility, internationalization/localization.
  - *Operational*: availability (nines → redundancy/failover), reliability (correct over
    time — fault tolerance, graceful degradation, retries/circuit breakers), disaster
    recovery (RTO/RPO, rehearsed), capacity (headroom from measured per-request cost),
    scalability (stateless tiers, partitionable data), performance
    (`core-build-performance-engineering`).
  - *Structural*: maintainability, portability, interoperability.
  - *Trust*: data integrity (constraints, transactions, audit trails), compliance
    (controls in the pipeline, not post-hoc review), privacy (minimization, purpose
    limitation, consent, GDPR-and-kin alignment).
- **Make trade-offs explicit** — attributes conflict (caching vs integrity, encryption
  vs latency, portability vs platform optimization); state which dominates on collision
  so engineers don't resolve it silently and inconsistently.
- **Tie every NFR to a verification method** — a test type (load test, chaos test, a11y
  audit, compliance review) and a production monitoring signal. An NFR without one won't
  survive contact with a deadline.
- The practical rule: **every PRD carries the NFR table**; dominant attributes get the
  metrics-plus-levers treatment; the top one or two get objectives, criteria, and tests
  wired into the sprint cycle (`core-foundations-performance-values` is the worked
  example of that discipline).

### Build the domain model actively

This is the *active* discipline — merely reading `CONTEXT.md` for vocabulary is a habit any
skill does; this applies when you're changing the model. During any design conversation:

- **Challenge against the glossary** — when the user's term conflicts with `CONTEXT.md`,
  call it out immediately: "Your glossary defines 'cancellation' as X, but you mean Y —
  which is it?"
- **Sharpen fuzzy language** — propose a precise canonical term for vague or overloaded
  ones: "'account' — do you mean the Customer or the User?"
- **Stress-test with concrete scenarios** — invent edge cases that force precision about
  the boundaries between concepts.
- **Cross-reference with code** — when the user states how something works, check whether
  the code agrees, and surface contradictions.
- **Update `CONTEXT.md` inline** — capture resolved terms the moment they crystallise,
  never batched.

### CONTEXT.md is a glossary and nothing else

At the repo root; created lazily when the first term is resolved. No implementation
details, no spec content, no scratch notes. Format: a one-or-two-sentence context
description, then a `## Language` section of terms:

```md
**Order**:
{One or two sentences — what it IS, not what it does.}
_Avoid_: Purchase, transaction
```

Rules: be opinionated (pick the best word, list rivals under `_Avoid_`); definitions tight;
only project-specific concepts (general programming concepts don't belong); group under
subheadings when clusters emerge. Multi-context repos use a root `CONTEXT-MAP.md` listing
each context's `CONTEXT.md`, plus the relationships between contexts (events emitted and
consumed, shared types). Infer which context the current topic belongs to; ask if unclear.

### ADRs — offer sparingly, keep tiny

Offer an ADR only when **all three** hold: hard to reverse, surprising without context,
and the result of a real trade-off. Missing any one → skip it. What qualifies:
architectural shape, integration patterns between contexts, lock-in technology choices,
boundary/ownership decisions (the explicit no-s are as valuable as the yes-s), deliberate
deviations from the obvious path, constraints invisible in the code, and rejected
alternatives with non-obvious reasons (or someone re-suggests GraphQL in six months).

Format: `docs/adr/NNNN-slug.md`, sequentially numbered (scan for the highest, increment),
directory created lazily. The template is a title plus 1–3 sentences — context, decision,
why. The value is recording *that* and *why*, not filling sections. Optional only when
genuinely valuable: status frontmatter (`proposed | accepted | deprecated | superseded`),
considered options, consequences.

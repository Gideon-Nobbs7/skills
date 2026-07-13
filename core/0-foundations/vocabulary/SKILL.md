---
name: core-foundations-vocabulary
description: Use when naming, writing, reviewing, or connecting product-management artifacts such as product briefs, PRDs, requirements, non-functional requirements, roadmaps, initiatives, epics, features, stories, tasks, bugs, risks, decisions, and issue states; establishes one shared project language across every track and phase.
---

# Product and Project Vocabulary

Use one term for one meaning. This skill defines the shared product-management language; it does
not replace the workflows that create or operate these artifacts. Use
`core-setup-scoping-and-requirements` for product definition and requirements, and
`core-setup-planning-and-work-breakdown` for specifications, slicing, triage, and handoff.

## Name artifacts by the question they answer

- **Product brief:** Why should this product or opportunity exist? State problem, audience,
  outcome, evidence, constraints, assumptions, and explicit exclusions.
- **PRD:** What product behavior and outcomes are agreed for a bounded release or capability?
  Include scope, users, scenarios, functional requirements, NFRs, success measures, dependencies,
  risks, and out of scope. A PRD owns intent, not implementation detail.
- **Specification:** How must a settled capability behave at its boundaries? Record detailed
  behavior, contracts, states, edge cases, implementation decisions, and verification decisions.
- **ADR:** Why was a hard-to-reverse, surprising technical decision chosen? Keep the core three-part
  test and format in `core-setup-scoping-and-requirements`.
- **Roadmap:** In what outcome-oriented sequence might the product invest? Express direction and
  confidence, not an unconditional date promise.
- **Release plan:** What verified scope will ship together, through which gates and rollout?
- **Runbook:** How does an operator diagnose, mitigate, or perform a repeatable operational task?

Do not rename the same document according to audience. If one artifact answers multiple questions,
split it or label its sections with the canonical terms above.

## Distinguish requirement types

- **Goal:** Desired product or business outcome. It explains why but is not yet a testable
  obligation.
- **Functional requirement:** Observable capability or rule the system must provide.
- **Non-functional requirement (NFR):** Measurable quality or constraint on behavior, such as
  accessibility, availability, capacity, compliance, integrity, interoperability, localization,
  maintainability, performance, portability, privacy, reliability, scalability, or recovery.
- **Acceptance criterion:** Binary evidence that a specific work item is complete. Write observable
  outcomes, not implementation steps.
- **Success metric:** Measurement used to learn whether the product outcome occurred after delivery.
  It does not replace acceptance criteria.
- **Constraint:** A boundary the solution must respect and cannot trade away locally.
- **Assumption:** An unverified belief on which the plan depends. Attach a validation method.
- **Dependency:** Work, decision, system, or party that must provide something before progress or
  completion.

Write functional requirements as numbered, uniquely named statements. Write every NFR with a
metric, threshold or target, operating conditions, verification method, production signal, and
owner—or explicitly mark it out of scope. Avoid using “requirement” for an idea, preference, or
solution suggestion.

## Use one work hierarchy

Use only the levels the project genuinely needs:

1. **Objective:** Measurable outcome being pursued.
2. **Initiative:** Coordinated investment spanning multiple capabilities or releases.
3. **Epic:** Large coherent capability that must be split before implementation.
4. **Feature:** User-recognizable capability delivering a bounded outcome.
5. **Story:** Small vertical user-value slice with acceptance criteria.
6. **Task:** Implementation or operational work that supports a story or necessary technical
   outcome; it need not independently deliver user value.
7. **Subtask:** Optional local decomposition that does not need independent product tracking.

A **bug** is observed behavior that violates an agreed contract, requirement, or reasonable product
expectation. An **incident** is active material production impact requiring coordinated response. A
**chore** is recurring or low-risk maintenance with no changed product behavior. A **spike** is
time-boxed investigation that ends in evidence and a decision, not production functionality.

Do not use “epic,” “feature,” and “story” interchangeably. Prefer the shallowest hierarchy that
still communicates ownership, dependency, and outcome.

## Name issues for retrieval and action

Write issue titles as `<domain>: <observable outcome or problem>` using the project's canonical
domain vocabulary. Use an imperative outcome for planned work (`billing: prevent duplicate charge
submission`) and an observed symptom for bugs (`billing: retry creates a second charge`). Avoid
titles such as “fix bug,” “backend changes,” “improve UX,” or bare component names.

Every actionable issue contains:

- Context and the user/product impact.
- The intended outcome or reproducible observed behavior.
- At most three acceptance criteria; split the issue when more independent outcomes appear.
- Dependencies and blockers by name.
- Verification method.
- Explicit exclusions when scope could expand.

Use labels as orthogonal dimensions, not synonyms: one **type**, one **state**, optional **area**,
**priority**, and **risk**. Do not encode the same meaning in title prefixes, labels, columns, and
milestones simultaneously.

## Separate state, priority, severity, and risk

- **State** describes workflow position: `needs-triage`, `needs-info`, `ready-for-agent`,
  `ready-for-human`, `in-progress`, `blocked`, `in-review`, `done`, or `wontfix`. Follow the
  transition rules in `core-setup-planning-and-work-breakdown` when processing incoming issues.
- **Priority** describes ordering relative to other work: `P0` immediate interruption, `P1` next
  critical work, `P2` planned normal work, `P3` opportunistic. Priority is a product decision based
  on impact, urgency, confidence, and effort—not a synonym for severity.
- **Severity** describes the magnitude of observed harm. Use the incident scale defined by
  `core-operate-incident-response` for production failures; use blocker/major/minor only when a
  project needs a non-incident defect scale.
- **Risk** describes uncertain future exposure as likelihood multiplied by impact. Record trigger,
  mitigation, contingency, and owner for material risks.

`blocked` always names the dependency or decision preventing progress. `done` means the acceptance
criteria and verification passed, required documentation changed, and the result reached the
work item's declared delivery boundary; “code written” is not done.

## Maintain product language

Use the project `CONTEXT.md` for domain-specific nouns and meanings; this skill owns general
product/project terms. When two artifacts disagree, resolve the contradiction at the owning source
instead of defining a second term. Link artifacts rather than copying requirements between them:

`product brief → PRD → specification/ADR → issue hierarchy → release plan → evidence and metrics`.

On review, flag overloaded terms, unnamed requirements, unmeasurable NFRs, output-based roadmap
items, duplicate issue states, and hierarchy levels that add no decision or ownership value.

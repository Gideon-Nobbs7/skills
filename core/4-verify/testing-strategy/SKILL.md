---
name: core-verify-testing-strategy
description: Use when deciding what a project or feature must test before writing tests—map risks and acceptance criteria to the smallest effective test layer, define test data and quality gates, and explicitly record what is out of scope.
---

# Testing Strategy

The decisions about testing, before any test is written. AI-system verification is different —
see `ai-ml/4-verify/evals`.

## Start from risk, not the pyramid

For each feature, name the externally visible behavior, highest-cost failure, trust boundary,
state transition, and non-functional requirement. Then choose the cheapest layer that can prove
the claim. One behavior should not be repeated at every layer merely to inflate coverage.

## Layer allocation

- **Unit:** deterministic business rules, formatting, parsing, state transitions, and edge cases.
  Fast, numerous, and independent of network, clock, and shared infrastructure.
- **Integration:** database queries, migrations, queues, filesystem, framework wiring, and external
  adapter behavior against a realistic stand-in. Prove boundaries that mocks would lie about.
- **Contract:** public APIs, events, schemas, and component contracts with consumers/producers.
  Use when independent deploys or generated clients could drift.
- **End-to-end:** a small set of critical user journeys through the rendered product. Include auth,
  payment/irreversible actions, and recovery paths where applicable; do not turn every branch into
  a slow browser test.
- **Special proof:** route accessibility to `core-verify-accessibility-audit`, visual rendering to
  `core-verify-ui-and-visual-verification`, performance to performance verification, and model
  behavior to AI evals.

## Policy

- Every acceptance criterion has a named verification method. Critical paths, authorization,
  calculations, migrations, bug regressions, and failure recovery always earn tests.
- Coverage is a signal, not a target to game. Use trend/changed-code thresholds only as a backstop;
  reject tests that execute lines without asserting meaningful behavior.
- Use minimal, explicit fixtures for rules; use representative, privacy-safe data for integration,
  migration, locale, and serialization risks. Factories make intent visible; shared magical data
  does not.
- Do not test framework internals, vendor behavior already contract-tested, private implementation
  details, or trivial markup unless the project owns a regression risk there. Record material
  omissions and the manual/monitoring fallback.

## Working agreement

Write the feature's test seams before implementation, put fast checks closest to the change, and
make CI block on the agreed gates. `core-verify-test-authoring` owns test craft; this skill owns
the decision of which tests exist and why.

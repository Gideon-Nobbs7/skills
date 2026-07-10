---
name: core-verify-test-authoring
description: Use when writing tests or doing TDD — the red→green loop, testing at pre-agreed seams, what makes a good test, mocking only at system boundaries, and the anti-patterns (implementation-coupled, tautological, horizontal slicing).
status: draft
---

# Test Authoring

The craft of the tests themselves, once strategy (`core-verify-testing-strategy`) says they
should exist. Built around test-driven development: the red → green loop, producing tests
worth keeping. Merged and adapted from Matt Pocock's `tdd` (+ tests.md, mocking.md)
([source](https://github.com/mattpocock/skills/tree/main/skills/engineering/tdd)).

## Areas under consideration
- [x] What a good test is — behaviour through public interfaces
- [x] Mocking philosophy — system boundaries only, designing for mockability
- [x] The TDD loop rules and anti-patterns
- [ ] Framework defaults per stack (vitest/jest/pytest/XCTest/…)
- [ ] Structure & naming — describe/it style, arrange-act-assert conventions
- [ ] Fixtures & factories — patterns for test data
- [ ] Flake resistance — no sleeps, deterministic time/random, retry policy
- [ ] Assertion quality — failure messages that diagnose, not just fail

## Skill

### What a good test is

Tests verify behaviour through public interfaces, not implementation details. Code can
change entirely; tests shouldn't. A good test reads like a specification — "user can
checkout with valid cart" says exactly what capability exists — uses the public API only,
survives internal refactors, describes WHAT not HOW, and carries one logical assertion.
Verify through the interface, not a side channel: assert `getUser(id)` returns the created
user, don't query the database table directly.

### Test at pre-agreed seams

A **seam** is the public boundary you test at. Before writing any test, write down the
seams under test and confirm them with the user — no test at an unconfirmed seam. You
can't test everything; agreeing seams up front lands testing effort on critical paths and
complex logic instead of every edge case.

### Rules of the loop

- **Red before green** — write the failing test first, then only enough code to pass it;
  no speculative features or anticipated future tests.
- **One slice at a time** — one seam, one test, one minimal implementation per cycle. Each
  test is a **tracer bullet** responding to what the last cycle taught.
- **Refactoring is not part of the loop** — it belongs to review, not the red→green cycle.
- Match test names and interface vocabulary to the project's domain language; respect ADRs
  in the area.

### Anti-patterns

- **Implementation-coupled** — mocks internal collaborators, tests private methods,
  asserts call counts/order, or verifies through a side channel. The tell: the test breaks
  on refactor when behaviour hasn't changed.
- **Tautological** — the expected value is recomputed the way the code computes it
  (`expect(calculateTotal(items)).toBe(items.reduce(...))`), so it passes by construction.
  Expected values come from an independent source of truth: a known-good literal, a worked
  example, the spec. `expect(calculateTotal([{price:10},{price:5}])).toBe(15)`.
- **Horizontal slicing** — all tests first, then all implementation. Bulk tests verify
  *imagined* behaviour and commit to structure before the implementation is understood.
  Work in vertical slices: one test → one implementation → repeat.

### Mock at system boundaries only

Mock: external APIs (payment, email), time/randomness, sometimes databases and filesystem
(prefer a test DB / local stand-in). Never mock your own classes, internal collaborators,
or anything you control. Design boundaries for mockability:

- **Dependency injection** — pass external dependencies in rather than constructing them
  inside the function.
- **SDK-style interfaces over generic fetchers** — specific functions per external
  operation (`api.getUser`, `api.createOrder`) instead of one generic `api.fetch`: each
  mock returns one shape, no conditional logic in test setup, type safety per endpoint,
  and each test shows which operations it exercises.

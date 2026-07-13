---
name: libraries-design-consumer-api-design
description: Use when designing or evolving a reusable library's public API, types, extension points, errors, defaults, or documentation; extends core contract and architecture rules for code consumed inside other programs.
---

# Library Consumer API Design

Apply `core-build-apis-and-contracts` and `core-build-architecture-in-practice` first. A library's
observable types, imports, behavior, errors, performance, and side effects are its contract.

## Design from consumer tasks

Start with three concrete call-site examples: the common path, an advanced configuration, and a
failure or cleanup path. Design the smallest surface that makes those uses clear. Keep helpers and
implementation types private until multiple real consumers need them.

- Make the common path short and unsurprising; disclose advanced control through options or
  focused submodules.
- Prefer explicit inputs and return values over ambient global state. Avoid work at import time.
- Use names from the consumer's domain and consistent conventions across the surface.
- Make ownership, mutation, lifecycle, concurrency, cancellation, and cleanup behavior explicit.
- Accept interfaces at integration seams and return stable library-owned types where that reduces
  coupling.

## Make types and failures useful

Use types to prevent invalid states without forcing consumers through internal machinery. Preserve
inference for common calls; avoid broad `any`, stringly-typed variants, and exported types tied to
an incidental dependency.

Define a small error model that supports both human diagnosis and programmatic handling. Include
stable codes or classes where callers must branch, preserve underlying causes, and exclude secrets.
Document whether an operation throws, returns a result, retries, mutates, or partially succeeds.

## Design for evolution

Assume every exported symbol and observable behavior will be depended on. Prefer additive options,
new functions, and tolerant inputs. Create extension points only for demonstrated variation; make
them narrow and versionable. Do not expose internals as a shortcut around a missing use case.

## Prove usability

Ship executable examples for first use and common integration, API reference for the public
surface, and migration notes for changes. Test examples as consumers through the public package
entry point. Include contract tests for types, exports, error behavior, and supported runtimes.

## Completion gate

Every public symbol serves a named consumer task, examples compile/run against the packaged
artifact, lifecycle and failure behavior are documented, and future evolution has an additive path.

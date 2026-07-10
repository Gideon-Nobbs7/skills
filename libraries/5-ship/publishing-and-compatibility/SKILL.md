---
name: libraries-ship-publishing-and-compatibility
description: Use when packaging, publishing, versioning, deprecating, or changing compatibility for a reusable library; extends core release rules with package formats, public API compatibility, support matrices, and consumer verification.
status: draft
---

# Library Publishing and Compatibility

Apply `core-ship-release-pipeline` and `core-ship-versioning-and-change-communication` first.
Libraries require stricter compatibility because consumers deploy on their own schedules.

## Define the compatibility surface

Version exported symbols and types, import paths, runtime behavior, errors, defaults, side effects,
serialization, peer requirements, supported runtimes, and documented extension points. A type-only
break can still be a breaking change. Fixing behavior that consumers may rely on requires explicit
risk assessment under Hyrum's Law.

Publish a support matrix and test its minimum and current versions. Keep peer ranges as broad as
verified and direct dependencies as narrow as ownership allows. Drop a platform only with a major
release or the project's documented compatibility policy.

## Package deliberately

- Export only supported entry points through the ecosystem's package metadata. Prevent accidental
  deep imports where tooling allows it.
- Provide only module formats the supported toolchains need, with matching types and source maps.
- Verify tree-shaking or side-effect declarations with a consumer build when claimed.
- Inspect the packed artifact before publication for missing files, unexpected size, credentials,
  development fixtures, and broken paths.

## Release safely

Build from a clean tagged revision, run tests against the packed artifact in representative
consumer projects, attach provenance/checksums when supported, and use a prerelease channel for
uncertain changes. Never overwrite an existing published version.

Deprecate with a reason, replacement, migration example, and planned removal boundary. For a
breaking release, provide a migration guide and codemod when mechanical changes are substantial.
Keep the previous supported line available long enough for the stated policy.

## Completion gate

The packed artifact, public exports, types, install path, consumer examples, support matrix, size,
provenance, changelog, and compatibility classification must be verified before publication.

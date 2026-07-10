---
name: core-ship-release-pipeline
description: Use when building or changing release automation—create one reproducible artifact, promote it through environments with explicit gates, protect credentials and approvals, preserve provenance, and keep rollback possible.
status: draft
---

# Release Pipeline

The `core/1-setup/ci-skeleton` grown into full release automation.

## Release model

Build once from a pinned revision, verify that artifact, and promote the same immutable artifact.
Never rebuild separately for staging and production: different artifacts make a passed stage a
weak signal about what users receive.

1. **Prepare:** tag the revision, resolve locked dependencies, build the artifact, attach version,
   commit, build metadata, checksums, and a software/dependency inventory where the ecosystem
   supports it.
2. **Verify:** run the CI quality gates, security/a11y/performance checks applicable to the change,
   and store test reports with the artifact.
3. **Promote:** deploy that exact artifact to preview or staging, run smoke checks and required
   integration tests, then promote—not rebuild—to production.
4. **Release:** apply the selected rollout plan, watch named metrics, and retain the prior known-
   good artifact plus the rollback instructions.

## Gates and credentials

- Automate low-risk promotion after deterministic checks. Require an explicit accountable approval
  for production, sensitive-data changes, destructive migrations, permission changes, or a risk
  level the project defines as high.
- Release credentials are environment-scoped and short-lived where possible. Jobs can read them
  but never print them; artifacts never contain them.
- A failed gate stops promotion. An exception records the risk, approver, expiry, and compensating
  verification—there is no permanent "skip release checks" switch.

## Compatibility and recovery

- Coordinate schema changes with expand/contract migration stages. A release may not require old
  and new application versions to make incompatible assumptions about data.
- Pin retention for release artifacts, reports, and deployment metadata long enough to diagnose and
  roll back. Prune only by a documented policy.
- Test the rollback path and confirm the previous artifact can still deploy before a risky release.

`core-setup-ci-skeleton` owns PR quality gates; this skill owns artifact promotion. Use
`core-ship-deployment-strategies` for flags, rollout percentages, and migration mechanics; platform
overlays add store or hosting mechanics without replacing this pipeline.

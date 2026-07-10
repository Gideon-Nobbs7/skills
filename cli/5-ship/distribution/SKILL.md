---
name: cli-ship-distribution
description: Use when packaging, signing, publishing, installing, updating, or supporting a CLI across operating systems and package managers; extends core release and versioning rules with command-line distribution mechanics.
status: draft
---

# CLI Distribution

Apply `core-ship-release-pipeline` and `core-ship-versioning-and-change-communication` first. This
skill governs how the verified CLI artifact reaches user machines.

## Choose distribution channels

Publish through the ecosystem's expected package manager when it preserves a reliable install and
update path. Add standalone binaries or OS package managers only for named audience or runtime
needs. Define the supported operating systems, architectures, shells, runtime versions, and the
policy for dropping them.

Build once per target from the tagged revision, attach version and commit metadata, produce
checksums, and sign artifacts where the channel supports it. Generate package-manager manifests
from those immutable artifacts rather than rebuilding downstream.

## Protect the install and update path

- Keep installation user-scoped by default and avoid unexpected elevated privileges.
- Verify downloaded artifacts before execution. Publish provenance and dependency inventory when
  supported.
- Prefer package-manager updates for package-managed installs. If self-update exists, verify its
  signature, use atomic replacement, preserve the prior binary, and provide rollback.
- Keep configuration and user data compatible across upgrades. Migrate explicitly and back up
  before destructive changes.

## Release compatibility

Treat command names, flags, defaults, output formats, exit statuses, config keys, environment
variables, and side effects as versioned interfaces. Deprecate before removal, warn on the affected
invocation, provide the replacement, and announce the removal version. Test install, upgrade, and
uninstall from every supported channel in clean environments.

## Telemetry and network behavior

Document every network call. Keep telemetry absent unless the product has an explicit, privacy-
reviewed policy; when used, disclose fields and purpose, minimize data, avoid command arguments and
paths, honor opt-out, and never block the command on telemetry delivery.

## Completion gate

Release only when artifacts are reproducible and verifiable, clean install and upgrade tests pass
on the support matrix, rollback is possible, compatibility changes are communicated, and install,
update, telemetry, and uninstall behavior are documented.

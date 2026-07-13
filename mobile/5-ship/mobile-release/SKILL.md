---
name: mobile-ship-mobile-release
description: Use when preparing, signing, beta testing, submitting, reviewing, staging, monitoring, rolling back, or updating iOS and Android apps through TestFlight, App Store Connect, Google Play, EAS Build/Submit/Update, or native release pipelines.
---

# Mobile Release

Apply core release pipeline, deployment, versioning, launch, security, accessibility, and incident
rules first. Stores add signing identities, immutable version/build numbers, review policy,
platform metadata, delayed adoption, and limited rollback.

## Prepare a releasable artifact

Build from a tagged locked revision through the release pipeline; keep signing keys, certificates,
profiles, service credentials, and App Store/Play API keys in scoped secret storage with ownership,
expiry, rotation, and recovery. Never place signing material in the repository or app bundle.

Version the user-facing release and monotonically increment platform build numbers. Verify production
configuration, entitlements/permissions, privacy manifests and disclosures, export/compliance data,
deep/universal links, push, purchases, background modes, symbols/source maps, and supported OS/device
matrix on the signed artifact—not a debug build.

## Progress through evidence channels

Use internal/device distribution first, then TestFlight/Play internal or closed testing, then store
review and staged/phased production rollout. Name testers and scenarios, collect structured feedback,
and promote the exact verified artifact where platform mechanics allow. Define rollout observation
windows, owner, success signals, and halt criteria from the product's baseline rather than universal
crash-rate numbers.

Store listings must match product behavior: localized name/copy, screenshots, accessibility and
privacy information, age/content ratings, support/privacy URLs, review notes, test accounts, and
clear explanations for sensitive permissions or background use.

## Treat OTA as a release, not an escape hatch

Use OTA only for changes compatible with the installed native runtime and store/platform policy.
Bind updates to explicit runtime versions and channels, run the normal verification gates, stage
rollout, monitor adoption/crashes/launch failures, and retain rollback. Native code, entitlements,
permissions, SDK changes, or incompatible schemas require a store binary.

## Local source routing

- Store builds/submission/metadata: `references/upstream-eas-app-stores/`.
- OTA health: `references/upstream-eas-update-insights/`.
- EAS pipelines: `references/upstream-eas-workflows/`.
- Launch/interaction metrics: `references/upstream-eas-observe/`.
- Development distribution: `references/upstream-expo-dev-client/`.

Load these only for Expo/EAS work; native pipelines follow the same release contract with native
tools.

## Production gate

Release only when signed beta evidence, store policy/metadata, privacy and accessibility checks,
device/OS coverage, migration and offline behavior, crash/ANR/hang/launch/performance baselines,
staged rollout, monitoring, support ownership, rollback/deactivation, and incident response are
ready. After rollout, preserve the artifact, store submission record, symbols, release evidence,
and active-version adoption data.

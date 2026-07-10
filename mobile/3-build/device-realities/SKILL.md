---
name: mobile-build-device-realities
description: Use when implementing mobile offline behavior, local persistence and sync, permissions, background work, notifications, deep links, app clips, native modules, battery-sensitive work, device storage, or interrupted lifecycle behavior.
status: draft
---

# Mobile Device Realities

Apply core state/data, security, performance, APIs/contracts, and accessibility first. Assume
networks disappear, processes die, permissions change, storage fills, clocks shift, notifications
arrive late, and the app resumes with stale state.

## Design offline and lifecycle behavior

Classify every important task as offline-capable, read-only stale, queued, or unavailable with a
clear explanation. Persist durable commands before presenting them as queued; attach identity,
idempotency, ordering, expiry, retry, conflict, and dead-letter behavior. Reconcile on foreground
and connectivity return without duplicating effects.

Persist the minimum state needed for restoration and validate/migrate it on launch. Treat app
backgrounding or process death as possible after any await. Save user work incrementally and keep
server authority, device cache, secure credentials, and ephemeral UI state distinct.

## Request capabilities in context

Ask for permission only when the user invokes a feature that needs it, explain value before the
system prompt where useful, and handle deny, restricted, provisional, one-time, and later-revoked
states. Provide a settings route only when it helps recovery. The app's core experience should not
require unrelated permissions.

Minimize background tasks, location, sensors, wakeups, network transfer, and polling. Use platform
schedulers and push/event triggers, declare constraints, make work resumable/idempotent, and expose
last successful sync where freshness matters.

## Treat notifications and links as external input

Notifications require meaningful opt-in, user-controlled categories/quiet behavior, minimal
sensitive lock-screen content, stable deep links, and server-side authorization when opened. Do not
use notification permission as an onboarding gate.

Validate universal/app links, custom schemes, deferred links, shortcuts, widgets, and App Clips as
untrusted routes. Define behavior for signed-out users, missing content, expired campaigns, and
unsupported app versions.

## Local source routing

- Expo networking/offline mechanics: `references/upstream-expo-data-fetching/`.
- Expo native module boundaries: `references/upstream-expo-module/`.
- App Clip mechanics: `references/upstream-expo-app-clip/`.

## Completion gate

Test airplane mode, slow/flapping networks, duplicate delivery, process death, background/foreground,
permission denial/revocation, storage pressure, clock change, notification states, every link entry,
version migration, battery-sensitive work, conflict recovery, and account/tenant isolation.

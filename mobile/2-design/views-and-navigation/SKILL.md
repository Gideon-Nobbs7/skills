---
name: mobile-design-views-and-navigation
description: Use when designing or implementing mobile screen composition, stacks, tabs, modals, sheets, back behavior, deep-linked routes, lists, safe areas, keyboards, or adaptive phone, tablet, foldable, and multi-window layouts.
status: draft
---

# Mobile Views and Navigation

Apply core UX, design engineering, state/data, accessibility, and performance rules. Navigation is
a user-visible state machine: every destination has identity, entry conditions, back behavior,
restoration, deep-link behavior, and accessibility focus behavior.

## Compose with native containers

Use stacks for hierarchical drill-down, tabs for persistent peer destinations, sheets/modals for
bounded tasks, and full-screen presentation only when the task truly replaces context. Preserve the
platform's back gesture/button and provide visible dismissal when gestures are undiscoverable.
Avoid nested navigators that create ambiguous ownership or duplicate headers.

Make routes typed and deep-linkable where product value requires it. Validate external link input,
handle unauthenticated and missing-resource states, and restore the intended destination after the
required gate. Persist only navigation state that remains valid across app versions.

## Build resilient screens

Respect safe areas and system bars without padding every child independently. Keep primary content
scrollable when text grows, handle keyboards without hiding the focused field or action, and retain
useful state across rotation, resize, backgrounding, and restoration. Prefer native controls and
containers for built-in interaction and accessibility.

Use virtualized/recycling lists for unbounded data, stable identities, bounded item work, explicit
empty/loading/error/refresh states, predictable pagination, and appropriately sized images. Measure
before adding memoization or custom recycling behavior.

## Adapt by available space

Change composition from window/container class and content pressure, not device names. A wider
layout may become split-view, multi-column, or inspector-based while preserving task order and
route identity. Do not stretch a phone layout across a tablet or assume orientation is fixed.

For Expo Router details, read `references/upstream-expo-router/`. Native SwiftUI navigation details
live under `mobile-setup-platform-standards/references/upstream-swiftui-pro/`.

## Completion gate

Verify cold launch and restoration, every deep link, back/dismiss behavior, tab/stack state,
authentication gates, keyboard, safe areas, large text, screen-reader focus, empty/error/offline
states, large lists, rotation, resizing, tablet/foldable layouts, and interrupted transitions.

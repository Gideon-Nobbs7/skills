---
name: mobile-design-motion-and-gestures
description: Use when designing or implementing mobile animations, transitions, direct-manipulation gestures, gesture conflicts, springs, scroll-linked effects, haptics, or reduced-motion behavior in Expo, React Native, SwiftUI, UIKit, Compose, or Android Views.
status: draft
---

# Mobile Motion and Gestures

Use the same language and intent rules as `core-design-animation-vocabulary`,
`core-design-fluid-interactions`, and `core-design-design-engineering`. Mobile adds native gesture,
thread, haptic, and system-navigation mechanics; it does not redefine timing or motion purpose.

## Translate the shared motion contract

Specify trigger, property, start/end state, duration or spring character, interruption, cancellation,
reduced-motion alternative, and completion effect using core vocabulary. Prefer platform-native
transitions and springs when they already communicate hierarchy and continuity. Custom motion must
earn its cognitive or interaction value.

Direct manipulation follows the finger with no perceptible lag, remains interruptible, and uses
velocity plus position to settle. Define thresholds, rubber-banding, cancellation, and restoration.
Coordinate competing gestures explicitly; never steal system back/home, scrolling, assistive-
technology, or text-selection gestures. Always provide a visible non-gesture route to the action.

## Keep motion on the right execution path

Animate compositor/UI-thread-friendly properties and measure frame pacing on representative low-end
hardware and high-refresh devices. Avoid per-frame bridge/state updates, layout-heavy animation, or
unbounded work tied to scroll. Preserve interaction during transition and make cancellation leave a
valid state.

Use haptics to confirm a meaningful state transition, boundary, selection, success, warning, or
failure—not every tap. Prefer native controls' built-in feedback and avoid duplicate haptics. Match
intensity to consequence and respect platform/user settings.

## Respect accessibility settings

Honor Reduce Motion and analogous system settings. Replace large spatial movement, parallax,
zooming, and looping effects with short fades or immediate state changes while keeping meaning.
Avoid flashing and motion that cannot be paused. Motion is never the sole status indicator.

## Local source routing

- Expo/Reanimated mechanics: `references/upstream-expo-animations.md`.
- Expo haptics/media mechanics: `references/upstream-expo-media-haptics.md`.
- SwiftUI mechanics: `references/upstream-swiftui-views.md`,
  `references/upstream-swiftui-api.md`, and `references/upstream-swiftui-accessibility.md`.

## Completion gate

Use `core-verify-motion-review`, then test interruption, rapid repetition, gesture conflict, system
back, scrolling, screen reader, switch/keyboard input where supported, Reduce Motion, backgrounding,
low-end devices, and 60/120 Hz frame pacing.

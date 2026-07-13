---
name: mobile-build-mobile-a11y-and-localization
description: Use when implementing or auditing VoiceOver, TalkBack, Switch Control, Voice Control, Dynamic Type or font scaling, mobile focus and semantics, system accessibility settings, app language, locale formatting, plurals, RTL, or localized mobile assets in Expo, React Native, SwiftUI, UIKit, Compose, or Android Views.
---

# Mobile Accessibility and Localization

Apply core accessibility, content/localization, and localization implementation first. This overlay
owns native semantics, assistive-technology behavior, device settings, and resource mechanics. For
detailed audit patterns, read `references/upstream-community-access-mobile-accessibility.md`; for
SwiftUI specifics read the two `upstream-swiftui-*` references.

## Build the native accessibility tree

Prefer native interactive controls. For custom controls, expose a concise name, correct role/trait,
current value/state, hint only when purpose is not evident, and equivalent accessibility actions.
Hide decorative or duplicate nodes and group children only when the combined announcement remains
understandable. Keep visual order, reading order, and focus order aligned.

Move accessibility focus when navigation, modal presentation, deletion, or async replacement changes
context; preserve it when content merely updates. Announce important status without interrupting
routine work. Every gesture has a simple tappable or assistive action and every target meets the
platform's comfortable touch-size convention.

Support Dynamic Type/font scaling, bold text, increased contrast, differentiate-without-color,
Reduce Motion, Reduce Transparency where applicable, screen magnification, switch/keyboard access,
Voice Control, and orientation/window resizing. Avoid fixed text containers and truncation of
essential content.

## Localize through platform resources

Keep user-visible strings out of code, compose messages through placeholders and plural/select
rules rather than concatenation, and format dates, times, numbers, currencies, units, names, and
sorting through locale-aware APIs. Preserve the user's explicit in-app language choice where the
platform supports it and define fallback for incomplete locales.

Use logical leading/trailing layout and allow platform mirroring for RTL. Preserve the direction of
intrinsically directional media/icons and isolate mixed-direction identifiers. Localize permissions,
notifications, widgets, shortcuts, store metadata, privacy text, images containing language, and
accessibility labels—not only in-app screens.

## Verify on real assistive paths

Automated linting catches missing properties, not usability. Test iOS with VoiceOver and relevant
Apple accessibility settings; test Android with TalkBack and relevant system settings; use physical
devices for representative journeys. Verify focus, rotor/actions, announcements, touch exploration,
hardware input, large text, screen zoom, and interruption.

## Completion gate

Run the core accessibility audit plus pseudolocalization, longest translations, plural categories,
locale switching, RTL, mixed-direction text, device/app locale mismatch, calendar/time-zone changes,
localized notifications/assets/store copy, and assistive-technology journeys on both platforms.

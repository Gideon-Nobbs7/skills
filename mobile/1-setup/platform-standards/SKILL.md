---
name: mobile-setup-platform-standards
description: Use when choosing native iOS, native Android, React Native, or Expo; setting minimum OS and device support; structuring a mobile project; or deciding where platform conventions and platform-specific behavior should differ.
---

# Mobile Platform Standards

Apply core scoping and architecture selection first. Mobile code shares product behavior where that
reduces inconsistency, but each platform keeps native navigation, controls, accessibility,
permissions, typography, feedback, and lifecycle expectations.

## Choose the implementation path

- Choose native SwiftUI/UIKit or Kotlin/Compose when deep platform integration, platform-first UX,
  newest APIs, specialized performance, or separate platform ownership dominates.
- Choose React Native/Expo when shared product logic and team capacity dominate and the required
  native capabilities have maintained modules or can justify small native extensions.
- Prefer Expo for a new React Native product unless unsupported native integration, build control,
  or brownfield constraints provide evidence against it. Treat Expo development builds—not Expo
  Go—as the realistic environment once custom native code enters.

Record required capabilities, native dependencies, release process, offline/background behavior,
performance risks, team skills, ownership, and exit/migration cost. Prototype the highest-risk
native integration before committing.

## Establish platform contracts

Set the minimum OS versions from active-user/device evidence, security support, required APIs, test
capacity, and accessibility—not merely framework defaults. Define supported phone, tablet,
orientation, window-size, and foldable classes where applicable.

Keep domain, data, and contract logic independent of screens and framework adapters. Isolate
permissions, storage, notifications, deep links, background work, purchases, and native modules
behind application-owned interfaces. Use platform files/components when behavior genuinely differs;
avoid runtime conditionals scattered through shared UI.

## Respect native convention

Use Apple Human Interface Guidelines and Material/platform conventions for standard navigation,
controls, gestures, destructive actions, system bars, and settings. Brand may shape tokens and
content, but it does not erase learned platform behavior. Document any deliberate divergence with
user benefit, accessibility impact, and test evidence.

## Local source routing

- Expo native interface guidance: `references/upstream-expo-native-ui/` and
  `references/upstream-expo-ui/`.
- Native SwiftUI review guidance: `references/upstream-swiftui-pro/`.

Load only the relevant stack reference. These are local snapshots; do not fetch them at runtime.

## Completion gate

The architecture record names stack, native boundaries, supported platforms/devices, minimum OS,
project structure, platform divergence policy, risky prototypes, accessibility implications,
release ownership, and migration triggers.

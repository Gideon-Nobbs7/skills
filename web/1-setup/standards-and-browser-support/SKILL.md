---
name: web-setup-standards-and-browser-support
description: Use when establishing a web project's browser support, progressive enhancement, platform-feature, polyfill, JavaScript, or compatibility policy; extends core stack selection with browser-runtime constraints.
status: draft
---

# Web Standards and Browser Support

Apply `core-setup-scoping-and-requirements` and `core-setup-stack-and-architecture-selection` first.
Choose browser policy from the audience and product risk, not a fashionable version count.

## Establish the support contract

Use traffic evidence, target markets, device constraints, accessibility needs, enterprise policy,
and dependency support to name tested browsers and versions. If evidence is unavailable, adopt a
documented current interoperability baseline and verify the product's critical journeys on major
engines. Record review cadence and criteria for adding or dropping support.

Classify behavior as:

- **Core:** content and essential actions must remain available on every supported browser.
- **Enhanced:** richer interaction may depend on newer capability while preserving the core task.
- **Unsupported:** show a clear, safe explanation rather than a broken or misleading interface.

## Prefer the platform

Use semantic HTML and stable browser primitives before libraries or custom emulation. Select
libraries when they provide meaningful product behavior, consistency, or maintenance value—not
merely syntax around a platform feature.

Detect capabilities, not browser identities. Use CSS feature queries and runtime feature checks
where fallback is possible. Add a polyfill only when the feature is required for a supported
journey, the payload and security cost are acceptable, and it can be conditionally delivered.

## Define the JavaScript floor

Decide which tasks work before client JavaScript, during slow loading, and after script failure.
Content, navigation, and server-backed forms should use native behavior when the product permits;
enhance from there. Do not claim no-JavaScript support when authentication or product architecture
makes it false—state the actual resilience target.

## Completion gate

Document the support matrix, core journeys, enhancement boundaries, feature-detection and polyfill
policy, JavaScript-failure behavior, test environments, and review date. CI/device testing must
exercise the declared contract rather than an incidental developer browser.

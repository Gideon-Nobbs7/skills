---
name: web-build-web-accessibility
description: Use when implementing browser accessibility with semantic HTML, ARIA, focus, keyboard behavior, live updates, routing, forms, or accessible names; extends the core accessibility implementation with web-platform mechanics.
status: draft
---

# Web Accessibility Implementation

Apply `core-foundations-accessibility-baseline` and
`core-build-accessibility-implementation` first. This skill supplies browser mechanics; WCAG and
the core user-needs baseline remain authoritative.

## Build the semantic document

Use native elements with their built-in name, role, state, keyboard, and form behavior. Add ARIA
only when semantics are absent, keep it synchronized with behavior, and validate the resulting
accessibility tree. Structure pages with a unique main region, appropriate landmarks, descriptive
titles, logical headings, language metadata, and a skip path to primary content.

Every control has an accessible name that matches its visible purpose. Associate form labels,
instructions, requirements, and errors programmatically. Group related fields and preserve native
autocomplete, input purpose, and validation where useful.

## Manage focus and interaction

Use native tab order; reserve `tabindex="0"` for custom interactive elements and `-1` for
programmatic focus. Never use positive tabindex. Keep focus visible, unobscured, and restored or
moved only when the interaction changes context and the destination is predictable.

Implement established keyboard patterns for composite widgets rather than inventing navigation.
Dialogs trap focus while open, expose name/description, close predictably, and return focus to a
logical trigger. Pointer gestures always have a simple alternative.

## Handle dynamic applications

On client-side navigation, update the document title and move focus or announce the new view using
a consistent routing policy. Announce important asynchronous status without repeating or
interrupting excessively. Preserve meaningful content and focus during loading, errors, optimistic
updates, and refreshes.

## Completion gate

Run `core-verify-accessibility-audit`, including keyboard-only use, multiple viewport/zoom states,
automated checks, accessibility-tree inspection, and representative screen-reader journeys. Test
the actual rendered state after hydration and interaction, not only static markup.

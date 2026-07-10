---
name: web-build-web-localization
description: Use when implementing web locale routing, language negotiation, translation loading, RTL layout, localized metadata, alternate URLs, or locale switching; extends core localization implementation with browser and discovery mechanics.
status: draft
---

# Web Localization

Apply `core-design-content-and-localization` and
`core-build-localization-implementation` first. This overlay owns URL, document, layout, and search
mechanics for localized web experiences.

## Make locale explicit and stable

Prefer locale-specific URLs when localized pages are indexable or shareable. Select locale from an
explicit URL or saved user choice before language negotiation; use browser language only as an
initial hint. Do not repeatedly redirect users away from a locale they chose. Define a stable
fallback for unsupported or incomplete locales.

Set document language and direction from resolved content. Load translation resources by locale and
route without flashing another language. Keep locale in cache keys, server data formatting, client
hydration, validation, and analytics dimensions where it changes behavior.

## Support bidirectionality

Use logical CSS properties and direction-aware layout primitives. Mirror spatial navigation and
directional icons when meaning reverses; preserve icons and content whose meaning is intrinsically
fixed. Isolate mixed-direction user content and identifiers with appropriate bidi semantics.

## Support discovery and switching

Give each localized page its localized title, description, structured data, canonical URL, and
reciprocal language alternates. Generate sitemaps consistently with the route strategy. A locale
switch keeps the user on the equivalent resource when available, preserves relevant state, and
clearly falls back when no translation exists.

## Completion gate

Verify direct navigation, saved preference, negotiation, switching, fallback, cache separation,
hydration, RTL, mixed-direction content, long translations, localized metadata, canonical URLs,
alternates, and sitemap entries for representative locales.

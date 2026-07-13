---
name: core-build-localization-implementation
description: "Implement internationalization and localization in code: string externalization, ICU messages, CLDR plural rules, locale detection, fallback chains, RTL plumbing, localized formatting, translation files, namespace loading, hreflang, pseudolocalization, and missing-key checks."
---

# Localization Implementation

Build localization as application infrastructure. The design skill decides what must adapt; this skill makes the runtime, source code, and release workflow support it.

## Choose The Runtime Shape

- Use URL locale segments when SEO, shareability, or server rendering matters: `/en/products`, `/de/products`.
- Use persisted user preference for app surfaces where URL locale is not desirable; sync authenticated preferences across devices when appropriate.
- Use `Accept-Language` or device locale as a fallback signal, not the only source of truth.
- Define a deterministic fallback chain for every locale. Missing content must fail visibly in development and degrade predictably in production.
- Choose a library based on project constraints:
  - Prefer compile-time, typed message functions when bundle size and key safety matter.
  - Prefer established runtime ecosystems when incrementally localizing an existing app.

## Externalize Strings Correctly

- Move all user-facing text into translation resources, including placeholders, ARIA labels, validation messages, emails, notifications, and server-rendered errors.
- Keep messages complete. Do not concatenate translated fragments into sentences.
- Use namespaces by feature, route, or domain so translation bundles can lazy-load.
- Use stable semantic keys. Avoid keys based on English copy that will churn during editing.
- Keep rich text interpolation constrained to known placeholders and audited markup.

## Use ICU And Platform Formatters

- Use ICU plural/select/selectordinal patterns for counts, roles, gendered language, and grammatical alternatives.
- Use CLDR plural categories, not `count === 1` logic.
- Format dates, numbers, currency, lists, relative time, percentages, and units with locale-aware APIs such as `Intl.*`.
- Pass locale and currency/unit intent explicitly through API and rendering boundaries.
- Never hand-build date, number, or currency strings.

## Wire RTL And Locale State Through The App

- Set `<html lang>` and `dir` from the active locale, including server-rendered entry points.
- Use CSS logical properties: `margin-inline-start`, `padding-inline-end`, `inset-inline`, `text-align: start`.
- Mirror directional icons and flows intentionally; do not mirror symbols whose meaning is not directional.
- Store active locale in one authoritative place and make locale changes invalidate or refresh every formatter, cache key, route label, and server request that depends on it.

## Translation Workflow And QA

- Add missing-key detection, unused-key checks, and translation file schema validation to CI.
- Add pseudolocalization for development and visual QA.
- Test with real translated copy before release, including German-like expansion, short CJK strings, and RTL.
- Verify localized SEO with `hreflang` alternates and `x-default` when pages are indexable.
- Include native-speaker or domain review for legal, medical, financial, safety, billing, and culturally sensitive copy.

## References

- Read `references/upstream-oakoss-localization-engineer/` for detailed i18n architecture, ICU, Paraglide, and i18next patterns.
- Read `references/upstream-mindrally-localization-l10n.md` for regional adaptation, QA, and platform examples.

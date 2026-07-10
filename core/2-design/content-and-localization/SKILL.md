---
name: core-design-content-and-localization
description: Design product copy and localization-ready interfaces before implementation. Use when defining tone, labels, errors, empty states, locale scope, regional variants, text expansion, RTL behavior, culturally appropriate content, format requirements, or translation-ready UI layouts.
status: draft
---

# Content & Localization Readiness

Treat words as interface structure, not decoration. Design the product so translation, regional formats, and culture-specific content can be added without breaking layout or meaning.

## Design The Content System

- Define the product voice for high-frequency surfaces: buttons, labels, errors, confirmations, empty states, onboarding, settings, and legal or billing text.
- Write copy in complete translatable units. Do not design sentence fragments that must be concatenated in code.
- Give every message a job: explain state, ask for a decision, confirm an outcome, or guide recovery.
- Keep placeholders meaningful and bounded. A translator should know what `{count}`, `{name}`, or `{plan}` represents and whether it can change grammar.
- Separate stable product terminology from marketing language. Glossaries and reserved terms belong with requirements, not ad hoc component copy.

## Decide Localization Scope Early

- Identify required locales, regional variants, scripts, currencies, units, address formats, phone formats, calendars, time zones, legal requirements, and fallback locale.
- Prefer explicit locale variants when behavior changes: `en-US` vs `en-GB`, `es-ES` vs `es-MX`, `pt-BR` vs `pt-PT`.
- Define fallback chains before design signoff, for example `es-MX -> es -> en`.
- Decide which content is translated, transcreated, regionally replaced, or intentionally invariant.
- Flag imagery, examples, colors, idioms, jokes, legal text, and payment language for cultural review.

## Design Layouts That Survive Translation

- Budget at least 30-50% text expansion from English unless the target language set proves otherwise.
- Avoid fixed-width text containers, text embedded in images, and layouts where label length controls critical alignment.
- Test early with pseudolocalized copy, long German-like strings, short CJK strings, and mixed-direction text.
- Use flexible wrapping, intrinsic sizing, and content-aware truncation. Never hide important legal, pricing, error, or action text behind truncation.
- Specify where UI may wrap, where it must resize, and where content must move to a secondary line.

## Plan Direction, Scripts, And Typography

- Treat RTL as a layout mode, not a translation afterthought. Specify mirrored navigation, icon direction, text alignment, and start/end spacing behavior.
- Use logical language in specs: start/end, inline/block, previous/next, before/after.
- Confirm fonts support every target script, weight, numeral style, and symbol needed by the locale set.
- For CJK, Arabic, Indic, or mixed-script products, design with real sample text before locking density or component height.

## Handoff To Implementation

- Provide locale list, fallback rules, route or preference behavior, translation namespace candidates, format requirements, and QA examples.
- Include at least one representative string per copy pattern: plural, variable interpolation, gender or role variant, rich text link, error, empty state, and date/number/currency format.
- Route implementation work to `core-build-localization-implementation`.

## References

- Read `references/upstream-mindrally-localization-l10n.md` when you need regional localization examples, cultural adaptation checks, or locale QA coverage.

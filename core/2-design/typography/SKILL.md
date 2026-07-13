---
name: core-design-typography
description: "Design readable, professional typography for interfaces and content: typeface choice, pairing, hierarchy, type scale, line length, line height, spacing, responsive text, font licensing, multilingual glyph coverage, typographic correctness, and typography audits."
---

# Typography

Typography is part of the product's voice and usability. Start with reading comfort and information hierarchy; then add personality only where it earns its place.

## Start With Body Text

- Set body text before headings. Choose font, size, line height, and measure first; calibrate every other text style against it.
- Use at least 16px equivalent for ordinary web body text; prefer 17-18px for reading-heavy mobile or long-form content.
- Keep readable prose around 45-75 characters per line, with roughly 65ch as a strong default.
- Use body line height around 1.4-1.7 for sustained reading. Dense UI text can be tighter, but must remain scannable.
- Test real content, not placeholder text. Product names, numbers, code, legal copy, and translated strings expose different typography failures.

## Choose Typefaces By Job

- Pick typefaces for purpose, not novelty. A dashboard, legal product, children's app, and editorial page should not sound the same.
- Use one or two font families unless there is a clear product reason for more.
- For long-lived UI text, prioritize x-height, open counters, distinct ambiguous glyphs (`I/l/1`, `O/0`), weight range, and screen rendering.
- Confirm licensing before implementation. Desktop or print licenses do not automatically allow web embedding.
- Confirm glyph coverage for every planned locale, script, currency symbol, punctuation mark, and weight.

## Build Hierarchy With Restraint

- Use size, weight, and color deliberately. Change one or two levers between adjacent hierarchy levels, not all three by default.
- Keep heading levels semantically ordered and visually consistent.
- Use all caps only for short labels; add letter spacing around `0.05em` to `0.12em`.
- Use tabular figures for tables, metrics, timers, balances, and aligned numeric comparisons.
- Avoid underlining except for links, where underline styling should be intentional and readable.

## Preserve Typographic Correctness

- Use real punctuation where the medium supports it: curly quotes, apostrophes, en dashes for ranges, em dashes for sentence breaks, ellipsis character, multiplication sign, and proper copyright/trademark symbols.
- Do not use straight quotes as apostrophes in polished visible UI text unless the context requires plain ASCII.
- Use nonbreaking spaces for units, honorifics, section references, figure references, and values that should stay together.
- Do not hide important information through tiny type, low contrast, or intentionally weak hierarchy.

## Make Type Responsive And Localized

- Use fluid sizing with bounded minimum and maximum values; do not scale every text style purely with viewport width.
- Keep measure constraints independent of viewport width so wide screens do not create unreadable lines.
- Budget for text expansion and different script metrics before locking component heights.
- Prefer font loading strategies that keep text visible and stable; avoid invisible text during font load.
- Keep font payloads lean through WOFF2, subsetting, variable fonts, and limited weights, but never drop glyphs required by supported languages.

## Audit Checklist

- Body text is readable at actual device sizes and 200% zoom.
- Prose has a measure cap and enough line height.
- Hierarchy remains clear when squinting.
- Font fallbacks are defined and visually compatible.
- Font files, weights, and subsets match the supported locales.
- Visible copy uses professional punctuation and spacing.
- Data-heavy UI uses numeric features appropriate to comparison.

## References

- Read `references/upstream-wondelai-web-typography/` for web typography evaluation, pairing, responsive formulas, and CSS implementation patterns.
- Read `references/upstream-bencium-ui-typography.md`, `references/upstream-bencium-css-templates.md`, and `references/upstream-bencium-html-entities.md` when auditing punctuation, spacing, entities, and typographic correctness.

---
name: web-design-web-typography
description: Use when implementing web font loading, fallback metrics, responsive type, variable fonts, OpenType features, or typography performance; extends core typography with browser-specific mechanics.
---

# Web Typography

Apply `core-design-typography` first for hierarchy, readability, and token decisions. This overlay
owns how that system loads and renders in browsers.

## Build a resilient font stack

Define system fallbacks for every family and verify that content remains readable before custom
fonts load or when they fail. Prefer self-hosting when privacy, reliability, licensing, and caching
make it appropriate. Use modern compressed formats, subset only for known language coverage, and
avoid downloading unused weights or styles.

Choose `font-display` from product behavior: make text promptly readable, then control swap impact.
Preload only a critical, immediately used font file; excess preloads compete with page resources.
Use metric overrides or compatible fallbacks when font swapping causes measurable layout shift.

## Translate tokens to fluid behavior

Use `rem` for user-scalable type and unitless line height where appropriate. Apply bounded
`clamp()` scales only when continuous change improves hierarchy; keep minimums readable and test
zoom. Let containers and content drive wrapping rather than shrinking text to preserve a layout.

Use variable-font axes only when they replace required static files or create an intentional design
behavior. Request valid axis ranges and test rendering across supported engines. Enable OpenType
features by semantic need—for example tabular numerals in data—not as global decoration.

## Completion gate

Verify first render, slow loading, blocked fonts, fallback swap, layout shift, language coverage,
bold/italic synthesis, variable axes, zoom, and representative browser rendering. Font choices must
meet the web performance budget and the core readability standard simultaneously.

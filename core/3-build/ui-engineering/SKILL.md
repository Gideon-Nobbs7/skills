---
name: core-build-ui-engineering
description: Use when turning settled interface designs into production components—component boundaries and APIs, composition, token consumption, styling, accessible states, motion implementation, and reuse without premature abstraction.
---

# UI Engineering

Turning the design skills (§2) into components — the engineering side of interface work.

## Build components around responsibility

- Keep a component local until it has repeated, stable behavior or a product-level concept to
  protect. Extract for a real seam, not because two elements look alike today.
- Give public components a small, semantic API. Prefer composition, children/slots, and explicit
  variants over boolean-prop accumulation and generic `config` objects.
- Separate data ownership from presentation. `core-build-state-and-data` owns data fetching,
  caching, forms, and state placement; this skill owns the component boundary that renders them.
- Wrap third-party primitives behind a project-owned API when they become product infrastructure;
  retain native semantics and expose only the options the product intends to support.

## Implementation rules

- Consume semantic tokens for color, type, spacing, radius, elevation, focus, and motion. Do not
  introduce raw values or a competing styling system inside a feature.
- Follow the repo's chosen styling approach. Add a new styling library only when the current one
  cannot meet a named requirement and the architectural trade-off is recorded.
- Implement every component state deliberately: default, hover/focus/active where relevant,
  disabled, loading, empty, success, and error. The flow skill decides which states exist; this
  skill makes their rendering coherent and accessible.
- Start from native or accessible primitives. Accessible name, keyboard behavior, focus, errors,
  and reduced-motion behavior are part of the component contract, not final polish.
- Implement motion from the design specification; preserve interaction responsiveness and reduced
  motion. Do not invent decorative motion while building.

## Review before extraction

Ask: does this API explain a stable user concept? Can a caller achieve the intended variants
without flags that conflict? Does composition keep visual and accessibility structure visible?
Would changing the implementation leave callers untouched? If not, keep the component smaller or
redesign the boundary.

Use `core-design-design-engineering` for visual and motion choices, `core-build-accessibility-implementation`
for detailed control mechanics, `core-verify-ui-and-visual-verification` for rendered proof, and
`core-verify-test-authoring` for behavior tests.

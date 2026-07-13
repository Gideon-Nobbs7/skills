---
name: core-build-accessibility-implementation
description: "Use when implementing accessibility in code: semantics, accessible names, focus management, keyboard behavior, dynamic announcements, forms, media, reduced motion, pointer alternatives, and robust custom controls."
---

# Accessibility Implementation

Meet `core-foundations-accessibility-baseline` in code. Platform mechanics live in
`web-build-web-accessibility` and `mobile-build-mobile-a11y-and-localization`; this skill owns the
shared implementation rules.

Source: W3C WAI Accessibility Principles
<https://www.w3.org/WAI/fundamentals/accessibility-principles/>

## Build order

1. Start semantic: use the platform's native control, role, element, or accessibility API before
   creating a custom widget.
2. Name every control and meaningful object. The visible label, accessible name, and voice-command
   target should match whenever possible.
3. Make the full task keyboard-operable before styling polish. Keyboard access is a behavior, not
   a QA afterthought.
4. Add focus management for every view change, modal/dialog, disclosure, toast, async update, and
   error path.
5. Verify assistive-technology interpretation at the component boundary before composing the
   component into larger flows.

## Implementation rules

### Semantics and names

- Use native controls for buttons, links, inputs, selects, tables, lists, headings, and dialogs.
- Add custom roles only when native semantics cannot express the interaction.
- Custom controls expose name, role, value, state, disabled/expanded/selected/pressed status, and
  the expected keyboard model.
- Decorative media is hidden from assistive technology; meaningful media has an equivalent text
  alternative or description.

### Focus and keyboard

- Preserve logical focus order. Visual order and keyboard order should agree unless there is a
  documented reason.
- Move focus intentionally after route changes, modal open/close, destructive confirmations, and
  validation failures.
- Trap focus only inside true modal contexts, and always provide an obvious escape.
- Support expected keys for the pattern in use. Do not invent keyboard behavior for standard
  widgets.

### Forms and errors

- Every field has a programmatic label. Placeholder text is not a label.
- Required, disabled, invalid, helper, and error states are exposed programmatically.
- Error messages identify the field, explain the problem, and give the next corrective action.
- Preserve user input across validation failures, timeouts, and re-authentication.

### Dynamic content

- Async results, status changes, loading completion, and non-modal feedback are announced without
  stealing focus.
- Significant context changes require user action or a clear warning.
- Loading, empty, success, and error states each remain perceivable and operable.

### Motion, media, and time

- Respect reduced-motion preferences. Replace nonessential travel, parallax, large scale, and
  looping animation with simpler feedback.
- Avoid flashing patterns and rapid visual changes that can cause physical reactions.
- Users can pause, stop, hide, extend, or recover from moving content, auto-advance, time limits,
  and session expiry unless the limit is essential.
- Captions, transcripts, audio description, or equivalent media alternatives are included when the
  content carries information.

### Pointer, touch, and gestures

- Pointer-only gestures have button/menu/keyboard alternatives.
- Drag, swipe, pinch, device motion, and fine-motor interactions have lower-dexterity paths.
- Targets are large enough for reliable activation and have spacing that prevents accidental taps.
- Destructive or high-cost accidental activation has undo, review, confirmation, or delayed commit.

## Completion check

Before handoff, verify the primary task using keyboard only, zoom/text resizing, reduced motion,
visible focus, screen-reader/accessibility-tree inspection where available, and error recovery.
Then load `core-verify-accessibility-audit` for the formal gate.

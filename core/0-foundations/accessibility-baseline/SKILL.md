---
name: core-foundations-accessibility-baseline
description: Always-on accessibility baseline for every user-facing artifact and interface. Use to enforce perceivable, operable, understandable, and robust access before design, build, platform overlays, or verification add specifics.
status: draft
---

# Accessibility Baseline

Accessibility is a foundation, not a feature. Every interface starts from the W3C WAI
principles: perceivable, operable, understandable, and robust.

Source: W3C WAI Accessibility Principles
<https://www.w3.org/WAI/fundamentals/accessibility-principles/>

## Non-negotiable standard

Use current WCAG AA as the default target unless a project sets a stronger standard. Do not treat
this skill as the complete checklist; use it as the floor that every design and build task must
preserve, then load phase/platform skills for details.

Never defer an accessibility issue that blocks a core task, hides information from assistive
technology, traps focus, removes keyboard access, relies on color alone, prevents text resizing,
causes unsafe motion/flashing, or prevents form completion.

## Baseline gates

### Perceivable

- Provide text alternatives for non-text content: icons, controls, images, charts, files, audio,
  video, and embedded applications need a meaningful accessible name or description.
- Prefer real text over images of text. If visual text is unavoidable, provide an equivalent.
- Preserve information when presentation changes: headings, lists, tables, fields, order, and
  relationships are represented structurally, not only through layout or styling.
- Make content distinguishable: color is never the only signal; default foreground/background
  contrast is sufficient; text can resize and reflow without losing information or controls.
- Provide alternatives for media: captions, transcripts, audio description, or another equivalent
  path appropriate to the content.

### Operable

- Every task available by pointer is available by keyboard or another non-pointer path.
- Focus is visible, ordered meaningfully, and never trapped. Repeated content has a bypass route
  when it would slow keyboard users.
- Users have enough time. Time limits, auto-advance, moving content, interruptions, and session
  expiry must be stoppable, extendable, recoverable, or truly essential.
- Avoid flashing and unsafe motion. Provide reduced-motion behavior for nonessential animation.
- Navigation makes location and action clear: page/view titles, headings, link purpose, current
  location, and next steps are understandable without visual guessing.
- Gestures, device motion, drag, and fine pointer actions have alternatives that require less
  dexterity. Touch targets are large enough for reliable activation and accidental activation is
  recoverable.

### Understandable

- Use clear, task-oriented language. Define unusual terms when the user must understand them to
  proceed.
- Identify language when content may be read aloud or processed by assistive technology.
- Keep repeated navigation, labels, and component behavior predictable. Significant context
  changes do not happen without the user's action or consent.
- Help users avoid and correct mistakes: instructions, validation, error messages, correction
  suggestions, review steps, and undo/reversal exist where the cost of error is meaningful.

### Robust

- Prefer native semantics and platform controls. Custom controls must expose the same name, role,
  value, state, and interaction model as the control they replace.
- Use valid, well-structured markup or platform accessibility APIs so current and future assistive
  technologies can interpret the interface reliably.
- Treat third-party widgets and generated content as untrusted until their accessible names,
  keyboard behavior, and assistive-technology output are verified.

## Phase handoff

- Design work loads this skill before `core-design-*` so layout, color, motion, and content do not
  create barriers.
- Build work loads `core-build-accessibility-implementation` for semantics, focus, forms, dynamic
  content, and custom controls.
- Verification loads `core-verify-accessibility-audit` when proving the result.
- Web and mobile overlays may add platform mechanics, but they do not restate or weaken this
  baseline.

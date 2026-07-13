---
name: core-verify-accessibility-audit
description: Use before shipping any user-facing change to prove accessibility through automated checks plus manual keyboard, assistive-technology, contrast, resize/reflow, reduced-motion, and error-recovery passes; record blockers and evidence.
---

# Accessibility Audit

Verifying the baseline and implementation skills actually held.

## Audit order

1. Name the critical journeys and states under review: first use, success, loading, empty,
   validation failure, permission denial, timeout, and recovery.
2. Run automation early, but treat it as a regression net—not evidence that a journey works.
3. Perform the manual checks below on the actual rendered interface.
4. Record findings with the affected journey, barrier, severity, owner, and retest evidence.
5. Fix blocking barriers before ship; rerun the exact failed journey after each fix.

## Automated gate

- Run the stack's static accessibility checks and an axe-class browser scan on changed views.
- Put deterministic violations in CI as blocking checks. A suppression needs a reason, owner,
  expiry, and an equivalent manual verification; never suppress a real barrier to make CI green.
- Inspect the accessibility tree for custom controls and dynamic regions. Automation cannot judge
  whether a label is meaningful, focus order makes sense, or an announcement is useful.

## Manual proof

### Keyboard and focus

- Complete every critical journey without a pointer. Tab order follows the task; focus remains
  visible; no focus trap exists outside a true modal; Escape and close/return behavior work.
- Check menus, dialogs, disclosures, comboboxes, drag alternatives, validation failures, route or
  view changes, and repeated-navigation bypasses—not just the happy-path form.

### Assistive technology

- Test the primary journey with an available screen reader or platform accessibility inspector.
  Verify names, roles, values, states, headings, landmarks, field errors, and dynamic updates.
- A pass means a person can understand the task, operate the controls, receive errors/status, and
  recover without relying on visual position, color, or pointer-only behavior.

### Visual and preference resilience

- Check default, hover/focus/active/disabled/error states for contrast and for information not
  conveyed by color alone.
- Resize text and reflow the interface at the project's supported viewport or device settings;
  controls, content, and error recovery remain available without two-dimensional hunting.
- Enable reduced motion and confirm nonessential movement is removed without hiding state change.

## Severity and exit rule

- **Block ship:** a critical task cannot be completed, focus is trapped/lost, a control is unnamed
  or inoperable, information is unavailable to assistive technology, or motion can cause harm.
- **Fix before broad rollout:** a major journey is materially slower, confusing, or unreliable for
  keyboard, zoom, or assistive-technology users.
- **File with an owner:** isolated polish issues with a clear workaround and no loss of task access.

The audit produces evidence, not a vague "a11y checked" claim: commands/results, journeys tested,
manual environment, known exceptions, and retest status. Use
`core-build-accessibility-implementation` for remediation and platform overlays only for platform
mechanics.

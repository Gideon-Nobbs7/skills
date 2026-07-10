# Upstream Sources

This file records externally derived skills and the revision they were assessed against. Do not
overwrite local guidance during an update: fetch the upstream source, compare the listed paths,
then deliberately port changes that still fit the godfile's phase and one-home rules.

## Emil Kowalski — design-engineering skills

- Repository: <https://github.com/emilkowalski/skills>
- Assessed revision: [`f76beceb7d3fc8c43309cefad5a095a206103a4e`](https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e)
- License: MIT (copyright Emil Kowalski, 2026); retain attribution when porting substantial text.

| Godfile skill | Upstream path | Placement rationale |
| --- | --- | --- |
| `core-design-design-engineering` | `skills/emil-design-eng/SKILL.md` | Shared UI craft and motion decisions belong in Design. |
| `core-design-fluid-interactions` | `skills/apple-design/SKILL.md` | Gesture, sheet, drag, and interruptible-motion behavior belongs in Design. |
| `core-design-animation-vocabulary` | `skills/animation-vocabulary/SKILL.md` | A naming/reference aid for specifying motion during Design. |
| `core-verify-motion-review` | `skills/review-animations/SKILL.md`, `STANDARDS.md` | A strict motion-specific review belongs in Verify. |

### Update procedure

1. Fetch the upstream repository and inspect changes since the assessed revision for the mapped
   path(s).
2. Preserve local metadata, routing, and cross-references; port only guidance that belongs in the
   mapped phase.
3. Update the revision above and the `Upstream` line in every affected skill in the same change.
4. Review the result against the rest of the godfile, especially accessibility and performance
   standards, before marking it ready.

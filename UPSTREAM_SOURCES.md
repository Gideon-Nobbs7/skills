# Upstream Sources

This file records every external skill author or tool source whose work was adapted into the
godfile and the revision imported. The usable source content is stored locally in each skill's
`references/` folder, so normal skill use does not require loading GitHub. During an update: fetch
the upstream source, compare the listed paths against the local imported references, then
deliberately port changes that still fit the godfile's phase and one-home rules.

## Emil Kowalski — design-engineering skills

- Repository: <https://github.com/emilkowalski/skills>
- Assessed revision: [`f76beceb7d3fc8c43309cefad5a095a206103a4e`](https://github.com/emilkowalski/skills/tree/f76beceb7d3fc8c43309cefad5a095a206103a4e)
- Local license copy: [`licenses/emilkowalski-skills-MIT.txt`](licenses/emilkowalski-skills-MIT.txt)
- License: MIT (copyright Emil Kowalski, 2026); retain attribution when porting substantial text.

| Godfile skill | Local imported source | Upstream path | Placement rationale |
| --- | --- | --- | --- |
| `core-design-design-engineering` | `core/2-design/design-engineering/references/upstream-emil-design-eng.md` | `skills/emil-design-eng/SKILL.md` | Shared UI craft and motion decisions belong in Design. |
| `core-design-fluid-interactions` | `core/2-design/fluid-interactions/references/upstream-apple-design.md` | `skills/apple-design/SKILL.md` | Gesture, sheet, drag, and interruptible-motion behavior belongs in Design. |
| `core-design-animation-vocabulary` | `core/2-design/animation-vocabulary/references/upstream-animation-vocabulary.md` | `skills/animation-vocabulary/SKILL.md` | A naming/reference aid for specifying motion during Design. |
| `core-verify-motion-review` | `core/4-verify/motion-review/references/upstream-review-animations.md`, `core/4-verify/motion-review/references/upstream-motion-standards.md` | `skills/review-animations/SKILL.md`, `STANDARDS.md` | A strict motion-specific review belongs in Verify. |

## Matt Pocock — engineering and collaborative-writing skills

- Repository: <https://github.com/mattpocock/skills>
- Assessed revision: [`391a2701dd948f94f56a39f7533f8eea9a859c87`](https://github.com/mattpocock/skills/tree/391a2701dd948f94f56a39f7533f8eea9a859c87)
- Local license copy: [`licenses/mattpocock-skills-MIT.txt`](licenses/mattpocock-skills-MIT.txt)
- License: MIT (copyright Matt Pocock, 2026); retain attribution when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-foundations-writing-skills` | `core/0-foundations/writing-skills/references/upstream-mattpocock-writing-great-skills.md` | `skills/productivity/writing-great-skills/SKILL.md` | Meta guidance for authoring godfile skills belongs in Foundations. |
| `core-setup-scoping-and-requirements` | `core/1-setup/scoping-and-requirements/references/upstream-mattpocock-domain-modeling.md` | `skills/engineering/domain-modeling/SKILL.md` | Shared project language belongs in Setup. |
| `core-setup-planning-and-work-breakdown` | `core/1-setup/planning-and-work-breakdown/references/upstream-mattpocock-{grilling,to-spec,to-tickets,wayfinder,triage,handoff}.md` | `skills/productivity/grilling/SKILL.md`, `skills/engineering/{to-spec,to-tickets,wayfinder,triage}/SKILL.md`, `skills/productivity/handoff/SKILL.md` | Refinement, specs, tickets, triage, and handoff are one planning workflow. |
| `core-setup-repo-and-tooling-bootstrap` | `core/1-setup/repo-and-tooling-bootstrap/references/upstream-mattpocock-{setup-pre-commit,git-guardrails}.md` | `skills/misc/{setup-pre-commit,git-guardrails-claude-code}/SKILL.md` | Repository guardrails belong at setup. |
| `core-design-ux-and-flows` | `core/2-design/ux-and-flows/references/upstream-mattpocock-prototype.md` | `skills/engineering/prototype/SKILL.md` | Prototypes answer design questions in Design. |
| `core-build-architecture-in-practice` | `core/3-build/architecture-in-practice/references/upstream-mattpocock-{codebase-design,implement,design-an-interface}.md` | `skills/engineering/{codebase-design,implement}/SKILL.md`, `skills/deprecated/design-an-interface/SKILL.md` | Module/interface work belongs while building. |
| `core-verify-test-authoring` | `core/4-verify/test-authoring/references/upstream-mattpocock-tdd.md` | `skills/engineering/tdd/SKILL.md` | Test-writing discipline belongs in Verify. |
| `core-verify-code-review` | `core/4-verify/code-review/references/upstream-mattpocock-code-review.md` | `skills/engineering/code-review/SKILL.md` | Review mechanics belong in Verify. |
| `core-operate-maintenance` | `core/6-operate/maintenance/references/upstream-mattpocock-{diagnosing-bugs,improve-codebase-architecture}.md` | `skills/engineering/{diagnosing-bugs,improve-codebase-architecture}/SKILL.md` | Diagnosis and architecture improvement belong after shipping. |
| `blogs-build-voice-and-participation` | `blogs/3-build/voice-and-participation/references/upstream-mattpocock-{writing-fragments,writing-beats,writing-shape,edit-article}.md` | `skills/in-progress/{writing-fragments,writing-beats,writing-shape}/SKILL.md`, `skills/personal/edit-article/SKILL.md` | User-led blog drafting belongs in the blog Build phase. |

## Addy Osmani — product engineering skills

- Repository: <https://github.com/addyosmani/agent-skills>
- Assessed revision: [`6bcfeb9dae52b11eaad23511acc165109746dbc3`](https://github.com/addyosmani/agent-skills/tree/6bcfeb9dae52b11eaad23511acc165109746dbc3)
- Local license copy: [`licenses/addyosmani-agent-skills-MIT.txt`](licenses/addyosmani-agent-skills-MIT.txt)
- License: MIT (copyright Addy Osmani, 2025); retain attribution when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-foundations-engineering-principles` | `core/0-foundations/engineering-principles/references/upstream-addyosmani-source-driven-development.md` | `skills/source-driven-development/SKILL.md` | Source-grounded work is an always-on engineering value. |
| `core-setup-planning-and-work-breakdown` | `core/1-setup/planning-and-work-breakdown/references/upstream-addyosmani-{idea-refine,spec-driven-development,planning-and-task-breakdown}.md` | `skills/{idea-refine,spec-driven-development,planning-and-task-breakdown}/SKILL.md` | Complements the planning workflow with refinement and gated implementation. |
| `core-setup-repo-and-tooling-bootstrap` | `core/1-setup/repo-and-tooling-bootstrap/references/upstream-addyosmani-git-workflow-and-versioning.md` | `skills/git-workflow-and-versioning/SKILL.md` | Day-to-day Git workflow belongs at setup. |
| `core-setup-ci-skeleton` | `core/1-setup/ci-skeleton/references/upstream-addyosmani-ci-cd-and-automation.md` | `skills/ci-cd-and-automation/SKILL.md` | Continuous quality gates belong at setup. |
| `core-build-apis-and-contracts` | `core/3-build/apis-and-contracts/references/upstream-addyosmani-api-and-interface-design.md` | `skills/api-and-interface-design/SKILL.md` | Contract design belongs in Build. |
| `core-build-secure-coding` | `core/3-build/secure-coding/references/upstream-addyosmani-security-and-hardening.md` | `skills/security-and-hardening/SKILL.md` | Concrete controls belong at the keyboard. |
| `core-build-ui-engineering` | `core/3-build/ui-engineering/references/upstream-addyosmani-frontend-ui-engineering.md` | `skills/frontend-ui-engineering/SKILL.md` | Cross-stack UI implementation rules belong in Build. |
| `core-verify-code-review` | `core/4-verify/code-review/references/upstream-addyosmani-doubt-driven-development.md` | `skills/doubt-driven-development/SKILL.md` | Adversarial decision review belongs in Verify. |
| `core-verify-ui-and-visual-verification` | `core/4-verify/ui-and-visual-verification/references/upstream-addyosmani-browser-testing-with-devtools.md` | `skills/browser-testing-with-devtools/SKILL.md` | Browser-based UI proof belongs in Verify. |
| `core-ship-launch-checklist` | `core/5-ship/launch-checklist/references/upstream-addyosmani-shipping-and-launch.md` | `skills/shipping-and-launch/SKILL.md` | Final launch gate belongs in Ship. |
| `core-ship-versioning-and-change-communication` | `core/5-ship/versioning-and-change-communication/references/upstream-addyosmani-git-workflow-and-versioning.md` | `skills/git-workflow-and-versioning/SKILL.md` | Consumer-facing versioning belongs in Ship. |
| `core-ship-deployment-strategies` | `core/5-ship/deployment-strategies/references/upstream-addyosmani-{shipping-and-launch,deprecation-and-migration}.md` | `skills/{shipping-and-launch,deprecation-and-migration}/SKILL.md` | Controlled rollout and compatible migrations belong in Ship. |
| `core-operate-sunsetting` | `core/6-operate/sunsetting/references/upstream-addyosmani-deprecation-and-migration.md` | `skills/deprecation-and-migration/SKILL.md` | Removal and migration belong in Operate. |
| `core-operate-observability` | `core/6-operate/observability/references/upstream-addyosmani-observability-and-instrumentation.md` | `skills/observability-and-instrumentation/SKILL.md` | Instrumentation belongs in Operate. |

## Vercel — React composition patterns

- Repository: <https://github.com/vercel-labs/agent-skills>
- Assessed revision: [`f8a72b9603728bb92a217a879b7e62e43ad76c81`](https://github.com/vercel-labs/agent-skills/tree/f8a72b9603728bb92a217a879b7e62e43ad76c81)
- License: MIT as declared in the imported `SKILL.md` metadata; the repository had no root
  `LICENSE` file at this revision.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-build-ui-engineering` | `core/3-build/ui-engineering/references/upstream-vercel-composition-patterns/` | `skills/composition-patterns/` | React-specific composition material informs the shared component-boundary rules without becoming a separate React skill. |

## Seth Hobson — design systems and secrets management

- Repository: <https://github.com/wshobson/agents>
- Assessed revision: [`d7cf7dca8c4c7d0635e284f77204daa85552bfa4`](https://github.com/wshobson/agents/tree/d7cf7dca8c4c7d0635e284f77204daa85552bfa4)
- Local license copy: [`licenses/wshobson-agents-MIT.txt`](licenses/wshobson-agents-MIT.txt)
- License: MIT (copyright Seth Hobson, 2024); retain attribution when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-setup-design-system-bootstrap` | `core/1-setup/design-system-bootstrap/references/upstream-wshobson-design-system-patterns/` | `plugins/ui-design/skills/design-system-patterns/` | Token hierarchy, themes, and component foundations belong in Setup. |
| `core-setup-env-and-secrets` | `core/1-setup/env-and-secrets/references/upstream-wshobson-secrets-management.md` | `plugins/cicd-automation/skills/secrets-management/SKILL.md` | Secret delivery and rotation belong in Setup. |

## Benji Taylor — Agentation visual feedback tool

- Repository: <https://github.com/benjitaylor/agentation>
- Assessed revision: [`8158a97c10c37e577b0a6e2d3175d143918216cd`](https://github.com/benjitaylor/agentation/tree/8158a97c10c37e577b0a6e2d3175d143918216cd)
- Local license copy: [`licenses/agentation-PolyForm-Shield-1.0.0.txt`](licenses/agentation-PolyForm-Shield-1.0.0.txt)
- License: PolyForm Shield 1.0.0 (copyright Benji Taylor, 2026). Its restrictions apply; this is
  an optional internal-use integration, not a bundled runtime dependency.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-verify-ui-and-visual-verification` | `core/4-verify/ui-and-visual-verification/references/upstream-agentation-README.md` | `README.md` | Visual annotations become structured, inspectable context during UI verification. |

## OakOSS — localization engineering

- Repository: <https://github.com/oakoss/agent-skills>
- Assessed revision: [`0283bed313563d5677a0838f4bf921b03296cf6c`](https://github.com/oakoss/agent-skills/tree/0283bed313563d5677a0838f4bf921b03296cf6c)
- License: imported skill metadata declares MIT; repository package metadata declares ISC and no root
  `LICENSE` file was present in the shallow snapshot. Re-check licensing before broad redistribution.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-build-localization-implementation` | `core/3-build/localization-implementation/references/upstream-oakoss-localization-engineer/` | `skills/localization-engineer/` | ICU, CLDR, locale routing, RTL, Paraglide, and i18next implementation details belong in Build. |

## Mindrally — localization l10n

- Repository: <https://github.com/mindrally/skills>
- Assessed revision: [`05a71308897983093248d719a2ffa1bca61d0768`](https://github.com/mindrally/skills/tree/05a71308897983093248d719a2ffa1bca61d0768)
- Local license copy: [`licenses/mindrally-skills-LICENSE.txt`](licenses/mindrally-skills-LICENSE.txt)
- License: Apache License 2.0; retain attribution and notices when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-design-content-and-localization` | `core/2-design/content-and-localization/references/upstream-mindrally-localization-l10n.md` | `localization-l10n/SKILL.md` | Regional variants, cultural adaptation, layout expansion, and l10n QA affect design readiness. |
| `core-build-localization-implementation` | `core/3-build/localization-implementation/references/upstream-mindrally-localization-l10n.md` | `localization-l10n/SKILL.md` | Translation files, locale formatting, detection, API integration, and QA also inform implementation. |

## WondELAI — web typography

- Repository: <https://github.com/wondelai/skills>
- Assessed revision: [`326b3801223ad277ae7082ff85435ba1d36e1903`](https://github.com/wondelai/skills/tree/326b3801223ad277ae7082ff85435ba1d36e1903)
- Local license copy: [`licenses/wondelai-skills-LICENSE.txt`](licenses/wondelai-skills-LICENSE.txt)
- License: MIT (copyright Wondel.ai sp. z o.o., 2025); retain attribution when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-design-typography` | `core/2-design/typography/references/upstream-wondelai-web-typography/` | `web-typography/` | Readability, typeface selection, pairing, hierarchy, responsive type, and font performance belong in the core typography foundation. |

## Bencium — UI typography

- Repository: <https://github.com/bencium/bencium-marketplace>
- Assessed revision: [`9db32365ca5755a6ca9b5ff8d88ff384ca47b015`](https://github.com/bencium/bencium-marketplace/tree/9db32365ca5755a6ca9b5ff8d88ff384ca47b015)
- License: no root license or skill-level license metadata was found in the shallow snapshot. Re-check
  licensing before broad redistribution.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `core-design-typography` | `core/2-design/typography/references/upstream-bencium-ui-typography.md`, `core/2-design/typography/references/upstream-bencium-css-templates.md`, `core/2-design/typography/references/upstream-bencium-html-entities.md` | `typography/skills/typography/SKILL.md`, `typography/skills/typography/css-templates.md`, `typography/skills/typography/html-entities.md` | Typographic correctness, punctuation, spacing, entities, and CSS baselines strengthen the core typography rules. |

## IBM — AI agent building guidance

- Documentary source: <https://www.ibm.com/think/topics/how-to-build-an-ai-agent>
- Author: Dave Bergmann
- Assessed: 2026-07-10
- Local snapshot: attributed paraphrase notes; no runtime fetching and no substantial source text
  republished.

| Godfile skill | Local source notes | Placement rationale |
| --- | --- | --- |
| `ai-ml-build-llm-app-architecture` | `ai-ml/3-build/llm-app-architecture/references/source-notes-agent-building-guides.md` | Purpose, users, tools, knowledge, model fit, measurement, and framework/platform choice shape the LLM architecture. |

## OpenAI — practical agent-building guide

- Documentary source: <https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/>
- Author: OpenAI
- Assessed: 2026-07-10
- Local snapshot: attributed paraphrase notes; no runtime fetching and no substantial source text
  republished.

| Godfile skill | Local source notes | Placement rationale |
| --- | --- | --- |
| `ai-ml-build-llm-app-architecture` | `ai-ml/3-build/llm-app-architecture/references/source-notes-agent-building-guides.md` | Model, tool, instruction, orchestration, layered-guardrail, and human-intervention guidance belongs in LLM application architecture. |

## Anthropic — effective agent patterns

- Documentary source: <https://www.anthropic.com/engineering/building-effective-agents>
- Author: Anthropic
- Published: 2024-12-19; assessed: 2026-07-10
- Local snapshot: attributed paraphrase notes; no runtime fetching and no substantial source text
  republished.

| Godfile skill | Local source notes | Placement rationale |
| --- | --- | --- |
| `ai-ml-build-llm-app-architecture` | `ai-ml/3-build/llm-app-architecture/references/source-notes-agent-building-guides.md` | The workflow-versus-agent distinction and progressive orchestration patterns govern architectural complexity. |

## JetBrains — agentic framework comparison

- Documentary source: <https://blog.jetbrains.com/pycharm/2026/06/top-agentic-frameworks-for-building-applications-2026/>
- Author: Evgenia Verbina
- Published: 2026-06; assessed: 2026-07-10
- Local snapshot: attributed paraphrase notes; no runtime fetching and no substantial source text
  republished.

| Godfile skill | Local source notes | Placement rationale |
| --- | --- | --- |
| `ai-ml-build-llm-app-architecture` | `ai-ml/3-build/llm-app-architecture/references/source-notes-agent-building-guides.md` | Framework categories inform a project-specific trade study without becoming permanent framework defaults. |

## Microsoft ISE — ML and AI Engineering Fundamentals Playbook

- Documentary source: <https://microsoft.github.io/code-with-engineering-playbook/ml-and-ai-projects/>
- Author: Microsoft Industry Solutions Engineering
- Source pages reported update: 2025-02-07; assessed: 2026-07-10
- Local snapshot: attributed paraphrase notes; no runtime fetching and no substantial source text
  republished.

| Godfile skill | Local source notes | Placement rationale |
| --- | --- | --- |
| `ai-ml-build-ml-data-pipelines` | `ai-ml/3-build/ml-data-pipelines/references/source-notes-microsoft-ml-playbook.md` | Envisioning, feasibility, reproducible experimentation, pipeline engineering, and production readiness span the ML data lifecycle. |
| `ai-ml-build-ai-security` | same local notes, referenced by skill name | Responsible-AI impact review is a security and safety constraint throughout the lifecycle. |
| `ai-ml-verify-evals` | same local notes, referenced through the pipeline skill | Stakeholder-aligned metrics, baselines, tested evaluation code, and error analysis inform verification. |
| `ai-ml-operate-model-monitoring` | same local notes, referenced through the pipeline skill | Production ground truth, data/output monitoring, drift, ownership, and retraining belong in operations. |

## Expo — official Expo and EAS skills

- Repository: <https://github.com/expo/skills>
- Assessed revision: [`b2fdce752bbf8f3ba83883d8a35c642e229c8812`](https://github.com/expo/skills/tree/b2fdce752bbf8f3ba83883d8a35c642e229c8812)
- Local license copy: [`licenses/expo-skills-MIT.txt`](licenses/expo-skills-MIT.txt)
- License: MIT (copyright 650 Industries, Inc. / Expo); retain attribution when porting
  substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `mobile-setup-platform-standards` | `mobile/1-setup/platform-standards/references/upstream-expo-{native-ui,ui}/` | `plugins/expo/skills/{expo-native-ui,expo-ui}/` | Expo-native controls, platform UI, and native UI bindings inform the cross-platform/native boundary. |
| `mobile-design-views-and-navigation` | `mobile/2-design/views-and-navigation/references/upstream-expo-router/` | `plugins/expo/skills/expo-router/` | Route, stack, tab, modal, and native transition mechanics belong in mobile navigation. |
| `mobile-design-motion-and-gestures` | `mobile/2-design/motion-and-gestures/references/upstream-expo-{animations,media-haptics}.md` | selected references from `plugins/expo/skills/expo-native-ui/` | Reanimated, gesture-handler, and haptic mechanics implement the shared motion language on Expo. |
| `mobile-build-device-realities` | `mobile/3-build/device-realities/references/upstream-expo-{data-fetching,module,app-clip}/` | `plugins/expo/skills/{expo-data-fetching,expo-module,expo-app-clip}/` | Offline/networking, native modules, and App Clips are device-specific implementation concerns. |
| `mobile-ship-mobile-release` | `mobile/5-ship/mobile-release/references/upstream-{eas-app-stores,eas-update-insights,eas-workflows,eas-observe,expo-dev-client}/` | matching directories under `plugins/expo/skills/` | Store submission, beta distribution, OTA health, workflows, and launch metrics implement mobile release mechanics. |

## Paul Hudson — SwiftUI Pro

- Repository: <https://github.com/twostraws/swiftui-agent-skill>
- Assessed revision: [`be297ff80dddec529af1f9b1f1f114aab6c9d11c`](https://github.com/twostraws/swiftui-agent-skill/tree/be297ff80dddec529af1f9b1f1f114aab6c9d11c)
- Local license copy: [`licenses/swiftui-agent-skill-MIT.txt`](licenses/swiftui-agent-skill-MIT.txt)
- License: MIT (copyright Paul Hudson, 2026); retain attribution when porting substantial text.

| Godfile skill | Local imported source(s) | Upstream path(s) | Placement rationale |
| --- | --- | --- | --- |
| `mobile-setup-platform-standards` | `mobile/1-setup/platform-standards/references/upstream-swiftui-pro/` | `swiftui-pro/` | Native SwiftUI API, view, navigation, data, performance, design, and accessibility guidance informs the Apple implementation path. |
| `mobile-design-motion-and-gestures` | selected `upstream-swiftui-*.md` files | `swiftui-pro/references/{views,api,accessibility}.md` | SwiftUI animation, haptics, and Reduce Motion mechanics implement the shared mobile motion contract. |
| `mobile-build-mobile-a11y-and-localization` | selected `upstream-swiftui-*.md` files | `swiftui-pro/references/{accessibility,swift}.md` | VoiceOver, Dynamic Type, Reduce Motion, and locale-aware Swift behavior belong in the mobile accessibility/localization overlay. |

## Community Access — mobile accessibility

- Repository: <https://github.com/Community-Access/accessibility-agents>
- Assessed revision: [`0872b4a7763145fc0e5847d8357fb446a857c683`](https://github.com/Community-Access/accessibility-agents/tree/0872b4a7763145fc0e5847d8357fb446a857c683)
- Local license copy: [`licenses/community-access-accessibility-agents-LICENSE.txt`](licenses/community-access-accessibility-agents-LICENSE.txt)
- License: MIT; project built by and for the blind and low-vision community. Retain attribution
  when porting substantial text.

| Godfile skill | Local imported source | Upstream path | Placement rationale |
| --- | --- | --- | --- |
| `mobile-build-mobile-a11y-and-localization` | `mobile/3-build/mobile-a11y-and-localization/references/upstream-community-access-mobile-accessibility.md` | `codex-skills/mobile-accessibility/SKILL.md` | React Native, Expo, SwiftUI/UIKit, Compose, and Android Views accessibility audit mechanics belong in the mobile build overlay. |

## You — state and data foundation

- Local source: `core/3-build/state-and-data/references/state-data-fetching-offline-input-reference.md`
- Source note: provided by you as a local attachment for the godfile.

| Godfile skill | Local imported source | Placement rationale |
| --- | --- | --- |
| `core-build-state-and-data` | `core/3-build/state-and-data/references/state-data-fetching-offline-input-reference.md` | State taxonomy, fetching, caching, offline sync, conflict handling, and forms belong in Build. |

## You — original godfile direction

Every skill not listed in an external-skill table above is tagged as **from you**: it is your
original direction, structure, and/or requested foundation. It has no external skill upstream to
snapshot. Standards and documentary sources used to support it remain cited in the relevant
skill; they are evidence, not attributed skill authors.

### Update procedure

1. Fetch the matching upstream repository and inspect changes since that author's assessed
   revision for the mapped path(s).
2. Diff each changed upstream path against its local imported source file.
3. Preserve local metadata, routing, and cross-references; port only guidance that belongs in the
   mapped phase.
4. Update the local imported source file, the adapted skill entrypoint, and that author's revision
   above in the same change.
5. Review the result against the rest of the godfile, especially accessibility and performance
   standards, before marking it ready.

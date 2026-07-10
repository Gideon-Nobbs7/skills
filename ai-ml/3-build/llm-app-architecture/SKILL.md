---
name: ai-ml-build-llm-app-architecture
description: Where model calls sit in a system — structured outputs, streaming, retries/fallbacks, human-in-the-loop. (stub — awaiting content)
status: stub
---

# LLM Application Architecture

Treating the model call as a system component with failure modes, not magic.

## Areas under consideration
- [ ] Placement — where model calls sit (server-side always?), isolation from core logic
- [ ] Structured outputs — schema-constrained generation, validation of model output
- [ ] Streaming — when required for UX, how it flows through the stack
- [ ] Failure handling — timeouts, retries, fallback models, degraded modes
- [ ] Human-in-the-loop points — where a person confirms before effects happen
- [ ] Nondeterminism management — temperature policy, idempotency of AI features

## Skill
_(awaiting intake — will be written as directives an agent can follow)_

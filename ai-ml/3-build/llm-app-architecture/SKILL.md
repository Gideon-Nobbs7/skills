---
name: ai-ml-build-llm-app-architecture
description: Use when designing an LLM application, deciding whether it needs a direct call, deterministic workflow, agent, multi-agent system, or framework, and defining model boundaries, state, structured output, streaming, failure handling, and human control.
---

# LLM Application Architecture

Apply core architecture, contracts, state/data, security, performance, and observability first.
Read [`references/source-notes-agent-building-guides.md`](references/source-notes-agent-building-guides.md)
when evaluating agent complexity or frameworks.

## Earn each layer of complexity

Use this progression and stop at the first level that meets the eval and product target:

1. Deterministic software or search.
2. One model call with validated structured output.
3. Retrieval, memory, or tools around one call.
4. A code-orchestrated workflow: chaining, routing, parallel work, or evaluator-optimizer.
5. One agent choosing tools in a bounded loop.
6. Multiple agents only when context separation, parallel specialization, or ownership boundaries
   measurably outperform one agent with tools.

Use a framework only when its durable execution, state, tracing, checkpoint, provider, or governance
capabilities save more complexity than its abstraction adds. Prototype the critical path without
framework-specific domain logic and record an exit strategy.

## Isolate the model boundary

Keep provider calls behind an application-owned interface. Version model configuration, prompts,
tools, schemas, retrieval policy, and guardrails as one behavioral release. Validate every model
output before application use; treat free text as presentation, never authority. Keep deterministic
business rules, authorization, money, identity, and irreversible state transitions in code.

Define request identity, timeout, cancellation, retry classification, token/turn/tool budgets,
idempotency, and degraded behavior. Retry transient provider failures with bounded backoff; do not
retry a completed side effect. Stream only when partial output improves the experience and can be
cancelled, moderated, and safely abandoned.

## Control state and effects

Separate conversation history, working state, durable memory, retrieved evidence, and audit state.
Persist only what has a product purpose, retention rule, tenant boundary, and deletion path. Give
every tool a risk rating. Require human confirmation for consequential, high-value, externally
communicative, destructive, irreversible, or low-confidence actions; escalate on repeated failure
or ambiguity.

## Completion gate

The architecture record must show why AI and the selected autonomy level are necessary, the eval
baseline that earned them, model/tool/data trust boundaries, state ownership, limits, human gates,
failure and rollback behavior, cost/latency budgets, and production signals.

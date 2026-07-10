---
name: ai-ml-build-agents-and-tools
description: Use when implementing agent loops, tool definitions, handoffs, manager-worker or multi-agent orchestration, context transfer, memory, MCP integrations, stopping conditions, and human checkpoints after agentic complexity has been justified.
status: draft
---

# Agents and Tools

First use `ai-ml-build-llm-app-architecture` to justify agency and orchestration. Apply
`ai-ml-build-ai-security` to every tool and external context source.

## Build one observable loop

Implement `observe → decide → act → verify` with explicit completion, failure, human-escalation,
and maximum turn/time/cost/tool-call conditions. Feed each tool result back as environmental ground
truth. Preserve a trace of model choice, tool request, validated arguments, result, state transition,
and stop reason without logging secrets or unnecessary personal data.

## Design tools as narrow contracts

- Name the action and domain unambiguously; describe when to use it, required input, effect, return,
  errors, idempotency, and limits.
- Prefer task-level tools with typed schemas over raw shell, SQL, HTTP, or generic “execute” access.
- Separate read from write and reversible from irreversible operations. Validate and authorize every
  call in application code; the model never grants itself permission.
- Return concise structured results with stable error codes and a corrective next step. Paginate or
  summarize large results and keep source identifiers for follow-up.
- Test descriptions and schemas through evals; a technically correct tool the model cannot select
  reliably is not usable.

Use MCP when multiple agent clients need a standard capability boundary or external context/tool
provider. Use ordinary application functions when the capability is local to one system; protocol
infrastructure is not automatically better architecture.

## Add agents only for real separation

Prefer a manager using specialists as tools when one agent should own the user interaction and
synthesis. Use handoffs when a specialist should own the next interaction and context. Define each
agent's scope, tools, input/output contract, termination, and context budget. Do not split agents by
fictional job titles when functions or prompts would express the same separation.

Minimize transferred context: task, constraints, relevant evidence, decisions, and expected output.
Never rely on another agent inferring hidden state. Parallelize independent work only; reconcile
conflicts explicitly before effects.

## Completion gate

Every loop is bounded and traceable; every tool is least-privileged, typed, authorized, tested, and
actionable on failure; every handoff has ownership and context contracts; high-risk effects pause
for accountable human approval.

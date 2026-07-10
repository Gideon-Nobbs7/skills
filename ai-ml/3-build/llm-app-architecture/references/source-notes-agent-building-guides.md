# Agent-building source notes

Snapshot assessed: 2026-07-10. These are locally stored, attributed notes rather than runtime
dependencies. Revisit the original pages only when deliberately updating this skill.

## IBM — How to Build an AI Agent

Source: https://www.ibm.com/think/topics/how-to-build-an-ai-agent
Author: Dave Bergmann

- Begin with users, purpose, responsibilities, inputs, knowledge sources, tools, and objective
  success measures.
- Match model capability to accuracy, latency, modality, cost, hardware, and workflow complexity.
- Prefer the simplest agent that fits; simple systems are cheaper to operate, debug, and explain.
- Frameworks supply composable code building blocks; platforms also supply deployment, monitoring,
  and management. Choose based on control, skill, and operational needs.
- Model output only proposes a tool call; application code validates and executes the action.

## OpenAI — A Practical Guide to Building Agents

Source: https://openai.com/business/guides-and-resources/a-practical-guide-to-building-ai-agents/
Author: OpenAI

- Use agents for workflows with complex decisions, brittle rules, or substantial unstructured data;
  otherwise prefer deterministic automation.
- Design from model, tools, and instructions. First meet the quality target with a capable model,
  then replace steps with smaller models where evaluations preserve quality.
- Keep a single agent and add tools before introducing multiple agents.
- Multi-agent orchestration is usually manager-as-tools or decentralized handoffs.
- Every run needs explicit exit conditions and limits.
- Layer deterministic, model-based, moderation, relevance, privacy, and tool-risk guardrails on top
  of normal authentication and authorization.
- Escalate to a human on repeated failure and high-risk or irreversible actions.

## Anthropic — Building Effective Agents

Source: https://www.anthropic.com/engineering/building-effective-agents
Author: Anthropic

- Distinguish workflows, whose code fixes the path, from agents, whose model selects the path.
- Start with a direct model call; add prompt chains, routing, parallelization, orchestrator-worker,
  evaluator-optimizer, and finally autonomous agents only when measured performance earns them.
- Framework abstraction can hide prompts, responses, and failure behavior; understand the
  underlying calls and reduce layers when production debugging demands it.
- Give agents environmental ground truth after each action, stopping conditions, and human
  checkpoints.
- Tool interfaces deserve prompt-engineering attention: make formats natural for models, names and
  parameters unambiguous, and errors actionable.

## JetBrains/PyCharm — Top Agentic Frameworks for Building Applications 2026

Source: https://blog.jetbrains.com/pycharm/2026/06/top-agentic-frameworks-for-building-applications-2026/
Author: Evgenia Verbina

- Compare frameworks by orchestration, tool integration, memory, human checkpoints,
  observability/control, reproducibility, deployment fit, and governance—not popularity.
- Graph-oriented systems fit explicit branching and auditability; role-oriented systems emphasize
  collaboration; retrieval-oriented systems emphasize grounded knowledge; lightweight systems fit
  prototypes; enterprise systems emphasize governance.
- Framework recommendations age quickly. Re-evaluate candidates against the current project rather
  than encoding a permanent default.

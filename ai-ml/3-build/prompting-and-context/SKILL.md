---
name: ai-ml-build-prompting-and-context
description: Use when writing or changing system instructions, prompt templates, few-shot examples, retrieval, RAG, citations, conversation context, compaction, memory, or token budgets for an LLM application or agent.
---

# Prompting and Context Engineering

Treat the complete model input as versioned source: instructions, tool definitions, examples,
retrieved evidence, history, memory, schemas, and runtime variables. Apply AI security before adding
untrusted content and eval every behavioral change.

## Write an executable prompt contract

State role only when it changes behavior, then objective, authoritative constraints, available
context, required process/checkpoints, output schema, uncertainty behavior, and completion criteria.
Use direct imperative language and positive target behavior. Put stable rules in the system layer,
task input in the user layer, and untrusted evidence in clearly delimited data sections. Never rely
on prompt text to enforce authorization or secret boundaries.

Use few-shot examples for distinctions the model repeatedly misses. Cover edge and refusal behavior,
not only ideal outputs. Keep policy variables structured rather than forking near-duplicate prompts.

## Curate context by marginal value

Budget tokens among stable instructions, tools, task, evidence, working state, and response. Include
the smallest sufficient set; stale or irrelevant context can reduce quality. Summarize history into
decisions, unresolved questions, and durable facts while preserving links to full evidence. Store
memory only with a defined scope, source, confidence, retention, update, and deletion rule.

Choose long context for a bounded corpus that fits and must be reasoned over together. Choose RAG
when the corpus is large, changing, access-controlled, or citation-sensitive. Evaluate chunking,
metadata, retrieval, reranking, and answer generation separately. Enforce tenant and permission
filters before retrieval; retrieved text is evidence, not instruction.

## Ground outputs

Require source identifiers alongside claims when the feature promises grounding. Validate that
citations exist, were actually provided, and support the claim; fluent text is not proof. Allow the
model to state insufficient evidence and route high-impact uncertainty to a human or deterministic
system.

## Completion gate

Prompts and retrieval configuration are versioned with model/tool/schema versions; context fits its
budget; untrusted material is isolated; privacy and retention are defined; evals cover instruction
following, conflicts, missing evidence, injection, long context, citations, and regressions.

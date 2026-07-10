---
name: ai-ml-operate-model-monitoring
description: Use when operating a deployed model, prompt, retrieval system, or agent and monitoring quality, drift, safety, tools, latency, cost, provider changes, feedback, rollout, rollback, retraining, or retirement.
status: draft
---

# Model Monitoring and AI Operations

Apply core observability, incident response, feedback, maintenance, and release skills. AI telemetry
adds behavior and data signals; it does not replace service health monitoring.

## Monitor the behavioral release

Tag each trace with application feature, release, model/provider, prompt, tool schema, retrieval
index, guardrail, and experiment cohort versions. Track:

- Task success and calibrated quality proxies, segmented by workflow and material cohort.
- Safety, policy, permission, escalation, refusal, hallucination/grounding, and tool failure rates.
- Input quality, missingness, distribution change, retrieval coverage/freshness, and embedding/index
  health.
- End-to-end and per-step latency, timeouts, retries, turns, tool calls, queueing, token/compute cost,
  and provider errors.
- Human overrides, corrections, complaints, abandonment, and downstream outcome where available.

Do not log raw prompts, outputs, retrieved documents, or user identifiers by default. Sample and
redact under explicit privacy, access, retention, and review policy.

## Detect quality change

Define baseline windows and thresholds before alerting. Drift is evidence to investigate, not an
automatic retraining command. Separate data drift, concept/task drift, provider/model behavior
change, prompt/retrieval regression, and product population change. Use delayed ground truth when
available; otherwise maintain validated proxy metrics and routine sampled human review.

## Roll out and recover

Canary behavioral changes by cohort, shadow them when effects can be evaluated safely, compare
against the current baseline, and retain instant rollback of model, prompt, retrieval, tools, and
guardrails as a compatible unit. Provider fallbacks preserve contracts and safety or enter an
explicit degraded mode. Track provider deprecations and re-run evals before forced migrations.

Feed reviewed production failures into the eval dataset with provenance and privacy protection.
Retrain, re-index, revise prompts, or replace models only under a recorded trigger, evaluation,
approval, rollout, and rollback plan. Retire unused artifacts and data under retention policy.

## Operational gate

An owner can identify the active behavioral versions, explain current quality/cost/latency/safety,
trace a failed run, detect broken inputs or provider drift, obtain feedback/ground truth, and roll
back without rebuilding the application.

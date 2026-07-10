---
name: ai-ml-setup-model-selection
description: Use when choosing, comparing, benchmarking, routing, or replacing generative, embedding, vision, speech, or classical ML models; extends core architecture selection with quality, latency, cost, privacy, deployment, and model-lifecycle trade-offs.
status: draft
---

# AI/ML Model Selection

Apply core scoping, architecture, security, and NFR rules first. Select from measured task behavior,
not leaderboards or permanent provider defaults; model catalogs, prices, and capabilities change.

## Define the selection contract

Record task and modality, representative inputs, required output contract, minimum quality, failure
cost, latency/throughput limits, context needs, privacy/residency, availability, deployment target,
budget, and monitoring/exit plan. Establish the simplest meaningful baseline—including a
deterministic or non-ML solution—before comparing models.

## Evaluate candidates

1. Build a representative eval slice with normal, edge, adversarial, multilingual, and high-impact
   cases. Use `ai-ml-verify-evals` for the evaluation design.
2. Test the strongest plausible model first to establish whether the task is feasible and the
   quality ceiling is sufficient.
3. Compare smaller, faster, cheaper, local, or specialized models against the same cases and system
   conditions. Measure end-to-end latency and cost, including retrieval, retries, tools, and output
   validation—not only token price.
4. Choose the least costly candidate that clears every hard gate with acceptable variance. Record
   rejected candidates and evidence.

Use hosted models when managed capability and iteration speed outweigh data/control constraints;
use self-hosted or local models when privacy, offline operation, customization, predictable volume,
or deployment control justifies hardware and operations ownership.

## Route and fall back safely

Add model routing only when evals show separable task classes and routing errors do not erase the
benefit. Make the default path reliable before adding cheap-first escalation. A fallback must
preserve the output contract and safety policy; degraded behavior is explicit to the product when
quality materially changes. Never silently retry non-idempotent tool work through another model.

## Completion gate

Version the chosen model/provider configuration with prompts and eval results. Document quality,
latency, cost, privacy, availability, fallback, rollback, and replacement triggers. Re-evaluate on
provider change, model deprecation, material traffic shift, or detected quality drift.

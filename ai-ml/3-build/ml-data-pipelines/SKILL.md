---
name: ai-ml-build-ml-data-pipelines
description: Use when building datasets, labels, features, embeddings, fine-tuning data, training or inference pipelines, experiment tracking, model artifacts, data validation, or reproducible ML workflows; applies the Microsoft ML lifecycle checklist on top of core data engineering.
---

# ML Data Pipelines

Apply core state/data, security, contracts, testing, and release rules. Read
[`references/source-notes-microsoft-ml-playbook.md`](references/source-notes-microsoft-ml-playbook.md)
for the lifecycle and production checklist.

## Gate investment with evidence

Envision the business problem and intended use, then run a time-boxed feasibility study. Confirm
data access, rights, lineage, quality, representativeness, labels or ground truth, baseline, minimum
useful performance, integration path, responsible-AI risks, and ROI. End with proceed, pivot, or
stop plus evidence; experimentation is not an automatic commitment to production.

## Version the complete experiment

For every run, bind code revision, environment/dependencies, source dataset and lineage, split
method, preprocessing/features, prompt or training configuration, hyperparameters, random seeds,
model/provider version, evaluation code/version, metrics, and artifacts. Keep immutable raw inputs
where policy allows and derive processed data through reproducible pipelines. Prevent entity,
temporal, duplicate, and target leakage across splits.

Separate exploration from production while sharing tested transformation and evaluation modules.
Notebooks may explore; scheduled and serving pipelines use reviewable modules with stable inputs,
outputs, exceptions, and tests.

## Build trustworthy pipelines

- Validate schema, ranges, missingness, distributions, freshness, duplicates, label quality, tenant,
  consent, and privacy before training, indexing, or scoring.
- Make transformations deterministic where possible and safe to rerun. Track partial progress and
  quarantine invalid data instead of silently coercing it.
- Version embeddings with source content, chunking, preprocessing, model, dimensions, and index
  configuration. Define refresh, deletion propagation, tenant isolation, and full rebuild.
- Fine-tune only when evals show prompting/retrieval cannot meet a stable repeated behavior and the
  team has representative licensed data, a baseline, safety review, and maintenance capacity.
- Register deployable artifacts with lineage, evaluation, approval, compatibility, and rollback.

## Operationalization gate

Require a meaningful baseline, consistent evaluation, tested stable schemas, end-to-end pipeline
proof, hard quality/latency/cost limits, input and drift monitoring, obtainable production ground
truth or proxy, responsible-AI review, recovery, accountable owner, and retraining/replacement
policy. Use `ai-ml-operate-model-monitoring` after deployment.

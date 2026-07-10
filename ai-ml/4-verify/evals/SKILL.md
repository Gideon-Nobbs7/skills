---
name: ai-ml-verify-evals
description: Use when defining, implementing, or reviewing evaluations for nondeterministic model behavior, prompts, retrieval, tools, agents, safety, model changes, or ML pipelines; extends core testing with representative datasets, graders, repeated trials, error analysis, and release gates.
status: draft
---

# AI/ML Evaluations

Apply `core-verify-testing-strategy` and ordinary software tests first. Unit and integration tests
prove deterministic code; evals measure probabilistic behavior and end-to-end task success.

## Define the evaluation contract before optimization

Connect product outcome to observable task behavior, then select metrics and hard safety limits.
Record population, environment, model/prompt/tool/retrieval versions, baseline, sample construction,
grader, aggregation, confidence/variance, threshold, and release decision. Evaluation code is
reviewed, versioned, and tested like production code.

Build cases from real workflows, failures, expert-designed edges, adversarial inputs, relevant
languages and cohorts, and synthetic expansion that is reviewed for realism. Keep a sequestered
holdout for final comparison. Prevent train/prompt contamination and do not tune indefinitely on
the release gate.

## Match graders to claims

- Use exact or schema checks for deterministic facts and contracts.
- Use executable/environment checks for tool effects and task completion.
- Use reference-based metrics only when they correlate with the product behavior.
- Use rubric-scored model judges for scalable semantic review after calibrating them against human
  labels, controlling order bias, and requiring structured rationale.
- Use blinded domain-expert review for subjective, high-impact, novel, or poorly calibrated cases.

For agents, grade the final state and side effects first, then trajectory properties such as tool
selection, policy compliance, efficiency, recovery, and escalation. A plausible final answer cannot
hide an unsafe path.

## Measure honestly

Run repeated trials when sampling, tools, or environment add variance. Report pass rate and
distribution, not only the best run. Compare against the current production baseline on the same
cases and conditions. Segment results to expose regressions hidden by an average; perform error
analysis by named failure categories before changing prompts or models.

## Release gate

Every model, prompt, retrieval, tool, data, framework, and guardrail change runs the affected suite.
Block on safety/permission violations, contract failures, statistically or practically meaningful
quality regression, or breached latency/cost limits. Store results and artifacts with the release;
promote confirmed production failures into regression cases without leaking private data.

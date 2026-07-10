# Microsoft ML and AI playbook notes

Source: https://microsoft.github.io/code-with-engineering-playbook/ml-and-ai-projects/
Author: Microsoft Industry Solutions Engineering
Snapshot assessed: 2026-07-10; source pages reported last update 2025-02-07.

These locally stored notes preserve the checklist used by the AI/ML track without requiring
runtime fetching.

## Lifecycle

1. Envision the measurable business problem, users, current practice, intended use, available
   data, minimum useful performance, constraints, and responsible-AI concerns.
2. Run a feasibility study before full investment: data access and quality, exploratory analysis,
   hypothesis tests, baseline, integration feasibility, ROI, risks, and a proceed/pivot/stop
   recommendation.
3. Reach a model milestone: a basic solution meets minimum model and system performance; only then
   finalize scope, architecture, definition of done, and delivery plan.
4. Experiment reproducibly with tracked code, environment, data, parameters, metrics, and artifacts.
5. Operationalize through tested pipelines, stable schemas/interfaces, deployment, monitoring,
   recovery, ownership, and retraining or replacement policy.

## Fundamentals checklist

- Data access, provenance/lineage, labels where required, quality analysis, access policy,
  security, privacy, and compliance are documented.
- A feasibility study tests whether the available data supports the proposed task.
- Evaluation metrics connect to business success, can be calculated from available data, apply to
  every candidate, support error analysis, and are implemented in reviewed, tested code.
- A defined baseline exists and every candidate is compared against it on consistent splits.
- Experiments are reproducible and logged in a shared environment; hypotheses and outcomes are
  documented rather than only successful runs.
- Production has stable input/output schemas, end-to-end tests, service objectives, data/output
  monitoring, reviews, and accountable maintenance.

## Production-readiness questions

- Will production inputs or behavior differ from training/evaluation conditions?
- Does the model beat a meaningful non-ML or model baseline?
- Are offline and online performance metrics defined and benchmarked?
- Can ground truth or a trustworthy proxy be obtained after deployment?
- Have training, validation, and test distributions and leakage risks been analyzed?
- Are hard limits defined for quality, latency, throughput, availability, and cost?
- Is integration impact understood and is the interface stable?
- How will input quality, distribution drift, output quality, and system performance be monitored?
- Have fairness, safety, privacy, inclusiveness, transparency, accountability, misuse, vulnerable
  groups, human fallback, and consequential decisions been reviewed throughout the lifecycle?

## Delivery discipline

- Research uncertainty changes estimation, not accountability. Each sprint produces evidence:
  working code, EDA findings, or accepted/rejected hypotheses.
- Use one backlog for data science and software engineering, share operational ownership, and
  define the model interface early.
- Test data loading, transformations, validation, model loading/prediction, and orchestration as
  ordinary modular software; separately evaluate statistical/model behavior.

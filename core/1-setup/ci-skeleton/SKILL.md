---
name: core-setup-ci-skeleton
description: Use when setting up or modifying CI pipelines — the quality-gate sequence every change passes, shift-left ordering, feeding failures back to agents, and keeping the pipeline under 10 minutes.
---

# CI Skeleton

The pipeline that exists from commit one; `core/5-ship` grows it into full release
automation. CI is the enforcement mechanism for every other skill — it catches what humans
and agents miss, consistently, on every change. Adapted from Addy Osmani's
`ci-cd-and-automation` ([source](https://github.com/addyosmani/agent-skills)).

## Areas under consideration
- [x] Minimum stages — the gate sequence and parallelism
- [x] Blocking policy — no gate skipped
- [x] Caching and speed strategy
- [x] CI-failure → agent feedback loop
- [ ] Platform default (GitHub Actions?) and a reusable starter config
- [ ] When e2e/visual/perf checks join the pipeline (immediately? at first release?)
- [ ] Which checks merely report vs block, per project risk level

## Skill

### Two principles

**Shift left** — catch problems as early as possible: a bug caught by lint costs minutes,
the same bug in production costs hours. Static analysis before tests, tests before
staging, staging before production. **Faster is safer** — smaller batches and more
frequent releases reduce risk; a deploy with 3 changes debugs easier than one with 30.

### The quality-gate sequence

Every PR passes: lint → typecheck → unit tests → build → integration tests → e2e
(when present) → security audit → bundle-size check. **No gate can be skipped.** Lint
fails → fix the lint, don't disable the rule. Test fails → fix the code, don't skip the
test. Flaky test → fix the flakiness, don't re-run until green. Merge is blocked until CI
passes (branch protection: required status checks, no force-push to main).

### Mechanics

- Install with `npm ci` (or the ecosystem equivalent) against a committed lockfile.
- Cache dependencies; run independent gates (lint/typecheck/test) as parallel jobs.
- Integration tests get real services via CI service containers (e.g. postgres with
  health checks), with credentials from the CI secrets store even for throwaway test
  DBs — CI never holds production secrets.
- Failed e2e runs upload their artifacts (reports, traces) for diagnosis.
- Dependabot/Renovate on a weekly schedule with a bounded open-PR limit.

### Feed failures back to the agent loop

CI's power with agents is the feedback loop: paste the specific failure into the working
agent — lint failure → auto-fix and commit; type error → read the location, fix the type;
test failure → the diagnosis loop in `core-operate-maintenance`; build error → check
config and dependencies. Fix locally, verify, then push.

### Keep it under 10 minutes

When slower, apply in order of impact: cache dependencies → parallel jobs → path filters
so unrelated changes skip jobs (docs-only PRs skip e2e) → shard suites across runners →
pull slow tests off the critical path onto a schedule → bigger runners.

### Verification

Gates all present and blocking; pipeline runs on every PR and push to main; secrets in
the secrets manager, never code or CI config; a rollback mechanism exists
(`core-ship-deployment-strategies`); suite completes in under 10 minutes.

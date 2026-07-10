---
name: core-setup-ci-skeleton
description: The minimal CI pipeline that exists before features do — stages, blocking checks, caching. (stub — awaiting content)
status: stub
---

# CI Skeleton

The pipeline that exists from commit one; `core/5-ship` grows it into full release automation.

## Areas under consideration
- [ ] Minimum stages — lint, typecheck, test, build; the order and what's parallel
- [ ] Which checks block merge vs merely report
- [ ] Platform default (GitHub Actions?) and reusable config
- [ ] Caching strategy so CI stays fast
- [ ] When e2e/visual/perf checks join the pipeline (immediately? at first release?)

## Skill
_(awaiting intake — will be written as directives an agent can follow)_

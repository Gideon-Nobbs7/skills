---
name: core-ship-deployment-strategies
description: Use when planning how a change reaches users — feature flags (deploy ≠ release, flags must die), staged rollout with metric thresholds, rollback plans written before deploy, and expand/contract schema migrations.
---

# Deployment Strategies

How change reaches users without breaking them. Every launch reversible, observable, and
incremental. Adapted from Addy Osmani's `shipping-and-launch` and the schema-migration
half of `deprecation-and-migration`
([source](https://github.com/addyosmani/agent-skills)).

## Areas under consideration
- [x] Feature flags — lifecycle, rules, kill switches
- [x] Staged rollout sequence and advance/hold/rollback thresholds
- [x] Rollback — plan template, written before deploy
- [x] Database migrations — expand/contract coordination with deploys
- [ ] Rollout defaults by project risk level — when big-bang is acceptable
- [ ] Zero-downtime expectations — when they apply, how they're met
- [ ] Flag tooling preference

## Skill

### Feature flags decouple deployment from release

Ship code dark, enable when ready; roll back by flipping a flag instead of redeploying;
canary by percentage; even "simple" changes benefit from a kill switch. Lifecycle:
deploy OFF → enable for team → gradual rollout (5% → 25% → 50% → 100%) → monitor at each
stage → **remove the flag and dead code path within ~2 weeks of full rollout**. Rules:
every flag has an owner and an expiration date; never nest flags (exponential
combinations); CI tests both states.

### Staged rollout

Staging (full suite + manual smoke of critical flows) → production with flag OFF (health
check, no new errors) → team enable, 24h watch → 5% canary, 24–48h, canary-vs-baseline
metrics → 25/50/100% with the same monitoring, rollback-to-previous-percentage available
at any point → full rollout, 1-week watch, flag cleanup.

**Advance/hold/rollback thresholds per stage:**

| Metric | Advance | Hold & investigate | Roll back |
|---|---|---|---|
| Error rate | within 10% of baseline | 10–100% above | >2× baseline |
| P95 latency | within 20% | 20–50% above | >50% above |
| New client JS errors | none | <0.1% of sessions | >0.1% of sessions |
| Business metrics | neutral/positive | decline <5% | decline >5% |

Roll back immediately on: >2× error rate, >50% p95 regression, user-report spikes, data
integrity issues, or a discovered vulnerability. Rolling back is responsible engineering;
shipping broken is the failure.

### Write the rollback plan before deploying

Every deploy documents: trigger conditions (concrete thresholds), rollback steps (flag
off, or revert-and-redeploy), verification after rollback, who to notify, database
considerations (which migrations reverse, what happens to data the new feature wrote),
and expected time-to-rollback (flag <1 min; redeploy <5 min; DB <15 min). The rollback
path is exercised — dry-run if possible — not just written.

### Schema migrations: expand/contract, never in place

Data is the one thing a redeploy can't roll back. Never couple a schema change to the
code change that uses it — during rollout, old and new code run simultaneously and one of
them will query a column that doesn't exist. Migrate in additive phases, each
independently deployable and reversible:

1. **Expand** — add the new column/table nullable alongside the old. Deploy.
2. **Dual-write** — app writes old and new. Deploy.
3. **Backfill** — copy existing rows in throttled batches (a single UPDATE over millions
   of rows locks the table).
4. **Switch reads** — point the app at the new shape, keep dual-writing. Deploy and bake.
5. **Contract** — stop writing the old; drop it in a *separate, later* deploy once
   nothing references it.

Rules: additive first, destructive last and alone; **every migration has a tested down
path before merging** (a migration you can't reverse is a deploy you can't roll back);
build large indexes without blocking writes (`CREATE INDEX CONCURRENTLY`); gate risky
cutovers behind a feature flag.

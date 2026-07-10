---
name: core-operate-incident-response
description: Use when a production service, user journey, security posture, or reliability target is failing—declare and coordinate the incident, mitigate user harm first, communicate clearly, preserve evidence, restore safely, and turn learning into owned follow-up.
status: draft
---

# Incident Response

What happens when production breaks.

## Declare early, mitigate first

Treat a suspected material outage as an incident until evidence lowers the severity. Do not wait
for a complete diagnosis while users are harmed. Preserve error IDs, dashboards, recent changes,
and timestamps; stop unrelated deploys; choose the fastest safe mitigation—flag off, rollback,
traffic shed, dependency failover, or feature disable—before root-cause work.

## Severity and roles

- **Critical:** broad outage, data integrity/security risk, or core task unavailable. Page the
  responsible responders; maintain an active incident channel and external status path if users
  are affected.
- **Major:** a significant journey or cohort is degraded with a workaround or bounded impact.
  Assign an owner and regular updates until restored.
- **Minor:** limited impact, no urgent user harm, and safe to schedule through normal maintenance.

Assign one incident lead to own scope, decisions, and cadence; one communications owner when the
incident is large enough; and investigation/mitigation owners by system. The lead prevents parallel
speculation from becoming uncoordinated changes.

## Operating loop

1. **Assess:** state what is broken, who is affected, when it began, confidence, and current
   severity. Link dashboards, logs, traces, alerts, and recent deployments.
2. **Mitigate:** choose the smallest reversible action that reduces harm. Announce each action,
   expected signal, and rollback condition before executing it.
3. **Restore:** verify the affected journey, error/latency signals, queues/data integrity, and
   downstream effects against baseline. Do not close on a single recovered health check.
4. **Communicate:** publish concise updates with impact, mitigation, current status, next update
   time, and known workarounds. Do not speculate or promise a root cause before evidence.
5. **Learn:** write a blameless review: timeline, impact, detection gap, contributing conditions,
   what helped/hurt, and a small set of prevention/detection/recovery actions with owners and due
   dates. Track actions to completion; a postmortem with no completed change is documentation, not
   learning.

Use `core-operate-observability` to make signals diagnosable, `core-operate-maintenance` for the
root-cause loop, and `core-ship-deployment-strategies` when rollback or feature flags mitigate the
incident. Rotate exposed credentials and follow `core-setup-env-and-secrets` for any suspected
secret leak.

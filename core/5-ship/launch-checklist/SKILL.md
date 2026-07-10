---
name: core-ship-launch-checklist
description: Use as the final gate before anything goes live — the pre-launch checklist across code/security/performance/a11y/infrastructure/docs, and the first-hour post-launch verification.
status: draft
---

# Launch Checklist

The last thing checked before anything goes live, and the first hour after. Adapted from
Addy Osmani's `shipping-and-launch` ([source](https://github.com/addyosmani/agent-skills)).
Rollout mechanics live in `core-ship-deployment-strategies`; the instrumentation this
checklist verifies live in `core-operate-observability`.

## Areas under consideration
- [x] Verify gates — the per-domain pre-launch checks
- [x] Rollback rehearsed and monitoring live
- [x] Post-launch watch — the first hour
- [ ] Comms — who needs to know it shipped, per project type
- [ ] Alarm ownership — who gets paged, escalation path
- [ ] The user's own never-cut list (a11y? security?) as hard gates

## Skill

### Pre-launch: every section green

- **Code** — all tests pass; build clean with no warnings; lint + types pass; reviewed;
  no unresolved TODOs or debug logging; error handling covers expected failure modes.
- **Security** — the pre-ship pass in `core-build-secure-coding` is complete: no secrets in
  code/history/logs/artifacts; audit clean of reachable critical/high issues or documented
  exception; boundary validation on user-facing endpoints; authn *and* authz checked; new
  permissions/data flows reviewed; security headers; auth rate limiting; CORS pinned to origins.
- **Performance** — Core Web Vitals in "Good"; no N+1 on critical paths; images
  optimized; bundle within budget; indexes on hot queries; caching for static assets and
  repeated queries.
- **Accessibility** — full keyboard navigation; screen-reader-conveyable structure; WCAG
  AA contrast; correct focus management for modals/dynamic content; descriptive errors
  associated with fields; clean axe/Lighthouse run.
- **Infrastructure** — production env vars set; migrations applied or staged; DNS/SSL;
  CDN for static assets; logging and error reporting confirmed configured; a health-check
  endpoint that responds.
- **Documentation** — README, API docs, ADRs, changelog, user-facing docs current.

Plus, from the deployment side: feature flag configured, rollback plan documented and
exercised, monitoring dashboards up, team notified. **No one available to watch the first
hour — including "Friday afternoon" — is a reason not to ship yet.**

### Post-launch: the first hour

1. Health endpoint returns 200.
2. Error monitoring shows no new error types.
3. Latency dashboards show no regression.
4. Walk the critical user flow manually in production.
5. Logs are flowing and readable.
6. Rollback mechanism confirmed ready (dry-run if possible).

"It works in staging" is not evidence — production has different data, traffic, and edge
cases; the monitors are the evidence.

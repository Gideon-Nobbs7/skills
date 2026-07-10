---
name: core-operate-observability
description: Use when adding logging, metrics, tracing, or alerts — define the on-call questions first, structured events with correlation IDs, RED/USE metrics with bounded cardinality, symptom-based alerting, then verify the telemetry itself.
status: draft
---

# Observability

Code you can't observe is code you can't operate. Instrumentation is written alongside the
feature, like tests — a feature shipped without telemetry makes its first bug archaeology
instead of a query. Adapted from Addy Osmani's `observability-and-instrumentation`
([source](https://github.com/addyosmani/agent-skills)). Live diagnosis is
`core-operate-maintenance`; launch-day monitoring gates are `core-ship-launch-checklist` —
this skill is the instrumentation that feeds both.

## Areas under consideration
- [x] Logging conventions — structure, levels, PII rules, correlation IDs
- [x] Metrics — RED/USE, cardinality, percentiles
- [x] Tracing — OpenTelemetry stance
- [x] Alerting — symptom-based, two severities
- [x] Analytics vs observability — the three-tier activity-analysis model
- [ ] Error-tracking tooling default (Sentry?) and triage workflow
- [ ] Dashboards & per-system "healthy" definitions

## Skill

### Define "working" before instrumenting

Telemetry without a question is noise. Before any instrumentation, write down 2–4
questions an on-call engineer will ask about this feature ("what fraction of payments
succeed on first attempt?", "when one fails permanently, why?"). Every signal added must
answer one of them; if you can't name the questions you'll log everything and learn
nothing.

### Pick the right signal

Metrics tell you **that** something is wrong, traces tell you **where**, logs tell you
**why**. Structured log = "what happened in this specific case" (cost grows with
traffic); metric = "how often/how fast in aggregate" (fixed cost per series); trace =
"where did time go across services" (sampled per request).

### Structured logging

Log events, not prose: JSON with a stable event name and machine-readable fields — never
string interpolation (unqueryable). Levels used consistently: `error` = invariant broken,
someone may act; `warn` = degraded but handled; `info` = significant business event;
`debug` = off in production. **Correlation IDs are mandatory**: generate or accept a
request ID at the boundary, attach to every log line, span, and outbound call — without
it a single request can't be reconstructed from interleaved logs. **Never log secrets,
tokens, passwords, or unredacted PII** — allowlist fields; never log whole request bodies.

### Metrics

**RED** on every endpoint and every external dependency: Rate, Errors, Duration (as a
histogram — never averages, always p50/p95/p99; an average hides the 1% having a terrible
time). **USE** for resources (queues, pools, hosts): Utilization, Saturation, Errors.
**Cardinality is the failure mode**: every unique label combination is a time series;
labels come from small fixed sets (route template, status *class*, provider name) —
never user IDs, raw URLs, request IDs, or error text. High-cardinality detail belongs in
logs and traces.

### Tracing

OpenTelemetry — vendor-neutral, auto-instrumentation covers HTTP/gRPC/DB clients at
near-zero code (initialized before anything else). Manual spans only around meaningful
internal units of work, carrying the attributes on-call will filter by. Propagate context
across every async boundary (headers, queue metadata) or the trace dies at the gap.
Sample low head-based by default; keep 100% of errors if tail sampling is available.

### Alerting: symptoms, not causes

Page on what users feel (error rate >1% for 5 min, p99 >2s, queue age >10 min), dashboard
the causes (CPU, restarts, disk). Cause alerts fire when nothing is wrong and miss
failures you didn't predict. Every alert: actionable (if the response is "ignore, it
self-heals", delete it); links a runbook (even three lines: meaning, first query,
escalation); threshold and duration justified by SLO or history, not a guess. Two
severities only — **page** (act now) and **ticket** (act this week); a third tier trains
people to ignore everything.

### User activity analysis: the three tiers

(Adapted from Greenspun et al. —
[User Activity Analysis](https://philip.greenspun.com/seia/user-activity-analysis).)
Product analytics follows the same rule as system telemetry: **questions before tools**.
Different stakeholders ask different questions — marketing (where users come from, which
promotions work), editors (which content draws and retains), engineering (slow pages,
errors), community management (who contributes, who abuses) — and the question list
determines which tier you need:

1. **Server/access logs** — coarse and cheap: traffic volume, popular pages, referrers,
   error rates. Records requests, not users or transactions.
2. **Application-level event logging** — the application knows who and what, so it logs
   semantically meaningful events (registered, posted, purchased, searched-for-X) to the
   database; answers user-centric questions at the cost of production write load.
3. **A dimensional warehouse** — when questions turn analytical (retention by cohort,
   contribution rates by user class over time), copy data into a separate store
   organized as facts + dimensions (Kimball) so analysis never competes with production
   traffic.

Watch errors actively — don't wait for user reports; notify on *new* error types with
throttling (a page failing a thousand times an hour is one alert, not a thousand emails —
same principle as the alerting rules above). And **close the loop**: analysis feeds
revised user classes and scenarios back into `core-setup-scoping-and-requirements` and
tells `core-operate-feedback-and-iteration` when technical or social scaling limits are
approaching.

### Verify the telemetry itself

Instrumentation is code; it can be wrong. Before done: force an error in staging and find
it in the logs by requestId with structured fields; send test traffic and confirm the
metric series appear with expected labels; follow one request end-to-end in the tracing
UI with no broken spans; test-fire each new alert once and confirm it reaches the right
channel. The bar: an induced staging failure can be located via telemetry alone, without
reading source.

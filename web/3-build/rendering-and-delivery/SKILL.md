---
name: web-build-rendering-and-delivery
description: Use when choosing or implementing browser delivery through static generation, server rendering, client rendering, streaming, islands, hydration, edge execution, or CDN caching; extends core architecture and performance rules for HTML delivery.
status: draft
---

# Web Rendering and Delivery

Apply core architecture, state/data, security, and performance skills first. Choose rendering per
route or interaction boundary; a product does not need one global mode.

## Choose the least client work that meets the task

- Use static output for content known at build time and safely cacheable.
- Use server rendering for request-time personalized or frequently changing HTML where first
  response and discovery matter.
- Use islands or server-first components when most of the page is static and only bounded regions
  need interaction.
- Use client rendering for application surfaces whose value depends on rich, long-lived local
  interaction after an acceptable shell or fallback arrives.

Record freshness, personalization, cacheability, interaction, SEO/discovery, resilience, hosting,
and operational constraints. Framework familiarity alone is not a rendering requirement.

## Control hydration and data boundaries

Send only the JavaScript required for interactive behavior. Keep server-only code, credentials, and
data out of browser bundles and serialized payloads. Avoid fetching the same data on server and
client without a defined handoff. Make hydration deterministic across locale, time, randomness,
permissions, and browser-only state; isolate unavoidable client-only differences.

Stream when early meaningful regions can render independently, with stable fallback dimensions and
error boundaries. Prioritize the actual primary content and avoid preloading resources merely
because they are available.

## Place execution and caching safely

Use edge execution only when measured latency, geographic, or platform constraints justify its
runtime and observability trade-offs. Define cache keys from every response-varying input and never
place private responses in shared caches. Set explicit freshness, stale behavior, invalidation,
purge, and failure fallback for HTML and data; fingerprint immutable assets.

## Completion gate

Measure server response, meaningful render, interaction readiness, transferred JavaScript,
hydration failures, cache correctness, and behavior with slow/failed scripts and data. Verify that
private data cannot cross users or tenants through serialization, caching, or edge execution.

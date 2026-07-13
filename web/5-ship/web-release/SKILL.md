---
name: web-ship-web-release
description: Use when releasing a browser-delivered site or application, including hosting, CDN and cache policy, redirects, metadata, indexing, analytics consent, security headers, and production smoke checks; extends core shipping with web launch mechanics.
---

# Web Release

Apply the core release pipeline, deployment strategy, launch checklist, and change communication
skills first. This overlay verifies browser delivery and discovery at the production boundary.

## Configure production delivery

Promote the verified artifact through the core pipeline. Fingerprint static assets and cache them
immutably; give HTML, API data, and personalized responses explicit cache rules based on their
freshness and privacy. Verify cache keys, invalidation, stale behavior, compression, TLS, canonical
host, trailing-slash policy, and custom error pages.

Preserve moved URLs with deliberate permanent or temporary redirects and prevent redirect chains
and loops. Keep a rollback path that also accounts for incompatible caches, edge configuration,
and database migrations.

## Verify document and discovery metadata

For indexable pages, confirm unique useful titles and descriptions, canonical URLs, robots policy,
sitemaps, social previews, structured data where applicable, status codes, and localized alternates.
Keep private, duplicate, preview, and non-production environments out of indexes.

## Apply browser security and privacy controls

Set a tested Content Security Policy and the relevant transport, framing, referrer, MIME-sniffing,
and permissions controls. Prefer reporting before enforcing a new restrictive policy, then remove
unnecessary allowances. Cookies use the narrowest domain/path and appropriate Secure, HttpOnly,
and SameSite attributes.

Load analytics, advertising, or optional third-party scripts only under the project's documented
privacy and consent policy. Minimize collected data, honor withdrawal, and verify that denial does
not break the core product journey.

## Production gate

Smoke-test critical journeys on the production URL across representative engines and viewports.
Check accessibility, performance budgets, errors, source maps, cache headers, redirects, metadata,
index controls, consent behavior, security headers, analytics events, monitoring, and rollback.
Release ownership and observation windows remain governed by the core launch checklist.

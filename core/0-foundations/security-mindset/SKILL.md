---
name: core-foundations-security-mindset
description: "Always-on security mindset for every project and phase: hostile inputs, explicit trust boundaries, least privilege, secret hygiene, sensitive-data defaults, abuse cases, and escalation triggers before secure-coding or platform-specific security skills add controls."
---

# Security Mindset

Security is a default posture, not a review phase. Every project starts by assuming outside input,
clients, networks, dependencies, generated content, and integrations can behave maliciously or
incorrectly.

## Baseline assumptions

- Treat all external input as hostile until validated at the boundary: requests, forms, files,
  URLs, webhooks, queues, model output, third-party API responses, browser storage, and imported
  data.
- Treat clients as untrusted. Authorization happens on the trusted side of the boundary, never
  only in UI or client logic.
- Treat secrets as live credentials. They never belong in source, logs, screenshots, generated
  artifacts, prompts, examples with real values, or analytics.
- Treat dependencies as code you run. New packages, plugins, actions, skills, and install scripts
  are supply-chain surface.
- Treat internal tools as reachable. "Only internal" reduces exposure; it does not remove the
  need for auth, logging, least privilege, and safe defaults.

## Trust-boundary sketch

Before implementing a feature that touches data, auth, external systems, or generated content,
name:

1. Where untrusted input enters.
2. Which assets matter: credentials, PII, payments, admin actions, private content, availability,
   model/tool permissions, or business records.
3. Who can act: anonymous users, authenticated users, owners, admins, services, background jobs,
   vendors, or agents.
4. What abuse case would hurt: spoofing, tampering, repudiation, information disclosure, denial of
   service, privilege escalation, prompt/tool injection, or supply-chain compromise.
5. Which skill owns the control: `core-build-secure-coding`, `ai-ml-build-ai-security`,
   `backend-build-backend-security`, or a platform-specific overlay.

## Non-negotiables

- Least privilege by default: tokens, service accounts, scopes, file access, agent tools, and
  admin roles start narrow and expand only with a reason.
- Sensitive data has an owner, storage location, retention rule, logging rule, and access rule.
- Authentication proves identity; authorization proves permission for the specific resource and
  action.
- Errors shown to users do not expose internals, secrets, stack traces, SQL, provider responses, or
  security policy details.
- Security-sensitive decisions are explicit in code, contracts, or documentation; do not bury them
  in conventions only one framework understands.

## Escalate before building

Pause for a focused security pass when a change introduces or modifies auth, roles, sensitive data,
payments, file upload, SSRF-capable fetching, webhooks, external integrations, CORS, agent/tool
permissions, dependency installation, encryption, audit logging, tenancy boundaries, or production
secrets.

Use `core-build-secure-coding` for implementation controls and `core-ship-launch-checklist` for
the final release gate.

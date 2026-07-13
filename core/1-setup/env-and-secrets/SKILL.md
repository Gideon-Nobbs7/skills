---
name: core-setup-env-and-secrets
description: Use when setting up or changing project configuration, local environments, CI/CD credentials, or secrets—separate configuration from secrets, validate at startup, use least-privilege delivery, prevent leaks, and plan rotation.
---

# Environments & Secrets

Config and secrets done right before the first feature exists.

## Separate configuration from secrets

- Configuration is safe to describe and version: feature mode, public URL, region, limits, and
  log level. Secrets grant access: credentials, signing keys, tokens, private endpoints, and
  encryption material. Treat the second class as toxic to source control and logs.
- Define one typed configuration schema at process startup. Validate required values, formats,
  allowed environments, and unsafe combinations before accepting traffic; fail clearly without
  echoing values.
- Commit `.env.example` with variable names, safe examples, owner/purpose, and setup notes. Never
  commit `.env`, private keys, production exports, or generated credential files.

## Delivery rules

- Give local developers a one-command bootstrap that retrieves permitted development values from
  the chosen secret manager or password-manager workflow. Do not copy production secrets locally.
- Use the platform or cloud secret manager for deployed environments. CI receives environment-
  scoped, masked values; prefer workload identity/OIDC and short-lived credentials over stored
  cloud access keys.
- Keep local, preview, staging, and production separate. Preview uses isolated credentials and
  data; production access is protected, least-privilege, and never an implicit fallback.
- Name variables consistently (`SERVICE_API_KEY`, `DATABASE_URL`); one variable has one purpose.
  Do not encode JSON blobs of unrelated settings or use environment names to hide behavior.

## Leak and rotation response

- Scan pre-commit and CI for credentials; redact values from logs, screenshots, error reports, and
  support exports. A false-positive allowlist is narrow, reviewed, and expires.
- If a secret appears in a commit, artifact, log, or chat: revoke/rotate it first, identify use,
  update consumers, then remove historical exposure where practical. Deleting the file alone is
  not remediation.
- Assign an owner, scope, expiry/rotation expectation, and recovery procedure to every production
  secret. Remove unused values and access promptly.

`core-build-secure-coding` owns code-level secret hygiene; `core-setup-ci-skeleton` and
`core-ship-release-pipeline` consume secrets safely. This skill establishes the environment
contract they rely on.

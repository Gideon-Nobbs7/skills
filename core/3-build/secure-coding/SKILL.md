---
name: core-build-secure-coding
description: Use when writing any code that touches user input, auth, sensitive data, or external services — threat-model first (STRIDE), the always/ask-first/never boundary tiers, OWASP injection/XSS/SSRF/access-control patterns, secrets and supply-chain hygiene.
status: draft
---

# Secure Coding

The `core/0-foundations/security-mindset` applied at the keyboard: every external input
hostile, every secret sacred, every authorization check mandatory. Security isn't a phase —
it's a constraint on every line touching user data, auth, or external systems. Adapted from
Addy Osmani's `security-and-hardening`
([source](https://github.com/addyosmani/agent-skills)). LLM/agent-specific surface lives in
`ai-ml-build-ai-security`.

## Areas under consideration
- [x] Input handling rules — validate/sanitize/escape, where each happens
- [x] AuthN/AuthZ patterns — hashing, sessions, ownership checks
- [x] Injection classes — SQL/XSS/SSRF standing defenses
- [x] Dependency hygiene — vetting, lockfiles, audit triage
- [x] Secrets in code — env layout, rotation on leak
- [x] Safe defaults — headers, CORS, cookies, rate limits
- [ ] Per-stack specifics beyond JS/TS (Python, Go, mobile)
- [ ] PII/encryption-at-rest standards for the user's projects

## Skill

### Threat-model first — five minutes, not a ceremony

Controls without a threat model are guesses. Before hardening: **map the trust
boundaries** (HTTP requests, forms, uploads, webhooks, third-party APIs, queues, LLM
output — every place untrusted data enters); **name the assets** (credentials, PII,
payments, admin actions); **run STRIDE across each boundary** — Spoofing→authn/signatures,
Tampering→integrity/parameterized queries/HTTPS, Repudiation→audit logs of security
events, Information disclosure→encryption/field allowlists/generic errors,
DoS→rate limits/size caps/timeouts, Elevation→authz/least privilege; and **write abuse
cases next to use cases** — "how would I misuse this?" becomes the first test. Can't name
the boundaries? You're not ready to secure it — most breaches begin in design, not code.

### Three boundary tiers

**Always (no exceptions):** validate all external input at the boundary; parameterize
every query; encode output (framework auto-escaping, never bypassed); HTTPS everywhere;
hash passwords with bcrypt/scrypt/argon2 (rounds ≥ 12); security headers (CSP, HSTS,
X-Frame-Options, X-Content-Type-Options); httpOnly + secure + sameSite session cookies;
dependency audit before every release.

**Ask the user first:** new/changed auth flows; new categories of sensitive data; new
external integrations; CORS changes; file-upload handlers; rate-limit changes; granting
elevated roles.

**Never:** secrets in version control; sensitive data in logs; client-side validation as
a security boundary; disabling security headers for convenience; `eval()`/`innerHTML`
with user data; auth tokens in localStorage; stack traces or internals exposed to users.

### Standing defenses per attack class

- **Injection** — parameterized queries or an ORM; never concatenate input into SQL,
  shell commands, or paths.
- **XSS** — framework auto-escaping; if HTML must be rendered, sanitize
  (DOMPurify-class) first.
- **Broken access control** — authorization on *every* endpoint, not just
  authentication: check the authenticated user owns/may act on the specific resource
  (403 otherwise); admin actions verify the admin role.
- **SSRF** — any server-side fetch of a user-influenced URL (webhooks, import-from-URL,
  image proxies, link previews): allowlist scheme + host, resolve **all** DNS records and
  reject any non-unicast IP (covers loopback, `169.254.169.254` cloud metadata — the #1
  target — private and unique-local ranges), forbid redirects. Note the TOCTOU gap: DNS
  can rebind between check and fetch; for high-risk surfaces pin the resolved IP or use a
  filtering agent.
- **Uploads** — allowlist MIME types, cap size, don't trust extensions (check magic
  bytes when it matters).
- **Sensitive data exposure** — strip secret fields (`passwordHash`, reset tokens) from
  every API response; generic error messages outward.
- **DoS** — rate-limit APIs generally and auth endpoints strictly (order-of ~10 attempts
  / 15 min).

### Secrets

`.env.example` committed with placeholders; `.env`/`.env.local`/`*.pem`/`*.key`
gitignored; secrets reach code via environment only, failing loudly when missing. Before
committing: grep the staged diff for password/secret/api_key/token. **If a secret ever
lands in a commit, rotate it** — deleting the line or rewriting history is not enough;
revoke and reissue first, purge after.

### Dependencies are attack surface

Commit the lockfile; CI installs with `npm ci` (or equivalent) — no silent drift. Review
new dependencies before adding (maintenance, downloads, `postinstall` scripts — they run
arbitrary code at install); watch for typosquats (`crossenv` vs `cross-env`). Triage
audit findings by severity × reachability: critical/high + reachable → fix now;
unreachable or dev-only → fix soon; moderate → next release; low → batch with regular
updates. Every deferred fix gets a documented reason and a review date. Audits catch
known CVEs, not malicious packages — hygiene covers the rest.

### If the code touches an LLM

Model output is untrusted input; prompts can be hijacked; the system prompt is not a
security boundary. Full treatment — including agentic-skill supply-chain security — in
`ai-ml-build-ai-security`.

### Rationalizations to reject

"Internal tool" (weakest link gets targeted), "add security later" (retrofits cost 10×),
"nobody would exploit this" (scanners find it), "the framework handles it" (frameworks
are tools, not guarantees), "it's just a prototype" (prototypes ship), "it's only text
from the model" (that text can be SQL, a script tag, or a shell command).

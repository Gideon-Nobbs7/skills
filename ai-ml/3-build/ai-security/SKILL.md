---
name: ai-ml-build-ai-security
description: Use when building LLM features or agent systems, or when installing/auditing agent skills — OWASP LLM Top 10 patterns (prompt injection, output handling, excessive agency) and the OWASP Agentic Skills Top 10 (malicious skills, supply chain, over-privilege, isolation, governance).
status: draft
---

# AI Security & Safety

The AI overlay on `core/3-build/secure-coding` — model inputs and outputs are untrusted,
and the skills/tools an agent loads are attack surface too. Two OWASP sources adapted:
the [LLM Top 10 (2025)](https://genai.owasp.org/llm-top-10/) patterns via Addy Osmani's
`security-and-hardening`, and the
[Agentic Skills Top 10](https://owasp.org/www-project-agentic-skills-top-10/checklist.html)
— which doubles as the audit standard for this godfile system itself.

## Areas under consideration
- [x] Prompt injection & output handling — LLM01/LLM05 patterns
- [x] Agent permissioning — LLM06 excessive agency
- [x] Data leakage — what never enters a prompt; RAG isolation
- [x] Agentic skill security — the AST01–AST10 considerations
- [ ] Guardrails — input/output filtering tooling preferences
- [ ] Eval-time security testing (red-teaming cadence — ties to `ai-ml-verify-evals`)

## Skill

### Building LLM features

- **Treat all model output as untrusted input** (LLM05). Never pass it into `eval`, SQL,
  a shell, `innerHTML`, or a file path. Parse defensively (JSON.parse + schema
  validation, failing closed), route through allowlisted actions, render as text not
  markup.
- **Assume prompts can be hijacked** (LLM01). Any untrusted text in the context — a user
  message, fetched web page, PDF — can carry instructions. The system prompt is not a
  security boundary: enforce permissions in code, never in the prompt.
- **Keep secrets and other users' data out of prompts** (LLM02/LLM07). Anything in
  context can be echoed back — no API keys, cross-tenant data, or full system prompt
  where the model can repeat it. Redact prompts in logs.
- **Constrain tool and agent permissions** (LLM06). Scope tools to the minimum; require
  confirmation for destructive or irreversible actions; validate every tool argument.
- **Bound consumption** (LLM10). Cap tokens, request rate, and loop/recursion depth so a
  crafted input can't run up cost or hang the system.
- **Isolate retrieval data** (LLM08). The vector store is a trust boundary: partition
  embeddings per tenant; validate documents before indexing so poisoned content can't
  steer answers.

### Installing and auditing agent skills (AST01–AST10)

When adding skills, MCP servers, hooks, or plugins to an agent system — including this
godfile — apply these considerations:

- **Malicious skills (AST01)** — trust the publisher or read the code; scan for encoded
  payloads, credential access, and functionality the description doesn't declare; test
  unfamiliar skills isolated before real use; nothing writes to agent identity files.
- **Supply chain (AST02)** — pin skills and dependencies to immutable
  hashes/commits, not version ranges; treat repo files that execute (hooks,
  `.claude/settings.json`, `postinstall`) as code requiring review; know what an install
  will change before it changes it.
- **Over-privilege (AST03)** — least privilege per skill: specific paths over broad
  globs, no unrestricted shell where avoidable, scoped credentials; reads of `.env`, SSH
  keys, or credential stores need explicit justification.
- **Insecure metadata (AST04)** — a skill's description must match what it actually
  does; scan metadata for ASCII smuggling, zero-width Unicode, base64 payloads; safe YAML
  loaders and schema validation before deserialization.
- **Untrusted external instructions (AST05)** — a skill that fetches external docs at
  runtime is an injection vector: prefer inlined content; pin external references to
  content hashes or restrict to vetted domains; review the reference graph transitively.
- **Weak isolation (AST06)** — sandbox where possible; filesystem limited to declared
  paths; control interfaces authenticated and never bound to `0.0.0.0`.
- **Update drift (AST07)** — updates re-reviewed, not auto-trusted; re-scan on change;
  no hot-reload of skill content in production contexts.
- **Poor scanning (AST08)** — pattern-matching alone is insufficient: combine static
  analysis, credential detection (Gitleaks/TruffleHog-class), and behavioral testing;
  evaluate the natural-language instruction layer as well as the code.
- **No governance (AST09)** — keep an inventory (this repo's INDEX.md serves that role:
  source, status, provenance per skill); log/attribute changes; periodic reassessment;
  removal is a first-class operation (`install.sh --uninstall`).
- **Cross-platform reuse (AST10)** — a skill ported to another platform/runtime doesn't
  keep its security properties automatically; re-validate permissions and sandboxing per
  target.

### For this godfile specifically

External material gets adapted, never executed or symlinked verbatim from a remote;
sources are cited in each skill so provenance is auditable; the user reviews placement
before intake (standing rule); and any future skill that instructs agents to fetch remote
content at run-time must pin or vet those references (AST05).

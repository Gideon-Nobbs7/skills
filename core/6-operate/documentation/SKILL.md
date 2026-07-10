---
name: core-operate-documentation
description: Use when creating, organizing, or updating project documentation and knowledge bases in any project — structure knowledge as an OKF bundle (markdown + frontmatter, index.md, log.md, cross-links) so both humans and agents can read, traverse, and maintain it.
status: draft
---

# Documentation & Knowledge

How project knowledge is recorded so that humans and agents can both read, traverse, and
maintain it. The backbone is the **Open Knowledge Format (OKF v0.1)** — markdown files with
YAML frontmatter, self-describing, diffable, portable. Applies to every track: this is a core
skill inherited by all projects.

Source spec: [OKF SPEC.md](https://github.com/GoogleCloudPlatform/knowledge-catalog/blob/main/okf/SPEC.md)

## Areas under consideration
- [] Where docs live — in-repo knowledge bundle, single source of truth
- [] Docs-as-code — diffable markdown, updated with the change, logged
- [] Agent-facing docs — the whole format is agent-consumable by design
- [ ] The required set — README, ADRs, runbooks, API docs: what every project must have
- [ ] ADR format & when a decision earns one
- [ ] CLAUDE.md upkeep specifics — what agents need recorded per project

## Skill

### When documenting a project, structure its knowledge as an OKF bundle

A knowledge bundle is a directory tree of markdown files, usually a `docs/` or `knowledge/`
subdirectory of the repo (a git repo is the preferred distribution — history, attribution,
diffs). Organize subdirectories by whatever grouping fits the domain; the structure itself
carries no required meaning.

### Every concept document gets frontmatter

One markdown file = one concept (a table, an API, a metric, a playbook, a decision — tangible
or abstract). Frontmatter rules:

- `type` is **required** — a short, self-explanatory kind: `API Endpoint`, `Metric`,
  `Playbook`, `Runbook`, `Decision`, `Reference`. Pick descriptive values; there is no
  central registry.
- Recommended, in priority order: `title` (display name), `description` (one sentence —
  used by indexes, search, previews), `resource` (canonical URI of the underlying asset, if
  one exists), `tags` (YAML list for cross-cutting categorization), `timestamp` (ISO 8601
  last meaningful change).
- Add any other producer-defined keys freely; never strip unknown keys when editing a file.

### Write bodies as structural markdown

Favor headings, lists, tables, and fenced code blocks over freeform prose — structure aids
both human reading and agent retrieval. Use the conventional section headings when they
apply: `# Schema` (columns/fields of an asset), `# Examples` (concrete usage), `# Citations`
(external sources — see below).

### Cross-link concepts with markdown links

- Prefer **bundle-relative absolute links** (`/tables/customers.md`) — stable when files move
  within their subdirectory. Relative links (`./other.md`) are acceptable.
- A link asserts a relationship; the surrounding prose says what kind. Don't invent a typed
  link syntax.
- A link to a not-yet-written document is fine — it marks knowledge worth writing, not an
  error. When consuming, tolerate broken links.

### Maintain `index.md` files for progressive disclosure

Any directory (including the bundle root) may carry an `index.md`: no frontmatter (except
optionally `okf_version: "0.1"` at the bundle root), body is grouped sections of
`* [Title](url) - one-line description` entries, pulling each description from the linked
concept's frontmatter. When adding or removing a concept, update the directory's index in the
same change. As a **consumer**, read indexes first and open individual documents only as
needed — don't bulk-read a bundle.

### Record history in `log.md`

A `log.md` at any level records changes to that scope: `## YYYY-MM-DD` date headings, newest
first, bullet entries led by a bold verb (`**Update**`, `**Creation**`, `**Deprecation**`).
When making a meaningful change to a bundle, append a log entry in the same commit.

### Cite external claims

Claims sourced from external material get a numbered list under `# Citations` at the bottom:
`[1] [Source name](url)`. Citations may be absolute URLs, bundle-relative paths, or paths
into a `references/` subdirectory mirroring external material as first-class concepts.

### Consume permissively, produce conformantly

When **writing**, meet conformance: parseable frontmatter on every non-reserved `.md`,
non-empty `type`, reserved filenames (`index.md`, `log.md`) only in their defined roles.
When **reading**, never reject a bundle for missing optional fields, unknown types, unknown
frontmatter keys, broken links, or missing indexes — degrade gracefully and treat unknown
types as generic concepts.

### Docs-as-code discipline

Documentation lives in-repo next to what it describes, is reviewed with the change that
invalidates it, and is updated in the same commit as that change — a doc that can drift
silently is a doc in the wrong place. Update `timestamp` on meaningful edits.

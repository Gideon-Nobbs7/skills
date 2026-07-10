---
name: core-setup-repo-and-tooling-bootstrap
description: Use when standing up or hardening a repo, or making any code change flow through git — trunk-based workflow, atomic commits with why-messages, worktrees for parallel agents, pre-commit hooks, and git-safety guardrails.
status: draft
---

# Repo & Tooling Bootstrap

The first hour of any repo, standardized. Filled so far: commit-time quality gates and
agent git guardrails, adapted from Matt Pocock's `setup-pre-commit` and
`git-guardrails-claude-code` ([source](https://github.com/mattpocock/skills)).

## Areas under consideration
- [x] Pre-commit hooks — formatting, typecheck, tests at commit time (JS/TS baseline)
- [x] Agent git guardrails — blocking destructive git commands via hooks
- [x] Git conventions — trunk-based, atomic commits, branch naming, worktrees
- [ ] Repo layout template per project type
- [ ] Formatter / linter / type-checker configs — the exact baseline files
- [ ] Agent configuration — CLAUDE.md template, which godfile tracks get wired per project
- [ ] Editor/workspace settings worth standardizing
- [ ] Scripts every repo has (`dev`, `test`, `lint`, `build`, …) and what they promise
- [ ] Equivalent pre-commit baselines for non-JS stacks (pre-commit/ruff for Python, …)

## Skill

### Git workflow

(Adapted from Addy Osmani's `git-workflow-and-versioning` —
[source](https://github.com/addyosmani/agent-skills). Release/versioning half lives in
`core-ship-versioning-and-change-communication`.) Git is the safety net: commits are save
points, branches are sandboxes, history is documentation — with agents generating code at
speed, this discipline is what keeps change reviewable and reversible.

- **Trunk-based by default** — main always deployable; short-lived feature branches
  merging within 1–3 days (every day a branch lives it accumulates merge risk); feature
  flags over long-lived branches for incomplete work; release branches acceptable for
  stabilization. Branch naming: `feature/…`, `fix/…`, `chore/…`, `refactor/…`; delete
  after merge.
- **Commit early, atomically** — each successful increment is its own commit doing one
  logical thing (the save-point pattern: test passes → commit; test fails → revert to
  last commit and investigate — you never lose more than one increment). Target ~100
  lines per commit/PR; ~1000+ must be split. Never mix formatting with behaviour or
  refactors with features. Don't squash away the narrative.
- **Messages explain the why** — `<type>: <short description>` (feat/fix/refactor/test/
  docs/chore) with an optional body for intent, not a restatement of the diff.
- **Worktrees for parallel agent work** — `git worktree add ../proj-feature-a <branch>`
  gives each agent its own directory and branch; no switching, isolation until merged, a
  failed experiment is just a removed worktree.
- **Change summaries after any modification** — CHANGES MADE (per file), THINGS I DIDN'T
  TOUCH intentionally (scope discipline made visible), POTENTIAL CONCERNS. The
  didn't-touch section catches wrong assumptions early.
- **Pre-commit hygiene** — review the staged diff; grep it for secrets; tests, lint,
  typecheck (automated below). Commit generated files only when the project expects them
  (lockfiles, migrations); never build output, `.env`, or unshared IDE config; every repo
  has a `.gitignore` covering `node_modules/`, `dist/`, `.env*`, `*.pem` from day one.

### Pre-commit hooks (JS/TS baseline)

Husky + lint-staged + Prettier, plus typecheck and tests at commit time:

1. Detect the package manager from the lockfile (`package-lock.json` npm,
   `pnpm-lock.yaml`, `yarn.lock`, `bun.lockb`); default npm.
2. Install `husky lint-staged prettier` as devDependencies; run `npx husky init`
   (creates `.husky/` and the `prepare: "husky"` script).
3. `.husky/pre-commit` (no shebang needed for Husky v9+), with the detected package
   manager substituted:
   ```
   npx lint-staged
   npm run typecheck
   npm run test
   ```
   If the repo has no `typecheck` or `test` script, omit that line and tell the user.
4. `.lintstagedrc`: `{ "*": "prettier --ignore-unknown --write" }` (`--ignore-unknown`
   skips unparseable files).
5. Create `.prettierrc` only if no Prettier config exists (2-space, 80 cols, double
   quotes, semicolons, es5 trailing commas).
6. Verify: hook file executable, configs present, `npx lint-staged` runs clean. Then
   commit the setup itself — the commit is the smoke test.

Order matters: lint-staged first (fast, staged-only), then the full typecheck and tests.

### Git guardrails for agents

Install a PreToolUse hook that blocks destructive git commands before an agent executes
them: `git push` (all variants), `git reset --hard`, `git clean -f`/`-fd`,
`git branch -D`, `git checkout .` / `git restore .`. The blocked message tells the agent
it lacks authority for these commands.

Setup: ask project scope (`.claude/settings.json` + `.claude/hooks/`) or global
(`~/.claude/...`); place the blocking script, `chmod +x`; register it under
`hooks.PreToolUse` with matcher `Bash`, merging into any existing hooks array rather than
overwriting. Ask whether to add/remove patterns. Verify by piping a fake
`{"tool_input":{"command":"git push origin main"}}` through the script — expect exit
code 2 and a BLOCKED message on stderr. Script reference:
[block-dangerous-git.sh](https://github.com/mattpocock/skills/blob/main/skills/misc/git-guardrails-claude-code/scripts/block-dangerous-git.sh).

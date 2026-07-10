---
name: core-ship-versioning-and-change-communication
description: Use when cutting a release, choosing a version bump, tagging, or writing a changelog — semver as a promise to consumers, when-unsure-assume-breaking, tags as source of truth, human-curated changelogs written with the change.
status: draft
---

# Versioning & Change Communication

How change is numbered and explained. Commits are how *you* track change; a **version** is
how your *consumers* track it — the moment anything depends on your code, "latest on main"
stops answering "what am I running, and is it safe to upgrade?" Adapted from the release
half of Addy Osmani's `git-workflow-and-versioning`
([source](https://github.com/addyosmani/agent-skills)); the workflow half lives in
`core-setup-repo-and-tooling-bootstrap`.

## Areas under consideration
- [x] Versioning policy — semver as contract
- [x] Tagging & release mechanics — tag as source of truth
- [x] Changelog format — keep-a-changelog style, written with the change
- [ ] Semver rigor per project type (strict for libraries; what about apps?)
- [ ] Release notes — audience and tone beyond the changelog
- [ ] Migration guides — when required, the format (ties to `core-operate-sunsetting`)

## Skill

### The version number is a promise

For anything with consumers, `MAJOR.MINOR.PATCH`: major = breaking, consumers must change
code; minor = backward-compatible functionality; patch = backward-compatible fix. Make
the code match the number — a "patch" that changes behaviour consumers relied on is a
major in disguise (Hyrum's Law: check what consumers can *observe*, not the diff size).
**When unsure whether a change is breaking, assume it is** — a surprise major is far
cheaper than a broken consumer.

### The tag is the source of truth

A release is an immutable point in history, not a moving branch: `git tag -a v1.4.0` and
push the tag. Derive the version from the tag rather than hand-editing scattered files,
so the artifact, tag, and changelog can never disagree. A release with no tag, or a
version hand-edited out of sync, is a red flag.

### The changelog is for consumers, not a commit dump

A changelog is not `git log` — it's the curated answer to "what changed and do I care?":
grouped `Added / Changed / Fixed / Deprecated / Removed / Security`, newest first, every
entry phrased around user impact, not internal mechanics. **Write the entry in the same
change that makes the change**, while the impact is fresh — reconstructed-at-release-time
changelogs are half missing. Breaking changes get a migration note and a deprecation
window (`core-operate-sunsetting`); deprecation entries name the replacement and the
removal version.

### Release verification

Bump matches the change (breaking→major, additive→minor, fix→patch); release tagged with
version derived from the tag; changelog has a curated, human-readable entry for this
version.

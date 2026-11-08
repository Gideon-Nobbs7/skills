---
name: grill-me
description: Use when the user has a loose idea worth taking seriously — a feature, product direction, business call, or piece of writing — and wants to align on it before committing. Works on any subject, needs no repo, and fits before any planning. Invoked as /grill-me in a fresh conversation; stateless, writes nothing and leaves nothing behind.
---

# Grill-me

Take a loose idea and interview it until you can commit to it. You don't need a
worked-out plan to start — producing one is what the session is for. Stateless: it
writes no files, touches no workspace, and leaves only a sharper version of the idea.

Port of Matt Pocock's `grill-me` / `grilling`
([source](https://www.aihero.dev/skills-grill-me), [grilling](https://github.com/mattpocock/skills)),
adapted into godfile voice. The repo-bound grilling and planning mechanics live in
`core-setup-planning-and-work-breakdown`; this skill is the stateless, any-subject front
door that runs before them.

## Run the session

- Start in a **fresh conversation**, not on top of a plan an agent already wrote.
- Leave plan mode off — plan mode primes the agent to rush toward a plan, the opposite
  of staying in inquiry.

### Work the idea in rounds

Map the idea as a **design tree** — every decision branches into the decisions that
hang off it. Work the tree in **rounds**. The **frontier** is every question whose
prerequisites are already settled: the ones you can ask now without guessing at answers
you haven't heard. Ask the whole frontier in one round, each question carrying a
**recommended answer** (`➡️`), then wait. One question at a time is the floor; a round
of the settled frontier is the ceiling.

Recompute the frontier after every answer: settled decisions push it outward and
unblock questions that depended on them. A question hinging on an answer still open in
this round belongs to a later round, not this one.

### Facts are yours; decisions are the user's

When a frontier question needs a fact — from a repo, the filesystem, or a tool — look
it up yourself with a sub-agent; don't ask the user for anything you could find. A
running exploration is an unsettled prerequisite, so only questions downstream of it
wait. Put the *decisions* to the user and wait for each.

## The user owns the scope

The skill asks the questions; the user owns the scope. The failure mode is **passivity**
— "agreed, agreed, agreed" for forty questions, then a plan the agent wrote and the user
nodded at. Being active means steering: push back on a question pitched below the
fidelity you need, say when the scope is drifting, and answer "I don't know" and mean it.
"Can't answer" is usually a sign to prototype rather than to guess.

## Stop at ungrillable questions

Some questions can't be answered by talking — "one long form or three pages?", "how
should this interaction feel?" — they need something to react to. When you hit one,
**stop grilling**: build the throwaway version, look at it, then answer in one line.
Talking your way past an ungrillable question is how sessions balloon.

## It's working if

- You disagree with something — a session with no pushback is a session you didn't need.
- Questions arrive in a few rounds, not a long drip, and later rounds build on earlier ones.
- You end somewhere you didn't expect, because a question surfaced a decision you'd been
  making implicitly.
- At the end you could defend each choice to someone who wasn't there.

## Completion and handoff

The session ends when the **frontier is empty**: every branch visited, nothing left
silently assumed. Count rounds, not questions; forty-plus questions across four rounds is
ordinary. Then keep the same conversation going: if the idea is software, hand it
straight to `to-spec` (see `core-setup-planning-and-work-breakdown`), which synthesizes
what you've settled into a spec — don't start a fresh session and lose the context.

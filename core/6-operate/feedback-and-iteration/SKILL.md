---
name: core-operate-feedback-and-iteration
description: Use when closing the loop from shipped software back into scoping, or when operating a growing user community — activity analysis feeding revised scenarios, and human-scaling mechanisms (accountability, partitioning, friction, filters, spam-proofing).
---

# Feedback & Iteration

Closing the loop from shipped software back into scoping — and, for products with
communities, growing the human side without collapse. Community material adapted from
Greenspun et al. — [Scaling Gracefully](https://philip.greenspun.com/seia/scaling)
(human-scaling half; the technical half lives in `backend-setup-service-architecture`).

## Areas under consideration
- [x] Closing the measurement loop into scoping
- [x] Human scaling — community mechanisms for growth
- [ ] Analytics review cadence — what's looked at, how often
- [ ] Feedback channels — how user feedback reaches the backlog
- [ ] Prioritization method — how the next thing gets chosen
- [ ] Experimentation — when A/B testing is worth it, tooling
- [ ] Feeding back into godfile — how lessons learned update these skills

## Skill

### Close the measurement loop

The activity analysis in `core-operate-observability` (three tiers: logs → app events →
warehouse) is the instrument panel. Its output feeds back into
`core-setup-scoping-and-requirements` as revised user classes and scenarios, and it is
how you know — before the collapse — that a technical or social scaling limit is
approaching. You cannot improve, moderate, or scale what you do not measure.

### Human scaling: goodwill doesn't scale, mechanism does

A community of a hundred runs on goodwill; a hundred thousand runs on mechanism. Growth
must follow patterns that preserve what made the small structure work (Alexander,
*A Pattern Language*). The mechanisms:

- **Accountability** — persistent identities and visible contribution histories.
  Anonymity plus scale yields abuse.
- **Partition into neighborhoods** — divide by geography, topic, or affiliation so each
  keeps the density of familiar faces that makes norms enforceable.
- **Friction where emotion runs hot** — deliberate delays before an angry post goes
  live or a flame war escalates; most destructive contributions are impulsive.
- **Filters in both directions** — bozo filters suppress known bad actors without
  banning (they still see their own posts, so they don't escalate); inverse-bozo filters
  surface the consistently valuable so moderator and editorial attention amplifies the
  best rather than merely policing the worst.
- **Spam-proof every member-to-member channel** — posts, messages, profile fields will
  all be used for spam at scale; rate limits, review queues, or reputation gates go in
  *before* abuse, not after.

The measurements above tell you which of these interventions a growing community needs,
and when. The plan for magnet content and contribution/reward mechanisms was made at
setup (`core-setup-scoping-and-requirements`) — this is where it gets operated.

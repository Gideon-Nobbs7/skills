---
name: blogs-build-voice-and-participation
description: Use when drafting blog posts with the user — their words carry the post; the agent supports through the fragments → beats/shape → edit pipeline (mine raw fragments by interview, assemble beat-by-beat with grounding, tighten prose), never ghostwriting.
---

# Voice & Participation

The defining constraint of this track: the user participates actively — their words carry
the post. Agents support; they don't ghostwrite. The support takes the form of a writing
pipeline adapted from Matt Pocock's `writing-fragments`, `writing-beats`, `writing-shape`,
and `edit-article` ([source](https://github.com/mattpocock/skills)) — a process built
around interviewing the user and assembling *their* material, which is exactly the
participation model this track demands.

## Areas under consideration
- [x] The participation model — explore/exploit pipeline where the user's words are the quarry
- [x] What agents may do — interview, capture, assemble, propose, tighten
- [x] Editing etiquette — re-read before every write, preserve user edits absolutely
- [ ] Voice markers — the traits of the user's writing to preserve during any edit
- [ ] The hard line — anything beyond assembly/tightening the user wants reserved

## Skill

### Explore: mine fragments by interview

Pure explore — widen what could be written without committing to structure. Run a
relentless interview about whatever the user wants to write, and as **fragments** emerge
from either side, append them to a single markdown file (H1 working title, fragments
separated by `---`, no other structure). A fragment is anything that might survive into
the final post: a sharp sentence, a claim with a one-line justification, a vignette or
code snippet, a half-thought, a complaint, a punchline. It must be readable by the author,
not self-contained. The most valuable fragment is a **leading word** — a compact metaphor
the whole piece can hang on; when the conversation circles a recurring idea, push to coin
one. Capture from the very first message. Append silently ("adding that"), never
interrupt with save dialogs; re-read the file from disk before every write and preserve
the user's edits; "cut the last one", "merge those two" are first-class instructions.

### Exploit: assemble the pile into a post

The pile is fixed; commit to a path through it. Two modes, both governed by **grounding**:
every concept must be grounded — the reader walked in knowing it (a **prerequisite**,
settled with the user first) or an earlier passage introduced it — before a later passage
leans on it. The unit is the concept, not the word. Keep a running grounded list; the
prerequisite-vs-introduce split is the big lever (demand too much up front and readers are
shut out; ground too much inside and the opening drowns in definitions).

- **Beats** (choose-your-own-adventure): offer 2–3 candidate starting beats, each a
  different entry point, each only leaning on grounded concepts and noting what it
  grounds. User picks; write *only that beat*; re-read from disk; offer 2–3 reachable
  next beats. A beat is one move — sets a scene, lands a point, twists the angle — sized
  by what it needs (a sentence to a few paragraphs; needing subheadings means it's two
  beats). Never write ahead. The post ends when the journey completes, not when the pile
  empties — leftover fragments are the point.
- **Shape** (paragraph-by-paragraph): read the pile end-to-end (read-only); draft 2–3
  candidate openings each implying a different thesis; the pick defines what the rest
  must do. Then grow by asking "what does the reader need to hear next?", mining the pile
  as a quarry (split, merge, paraphrase — the post reads as one voice). Argue format
  choices out loud: prose carries argument, lists carry parallel items; callouts only for
  genuine derailments; a table when the same shape repeats 3+ times; quote when the
  wording is the point. Push back — "if I cut this, what breaks?", "the opening promised
  X, we've drifted to Y". If the pile lacks something, name the gap: "give me an example
  now or we cut this section."

### Edit: tighten without replacing the voice

Divide the draft into sections; information is a DAG — order sections so dependencies are
respected; confirm the sections with the user before rewriting. Then tighten for clarity,
coherence, and flow, keeping paragraphs short. Edits are proposals on the user's words,
not substitutions of them.

### The etiquette that holds it together

The user's words are the quarry and the product; the agent interviews, captures,
assembles, and tightens. Re-read the working file from disk before every write; never
overwrite the user's edits; append or edit the specific passage asked about, leaving the
rest alone.

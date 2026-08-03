# Reference: full catalog of AI-writing tells

Companion to `SKILL.md`. Load this when you want the exhaustive list — every
category from Wikipedia's [Signs of AI
writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing), mirrored
in full, plus the flagged-vocabulary list, the tells that *don't* work, and the
ones models have since outgrown. Source is CC BY-SA 4.0.

Important caveat, straight from the source: these are *signs*, not proof. Human
writers use every one of these constructions sometimes. The tell is
**clustering** — many of them, densely, in text that also says little. A single
em dash or one "moreover" means nothing. Judge the whole, not the word. And read
§ "Ineffective indicators" below before you accuse anything (or over-scrub your
own draft) — several popular "AI tells" are worthless.

---

## 1. Content and meaning

| Tell | What it looks like | Fix |
| --- | --- | --- |
| Undue emphasis on significance | "marks a pivotal moment", "stands as a testament", "reflects broader trends" | State the fact; let it carry its own weight |
| Notability puffery | Listing every outlet that mentioned the subject; "active social media presence" | Cite the best source once; drop the rest |
| Superficial analysis | Trailing "-ing" clauses that assert synthesis: "…, highlighting its impact" | Cut the clause or back it with evidence |
| Promotional language | Travel-brochure adjectives; press-release tone | Describe neutrally |
| Vague attribution | "experts suggest", "observers argue", "studies show" — no name | Name the source or delete the claim |
| Challenges/future-prospects formula | "Despite challenges… poised to play a growing role" | Stop when the content ends |
| Improper lead / definition | Treating a list title or broad topic as a proper noun to be "defined" | Discuss the subject directly |

## 2. Language and grammar

- **Copula avoidance:** *serves as, functions as, stands as, features, boasts*
  instead of *is / has*.
- **Negative parallelisms:** *not only X but also Y*; *not X, but Y*; *X rather
  than Y* used as reflexive filler.
- **Rule of three:** tripled adjectives/clauses (*strategic, efficient, and
  sustainable*) regardless of what the meaning needs.
- **Elegant variation:** cycling synonyms to avoid repeating a word (*artist →
  creative practitioner → visual theorist*) until it reads as thesaurus abuse.
- **Filler transitions:** sentence-initial *Moreover, Furthermore,
  Additionally, In conclusion, It is important to note that.*

### Flagged vocabulary (high-frequency AI words)

These words are not banned — they cluster in AI text. If several appear on one
page, look hard.

> additionally, align (with), aims to, boasts, bolster, capture (the essence),
> commitment to, complex/complexity, comprehensive, crucial, cutting-edge,
> delve, demonstrate, dive into, elevate, emphasize, enduring, enhance, ensure,
> essential, evolving, fascinating, folks, foster, framework, functionality,
> garner, groundbreaking, holistic, in the realm of, interplay, intricate,
> journey, keen, landscape, leverage, meticulous, moreover, navigate,
> nestled, notably, nuanced, paradigm, pivotal, profound, realm, renowned,
> resonate, rich (tapestry/heritage), robust, seamless, showcase, significant,
> stands as, streamline, tapestry, testament, underscore, unleash, unlock,
> unwavering, vibrant, vital

## 3. Style and formatting

- Title Case in headings ("Impact Of Technology") instead of sentence case.
- Excessive boldface for emphasis ("key takeaways" style) mid-prose.
- Inline-header lists: **Term:** description, **Term:** description — when the
  content is really prose.
- Em-dash overuse for emphasis or clause separation.
- Tables in odd places or with unconventional layout.
- Curly/smart quotes where the document uses straight quotes (or vice versa).
- Heading levels skipped (H2 → H4).
- Horizontal rules / thematic breaks placed right before headings.

## 4. Markup and technical

- Markdown (`**bold**`, `*italic*`) left in a context that uses different markup
  (e.g. wikitext `'''bold'''`).
- Broken wikitext: unclosed brackets, malformed templates, invalid syntax.
- **Leaked machine tokens** — the clearest artifacts of all, because no human
  types them. The model spills its own internal citation/scaffolding markup into
  the text:
  `contentReference`, `oaicite`, `oai_citation`, `attached_file`, `grok_card`,
  `+1`, `:::writing`, `attribution`, `attributableIndex`. Any of these in a
  document is near-proof of unedited LLM output. Strip them.
- `utm_source=` and other UTM tracking parameters left in citation URLs.
- References to things that don't exist: fake shortcuts, invented policies or
  templates, nonexistent categories, out-of-place categories.

## 5. Citations

- Broken or dead external links.
- Invalid or mismatched DOIs / ISBNs.
- DOIs that resolve to an unrelated article.
- Book citations with no page number or URL.
- Named references declared in the reference list but never cited in the body.
- Incorrect or unconventional reference use generally.

## 6. Communication aimed at the reader (text a model forgot to strip)

- **Collaborative boilerplate:** "This is high-quality, good-faith content
  adhering to all policies." / "I welcome feedback and am open to suggestions."
- **Knowledge-cutoff disclaimers:** "As of my last update…"; speculation about
  gaps in the sources.
- **Phrasal templates / placeholder text:** "[citation needed]",
  "[example needed]", "insert X here", "[Author's name]" left in the output.
- **Emoji** used as section markers or emphasis.

## 7. Miscellaneous (mostly Wikipedia-workflow context)

- **Pronounced shift in writing style:** prose that starts human and abruptly
  turns formulaic (or vice versa) within one document — a sign of paste-in AI.
- **Overwhelmingly exhaustive edit summaries:** unnaturally long, itemized
  change descriptions that explain every edit.
- **AfC "submission statements":** verbose pre-written notes about notability and
  sourcing attached to a draft submission.
- **Pre-placed maintenance templates:** the author tags their own text with
  citation/quality banners, anticipating objections rather than letting a
  reviewer find them.
- **Permissions gaming:** hedging language or templates placed to pre-empt
  specific policy objections.
- **Differences between LLMs:** models have distinct fingerprints — e.g. Grok
  overuses "causal"; GPT-4o and Gemini favor different phrasings. Don't expect
  one signature.

## 8. Indicators in comments / discussion posts

Beyond the collaborative boilerplate in §6, AI-written talk-page comments show:

- **Canned calls to focus on content, not conduct** — redirecting away from the
  behavior being questioned.
- **Complaints that accusers are "acting on speculation"** — without engaging
  the substance.
- **Canned requests for source assessment** — asking the accuser to evaluate
  specific sources instead of answering the concern.
- **Confusion over why a draft was declined** — responses that address a reason
  that wasn't the actual one.
- **Email-like subject lines** and **section titles rendered as plain text**
  rather than proper markup.
- **Transcluding maintenance banners** into a comment as if they were citations.
- **Non-existent policies / shortcuts** and **wikilawyering**, e.g. invoking
  `WP:PRESERVE` to resist any content removal.

---

## Ineffective indicators — signs that DON'T work

Read this before accusing anything, or before scrubbing your own draft. Several
widely trusted "AI tells" are unreliable and can flag skilled humans. False
accusations drive away good writers; check yourself for confirmation bias first.

- **Perfect grammar** — plenty of humans write clean prose; many are
  professionals.
- **Mixed casual + formal / "clinical yet emotional" register** — common in
  people from technical fields, younger writers, neurodivergent writers, or any
  page edited by several people.
- **"Bland" or "robotic" prose** — subjective, and real AI output actually skews
  *positive and verbose*, not flat.
- **"Fancy", "academic", or "formal" prose** — the AI correlation is with
  *specific words*, not with formal-sounding writing in general.
- **Letter-like formatting in isolation** — salutations, sign-offs, and subject
  lines predate LLMs; newer editors write this way for ordinary reasons. Only a
  tell when stacked with stronger ones.
- **Transition words in isolation** — only a handful are AI-overused, and essay
  writers have always used them; weak on its own.
- **Unsourced content** — 570,000+ articles predating LLMs lack citations, and
  modern chatbots often *add* citations (accurate or not).
- **"Bizarre" wikitext / stray HTML** — usually browser extensions, the content-
  translation tool, or VisualEditor mistakes, not AI.
- **Correct wikitext** — normal for anyone using the visual editor or Preview.

## Historical indicators — mostly aged out

Common in ~2023-era models, rare now. Still useful for spotting *old* undetected
AI edits, but don't expect them from current models.

- **Didactic disclaimers (Nov 2022–2024):** unprompted "it's important to note"
  safety/controversy caveats aimed at an imagined reader.
- **Section summaries:** appended "Conclusion" sections and paragraphs that
  restate their own core idea.
- **Prompt refusal:** "I'm an AI language model and can't help with that,"
  sometimes followed by an answer to a nearby different question.
- **Abrupt cut-offs:** text that stops mid-sentence from a token limit.
- **Outdated `access-date` parameters:** citation access dates that predate when
  the text could plausibly have been written.

---

## On detection accuracy (why this is guidance, not a test)

The source is candid about limits:

- Automated AI detectors have **non-trivial error rates** and are easily fooled
  by light editing.
- Unaided human judgment is near **chance**.
- Experienced reviewers using LLMs heavily reach ~90% accuracy — but still
  produce **false positives**.
- Ordinary human language is increasingly **shaped by exposure to LLMs**, so the
  patterns blur over time.

Practical upshot: don't write for the detector. Write something specific, in a
voice that's yours, and cut whatever only pads. That beats every tell here at
the source — most of them are just what nothing-to-say looks like.

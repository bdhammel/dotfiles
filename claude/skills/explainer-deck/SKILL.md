---
name: explainer-deck
description: "Build a talk-through slide deck that teaches a technical audience how a method works: what the model looks like, how it consumes their data, what it produces, and what the first results show. Visual-first, with build sequences that add one component per slide. Use when asked for slides, a deck or a presentation that explains a model, pipeline or proposal, or to turn a proposal or write-up into slides. Builds a claude.ai Slides artifact in a fixed house style."
argument-hint: "[source docs or links] [--audience \"...\"] [--title \"...\"]"
---

# Build an explainer deck

**Summary.** An explainer deck walks a technical audience through a method one picture at a
time. They leave knowing what the model looks like, how it reads their data and what it
produces. It carries only the highlights of its sources. Every mechanism gets a build
sequence: the same diagram over several slides, one component added per slide.

**Arguments:** "$ARGUMENTS"

## Before you begin

- Read `~/.claude/rules/writing.md`. Its voice governs every line of slide copy.
- Read the sources in full, through the right connector: a Claude Doc through the Claude Docs
  connector, never a web fetch. List every number you might show, with where it came from.
- Read `reference/style.md`, `reference/patterns.md` and `checklist.md` in this folder.

## Steps

1. **Start the artifact.** Call `Artifact` with `action: "quickstart"` and `intent: "slides"`,
   then publish with the Slides `type_url`, a `title` and `auto_open: "after_first_write"`.
   Read the type's `format.md`, `diagrams.md` and `layout.md` once before the first slide.
2. **Write the outline as titles.** One sentence-case title per slide, each a short statement
   of what the slide shows. Read the titles alone: they must tell the story. Share the list in
   chat before writing slides, but do not wait for approval.
3. **Mark every build sequence.** Any mechanism with three or more parts that act in order is
   a build: data preparation, a training step, a loss. Plan its final diagram first, then cut
   it into slides that each add one part. `reference/patterns.md` has the recipe.
4. **Write files into the scratchpad.** The `root` must sit under the scratchpad or the working
   directory, or the publish is refused. Write `project/deck.json` with the full `order`, then
   the cover, and publish both. Then write three or four slides per message and publish each
   batch.
5. **Copy images server-side.** For an image in another artifact, call `Artifact` with
   `asset: true`, `from_url` and `asset_ids`, then read each copy once to learn its size and
   what it shows. Never retype a chart that exists as an image.
6. **Check the arithmetic before each publish.** For every pinned element, confirm that
   `top + height` stays at or under 952 and that each box is wider than its longest word.
   The type forbids render checks unless the user asks, so the source numbers are the check.
7. **Report** the link, the slide count by section, what is illustrative, and what you did
   not view rendered.

## Communication rules

These rules come from decks the user approved and from the corrections they made.

- **Teach, then report.** Order the deck as the audience needs it. Start with what we
  propose, how we read their data and how the model learns. Then cover what it produces, the
  deliverables and the practicalities, and end on results. Results come last, because they only land once the mechanism is understood.
- **One idea per slide, shown not told.** A slide is a diagram, a table, big numbers or a
  card row. Paragraphs belong in the source document, not on the slide.
- **Carry one worked example through each sequence.** For example, follow one user's four
  events on one day from raw rows to the model's output. Label every invented value as
  illustrative, on the slide.
- **Numbers come from the source only.** Derive nothing new for a slide. A rough figure such
  as "thousands of events a month" is the error to avoid: check it against the source total.
- **Cut what the audience already knows.** A line that restates how the audience's own
  data is collected adds nothing for a technical audience, so leave it out.
- **Show the spread, not a verdict.** Prefer a median and a 90th percentile per band to a
  "usable: yes or no" column built on a threshold you chose. If a threshold stays, state it
  on the slide as an assumption.
- **One name per thing.** Never reuse a label for two roles. If two halves are A and B, the
  items in the batch are 1, 2, 3 and 4.
- **Define a term where it first appears.** Put the range in brackets, as in "low-support
  (0–20%) cells", or define it in the line under the table.
- **Frame a plan as a gated path.** For staged work, say what each stage delivers on its own
  and what gates the next. A gate reads like "Advances when it beats your method at an agreed
  bar". A path is not a commitment to deliver every stage.
- **Put the one takeaway in a callout.** The point the presenter must land goes in the
  highlight box from `reference/style.md`, never in plain body text.

## Revising a deck

Edit only the slide files that the change touches, then publish those files alone. Send
`project/deck.json` only when the order, title or sections change. When the deck's version
number jumps between your publishes, someone edited it in the editor. If a publish is refused,
read the files it names and redo your edit on top of theirs.

# How to write for Ben and his readers

**Summary.** Write the way one expert writes to another: technical in what you include,
approachable in how you order and lay it out. Five principles own every rule here, and
each one removes a cost the reader would otherwise pay:

- **Assume expertise:** the reader never rereads what they already know.
- **Order for understanding:** the reader meets a concrete case before the abstraction.
- **Lower decoding cost:** each sentence and page is cheap to parse.
- **Keep claims checkable:** the evidence for each claim sits on the page.
- **End on action:** each result arrives as what the reader does next.

When two rules conflict, the precedence order decides. Rules marked *(explanations)* apply
only to explanations, proposals, analyses and study write-ups.

## Who reads this and where the rules apply

Ben is the first reader of most of what you write. He is an expert on this codebase and has
severe dyslexia. Fragmented prose is harder for him to follow, not easier, so make text
readable through structure, and let each sentence carry a complete, connected thought. He
knows the domain better than you, and he does not know names you coined today. When the
reader is someone else, such as a client's technical team, pitch to their expertise in the
same voice.

These rules apply to everything you write: Markdown files, CLAUDE.md and AGENTS.md, PR and
commit bodies, Jira tickets, plan files, artifacts and other rendered pages, documents
written for clients, and chat replies. They do not apply inside code fences or inline code,
and in an artifact they govern the copy, not the HTML and CSS around it. The
*(explanations)* rules cost the most writing time, so a PR body or chat reply skips them.

## Resolve a conflict by moving content, never deleting it

Content rules outrank form rules, so a form rule can move evidence to an appendix or a
table but never cut it.

1. **Keep claims checkable** decides what must appear on the page.
2. **End on action** decides what the page concludes with.
3. **Assume expertise** decides what to leave out.
4. **Order for understanding** decides the sequence.
5. **Lower decoding cost** decides the form: a sentence, a table, a figure or an appendix.

For example, **Check a derivation against a measurement** needs a derived value, and
**One line of argument** wants derivations out of the main text. The derived value, the
measured value and their ratio stay in the main text, and the derivation steps move to the
appendix.

## Assume expertise

Spend the reader's attention only on what is new to them.

1. **Write as a peer.** The default register is one technical team writing to another.
   Compact technical prose is fine for dense material such as arithmetic or specs. Never
   adopt a teaching tone that walks the reader through what they already know.
2. **Explain only what is new to the reader.** Never define standard terms of the reader's
   field, such as precision, recall, ROC or one-hot encoding. Spell out an acronym only
   when the reader may not know it. Gloss a term you coined the first time it appears, in
   half a sentence.
3. **Be concrete.** Name the work by its technical substance, such as "a two-stage
   retrieval pipeline with a cross-encoder reranker", not by its motion, such as `where
   we'd begin and how we'd iterate towards better search`. Use the verb with its actor,
   "your team runs the scripts", not a noun made from it, `the ability to run the scripts
   stays with your team`. Never route a point through "the way you'd…".
4. **No decorative analogies, idioms or filler transitions.** Use precise technical
   language, such as objective, negatives or pooling, and cut transitions such as `along
   the way`. An everyday metaphor reads as talking down, and an idiom costs a reader with
   dyslexia a second pass. An in-field comparison is allowed when the precise statement
   follows it, such as neurons as basis vectors. An everyday analogy, such as momentum as
   a ball rolling downhill, is allowed only when **Start from the reader's account**
   states it in order to correct it.
5. **Describe the subject, not the process.** Write the document as a description of the
   thing as it is, never as a record of the conversation, the decision or the code history
   that produced it. Cut `previously`, `we discussed`, `as of PR 1234`, and labels such as
   `What we settled` or `Outcome`. A decision record states its decision as a present fact.
   Replace a wrong claim, a superseded threshold or a lapsed limit with the current one,
   and never mention the old value or add text that corrects it.

## Order for understanding

Put the point first, then a concrete case, then the generalisation. Order and concreteness
make technical writing approachable, never an informal register.

6. **Thesis first.** The first sentence of a file, section or paragraph is the point, and
   it says how it follows from what came before, such as "Anchors help only if evidence
   links unknown cells to them, and pretraining supplies it". A proposal opens on what it
   proposes. A one-line map can open a section of mixed content. Put framing, such as why
   the document exists, at the end in its own short paragraph, and never open with a
   lead-in that comments on the writing itself.
7. **Start from the reader's account.** When the reader already holds an account of the
   subject, state it after the thesis, show the case it fails to explain, then give the
   correction. The account can be a belief, such as "retrieval misses come from the
   embedding model", or a default output, such as a posterior mean that lands at the centre
   of a ring of solutions, a point the ring does not include.
8. **Show a mechanism on its simplest case.** When a passage explains how a method behaves,
   trace one concrete case step by step, starting from the smallest case that still shows
   the mechanism, such as one number with two towers over two days. Then add one
   complication per step and name what it changes. Writing the case is also how you find a
   claim that does not hold.
9. **Carry one case through the document** *(explanations)*. Each section adds one
   complication to the same case, because a fresh example per section makes the reader
   rebuild the setting before they see what changed. The case is a real one from the
   reader's domain, not a story.
10. **One line of argument in the main text.** Move derivation steps, proofs and secondary
    caveats into a footnote or an appendix, so that each section reads straight through.
    Results, checks and any limit that changes the reader's decision stay in the main text.
    In a paper, the method sections describe the chosen method in terms that hold on any
    dataset, and measured counts live in the results. Alternatives, out-of-scope data and
    sweeps go to appendices that the main text names once.

## Lower decoding cost

Make every sentence and page cheap to parse, because Ben has severe dyslexia and every
reader scans.

11. **One true link per sentence.** When one idea causes, qualifies or completes another,
    join them with "so that", "because" or "which means", and never split a thought into
    fragments. Use a link only when the relation is true. A second "so", "which" or
    "because" starts a new sentence. Aim for sentences under about 25 words, as a
    guideline rather than a cap: a longer sentence is fine when it carries one connected
    thought.
12. **Short paragraphs.** One topic per paragraph, at most 7 sentences.
13. **Bold labels mark parallel items, never an argument.** Lead a bullet or paragraph
    with a short bold label only when it is one of several items of equal weight, such as
    trial results or label tests, and let the sentences after it flow. An argument runs as
    paragraphs whose sentences say why each fact matters to the last, such as "These
    errors matter because…". A run of labelled two-sentence paragraphs reads as fragments.
14. **Lists and tables by job.** Numbered lists for sequences, bullets for unordered sets,
    tables for lookup. Rules that map a case to an outcome get a table with a **Why**
    column, so that each rule carries its reason. Keep asides out of lists, and keep a
    table cell under 30 words.
15. **Parallel items get parallel form.** When a passage names several questions, options
    or stages of equal weight, give each its own bold-label bullet with the same shape.
    Never leave the last one as a trailing clause, such as "…, and then extend it to
    mobile".
16. **Headings state the finding.** In an explanation, a heading states what the section
    shows, such as "Cluster sizes in a t-SNE plot mean nothing". A heading can instead be
    the reader's question when the section's first sentence answers it. In a how-to, it
    names the task. A white paper or proposal uses numbered section names, such as
    "3.1 Trusted cells", and its first sentence states the finding. Never "Overview",
    "Notes", "Details" or "Misc".
17. **Summary first, each commitment once.** A file over 60 lines opens with a **Summary**
    block as its whole introduction, and never a "Who this is for" section, because that
    cue belongs in the index that links to the file. The Summary states each scope,
    condition or promise in one sentence. The same sentence never repeats in the Summary, a
    section opening and an appendix.
18. **Plain mechanics.** Active voice, present tense, "you", and imperative mood for steps.
    Bold for emphasis, never ALL CAPS, underline or nested parentheses. Never `above`,
    `below`, `aforementioned` or `the former`: name the thing.
19. **One name per thing.** Use the name the code uses, and never two names for one
    concept. A **Terms used here** table is optional, and usually not worth it.
20. **Frame each equation in prose.** Before an equation, say what it computes. Define
    every symbol directly after it, then say what the result means for the system. Leave
    the equation out when one sentence states the same fact. When the method also exists as
    code, show the smallest code whose lines map onto the equation's terms.

### Figures

21. **Draw the structure, then explain it.** Put a figure before the prose when the content
    has one of these shapes, because Ben reads a layout faster than he decodes the same
    facts from sentences.
    - **Components with connections:** three or more get a box-and-arrow diagram.
    - **Messages between actors:** three or more actors get a sequence diagram.
    - **States and transitions:** a state diagram.
    - **Numbers compared across conditions:** a chart when the reader needs the trend, and a
      table when the reader needs the values.
    - **A data shape through stages:** a diagram with the dimensions on its edges, such as
      `28 days × tokens → 128-d`.
    - **A model:** its architecture, never a flow chart of steps. Show which inputs run in
      parallel, which weights are shared and what each stage keeps.
    - **A before and after:** two panels side by side.
22. **The caption states the finding.** The sentence before a figure says what to look at,
    such as "the `E_tower` table appears at both input and output", never how to scan it,
    such as `read the figure left to right`. The caption states what the figure shows,
    such as "the within-day split puts M1 and M2 in different halves", never only what it
    contains, such as "Figure 2: splits". Keep a diagram to about 12 nodes, and split a
    bigger one into two figures.
23. **Use the format that renders where the text lands, and look at it.** Pick the format
    from this table.

    | Where the text lands | Format |
    |---|---|
    | Terminal chat reply | A box diagram of at most 8 boxes in a code fence, because the terminal does not render Mermaid |
    | `.md` file in a git repo | A `mermaid` code block, which GitHub renders and which diffs as text |
    | Artifact or other rendered page | Inline SVG, following the `artifact-diagramming` skill, and charts following `dataviz` |
    | Google Doc | A rendered PNG, because the Drive connector does not render Mermaid |
    | A design worked out together with Ben | A shared board from `/sketch-it` |

    Render every figure and read the image, because the source hides overlaps, distorted
    distances, panels that differ in more than what they compare, and content crowding an
    edge. The Mermaid command runs from any directory, needs no venv, and writes one PNG
    per block:

    ```bash
    npx -y @mermaid-js/mermaid-cli -q -s 2 -e png -i doc.md -o "${CLAUDE_JOB_DIR:-$TMPDIR}/fig.md"
    ```

## Keep claims checkable

Put the evidence for each claim on the page, so that the reader checks it instead of
trusting it.

24. **Mark an interpretation as one.** State a measurement or a derivation as fact. When a
    sentence reads meaning into evidence, mark it once as an interpretation, such as "the
    gap suggests the encoder keeps the home tower", and name the result that would settle
    it. A plan and a measured number never carry this mark.
25. **Label a conjecture and number its evidence** *(explanations)*. When the main point of
    a document is a conjecture, state it up front as a labelled claim, then give each piece
    of evidence as a numbered argument. A reader can then judge each argument alone.
26. **Check a derivation against a measurement.** When a number can be both derived and
    measured, state both next to each other with their ratio, and treat a gap as a finding.
    Order-of-magnitude agreement is not a check, because it cannot catch a missing factor
    of 2.
27. **Show the output of a real run.** A claim about how code behaves shows the observed
    output, and includes the failing run when the fix is the point, such as the batch-size
    change that drops accuracy from 63% to 18% before the learning-rate fix restores it.
28. **Show a sweep when the result depends on a parameter.** Give one table row or figure
    panel per parameter value, never a single setting, because one setting can show a
    pattern the others contradict. For example, t-SNE draws random noise as dramatic
    clusters at perplexity 2.
29. **State limits as scope, never softened.** Name the limits of your own approach next to
    the limits of the data, and say plainly what fails, such as "the sixth item is dropped
    even when relevant". State a limit the reader already knows as the method's scope. When
    an obvious workaround exists, say whether it works. Show candour in the content and
    never assert it, as in `we're candid about our limits`.
30. **Never send the reader away mid-sentence.** State the fact here in one line, then
    link. Ticket ids, section numbers, line numbers and people's remarks are not
    explanations. For an outside reader, describe an internal deliverable by what it does
    and give its code only in a citation. Restate a finding from work they cannot see as a
    measurement on their own data.

## End on action

Convert each result into what the reader does next.

31. **Give the reason as what the choice buys.** State each choice with the result it buys
    or the risk it removes, such as "caching the index cuts query latency from 2 s to
    50 ms", not "caching makes search better". In a plan or proposal, say what each step
    delivers on its own.
32. **End an analysis on the decision** *(explanations)*. Convert the final result into the
    action it supports, in the reader's units, such as "a 23% match rate means analysts
    review 230 of every 1,000 candidates". The decision follows from the number, and any
    decision rule it depends on is stated as an assumption.
33. **Commit to what you propose.** Write the plan in the declarative, "we build" or
    "we train", never `we'd`, `we hope` or `we'd like to`, because conditional verbs read
    as unsure. Keep `we'd` only for a true conditional whose condition is in the same
    sentence. Never state the outcome of unbuilt work as fact, such as `we locate each
    tower` before the locator exists, and write "we propose a head that locates…". Put
    real uncertainty in a stated limit instead.
34. **Commands show where they run.** Every command shows the directory it runs from and
    the venv or env file it needs.
35. **Procedures start ready.** Every procedure has a **Before you begin** block, at most
    10 steps of at most 20 words each, and the expected output after any step whose result
    is not obvious.

## Change these rules without breaking them

Each rule does one principle's job, and this file holds every threshold, so that the
`write-doc` checklist and Vale never disagree with it.

- **A new clause joins the rule it serves.** If a clause fits no principle, revise the
  principles before appending it.
- **Each rule stays at most 6 lines with one short inline example,** not counting tables
  and code. Longer examples go in `~/.claude/rules/writing-examples.md` as a before and
  after.
- **Check each example.** A rule's example is a claim, so recompute its numbers before you
  commit it.
- **Cite a rule by its bold label, never its number,** so that renumbering breaks nothing.

## Before you finish

Read the prose once and check each principle.

- **Assume expertise:** no standard term is defined, every coined term is glossed, and no
  everyday metaphor, idiom or filler transition remains. The document describes the subject
  in the present, with no narration of how it was produced.
- **Order for understanding:** the first sentence of each section is the point and says
  how it follows from the section before, and no section opens with a lead-in about the
  writing. Every explained mechanism has a worked case that starts from its simplest form.
  In an explanation, one case runs throughout.
- **Lower decoding cost:** no sentence holds two links, few run past about 25 words, no
  paragraph exceeds 7 sentences, and no sentence is a fragment that the next one
  finishes. Parallel items have parallel form, and bold labels mark only parallel items.
  Headings state findings, questions or tasks. Every equation is framed and every symbol
  defined. Every figure trigger has a figure whose caption states the finding, and you
  read the rendered image.
- **Keep claims checkable:** each interpretation is marked once, and no plan or measured
  result is hedged, and no unbuilt work is described as done. Every derived-and-measured
  number shows both values and their ratio, every behaviour claim shows real output, and
  every parameter-dependent result shows a sweep. Every limit says what fails.
- **End on action:** every analysis ends on the decision its result supports, in the
  reader's units. Every command shows where it runs.

A `PostToolUse` hook runs Vale on every `.md` you write. It flags filler words, hedged
plans, pointers off the page, ALL CAPS and nested parentheses, but not sentence length.
Fix what it reports, except a `we'd` in a true conditional whose condition is in the same
sentence.

For a new or rewritten document, use the `write-doc` skill, which carries the templates.
Worked before-and-after examples are in `~/.claude/rules/writing-examples.md`.

These rules exist because an explanation is paid for either once by the writer or again by
every reader. Distill's "Research Debt" essay calls this interpretive labor: "each member of
the audience pays the cost of understanding, even though the cost of explaining stays the
same." The same essay gives the test behind the worked-case rules: "if we can't explain an
idea well, that's often a sign that we don't understand it as well as we could."

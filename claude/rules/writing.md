# How to write for Ben and his readers

Write the way one expert writes to another: direct, technical and easy to scan. Ben is the
first reader of most of what you write. He is an expert on this codebase and has severe
dyslexia. Fragmented prose is harder for him to follow, not easier, so make text readable
through structure, such as the point first, bold labels and bullets for emphasis, and let
each sentence carry a complete, connected thought. He knows the domain better than you, and
he does not know names you coined today. When the reader is someone else, such as a client's
technical team, pitch to their expertise in the same voice.

These rules apply to everything you write: Markdown files, CLAUDE.md and AGENTS.md, PR and
commit bodies, Jira tickets, plan files, artifacts and other rendered pages, documents
written for clients, and chat replies. They do not apply inside code fences or inline code,
and in an artifact they govern the copy, not the HTML and CSS around it.

## Voice

1. **Write as a peer.** The default register is one technical team writing to another.
   Compact technical prose is fine for dense material such as arithmetic or specs. Never
   adopt a teaching tone that walks the reader through what they already know.
2. **Give the reason as what the choice buys.** State each choice with the result it buys
   or the risk it removes, such as "caching the index cuts query latency from 2 s to
   50 ms", not a vague benefit such as "caching makes search better". In a plan or
   proposal, say what each step delivers on its own. Never define standard terms of the
   reader's field, such as precision, recall, ROC or one-hot encoding, and spell out an
   acronym only when the reader may not know it.
3. **Be concrete.** Name the work by its technical substance, such as "a two-stage
   retrieval pipeline with a cross-encoder reranker", not by its motion, such as `where
   we'd begin and how we'd iterate towards better search`. Use the verb with its actor,
   "your team runs the scripts", not a noun made from it, `the ability to run the scripts
   stays with your team`. Never route a point through "the way you'd…".
4. **Commit to what you propose.** Write the plan in the declarative, "we build" or
   "we train", never `we'd`, `we hope` or `we'd like to`, because conditional and hopeful
   verbs read as unsure of the work. Keep `we'd` only for a true conditional whose
   condition is in the same sentence, such as `if the second GPU is approved, we'd run
   both experiments at once`. Put real uncertainty in a stated limit instead.
5. **No analogies, idioms or filler transitions.** Use precise technical language, such
   as objective, negatives or pooling, and cut transitions such as `along the way`. A
   metaphor reads as talking down to a technical reader, and an idiom costs a reader with
   dyslexia a second pass.
6. **One true link per sentence.** When one idea causes, qualifies or completes another,
   join them in one sentence with "so that", "because" or "which means", and never split a
   thought into fragments. Use a link only when the relation is true, so check that the
   clause after "so" follows from the clause before it. A sentence carries one link, and a
   second "so", "which" or "because" starts a new sentence.
7. **State limits as scope.** Name the limits of your own approach next to the limits of
   the data or the system. When the reader already knows a limit, state it as the scope of
   the method, such as "where its results can be trusted", not as a warning. Show candour
   in the content and never assert it, as in `we're candid about our limits`.
8. **Show a mechanism with a worked example.** When a passage explains how a method
   behaves, such as what a cache evicts or what a training objective keeps, follow the
   claim with one concrete case, such as one request or one user's records, that traces
   it step by step. Writing the example is also how you find a claim that does not hold.
9. **Describe the subject, not the process.** Write the document as a description of the
   thing as it is, never as a record of the conversation, the decision or the code history
   that produced it. Cut `previously`, `we discussed`, `as of PR 1234`, and reflective
   labels such as `What we settled` or `Outcome`. A decision record still states its
   decision as a present fact, not the story of how it was reached.

## Structure

10. **Thesis first.** The first sentence of a file, section or paragraph is the point. Put
    supporting examples in bold-label bullets after it, and what we do about it last. A
    one-line map is an acceptable first sentence for a section that holds several kinds of
    content. Put framing, such as why the document exists, at the end in its own short
    paragraph, and never open with a lead-in that comments on the writing itself.
11. **Bold labels for scanning.** Lead a bullet or paragraph with a short bold label so the
    reader can scan, and let the sentences after it flow. Use bullets for points of
    emphasis and paragraphs for arguments, where each sentence builds on the last.
12. **Lists and tables by job.** Numbered lists for sequences, bullets for unordered sets,
    tables for lookup. Keep asides out of lists.
13. **Parallel items get parallel form.** When a passage names several questions, options
    or stages of equal weight, give each one its own bold-label bullet with the same shape.
    Never leave the last one as a trailing clause, such as "…, and then extend it to
    mobile".
14. **Short paragraphs.** One topic per paragraph, at most 5 sentences.
15. **Headings that inform.** Headings say what the reader can do or learn there. Never
    "Overview" or "Notes".
16. **Summary first, each commitment once.** Put a **Summary** block at the top of any file
    over 60 lines, as the file's whole introduction. Never add a "Who this is for" section,
    because that cue belongs in the index that links to the file, a README or a CLAUDE.md.
    The Summary states each scope, condition or promise in one sentence and the body gives
    its detail. The same sentence never repeats in the Summary, a section opening and an
    appendix.
17. **Plain mechanics.** Active voice, present tense, "you", and imperative mood for steps.
    Bold for emphasis, never ALL CAPS or underline. Never `above`, `below`,
    `aforementioned` or `the former`: name the thing.

## Self-contained pages

18. **One name per thing.** Use the name the code uses. Gloss a term you coined the first
    time it appears, in half a sentence. A **Terms used here** table is optional, and
    usually not worth it.
19. **Never send the reader away mid-sentence.** State the fact here in one line, then
    link. Ticket ids, section numbers, line numbers and people's remarks are not
    explanations.
20. **Commands show where they run.** Every command shows the directory it runs from and
    the venv or env file it needs.
21. **Procedures start ready.** Every procedure has a **Before you begin** block, at most
    10 steps, and the expected output after any step whose result is not obvious.

For a new or rewritten document, use the `write-doc` skill. It carries the templates.
Worked before-and-after examples are in `~/.claude/rules/writing-examples.md`.

## Before you finish

Read the prose once and check these:

- The first sentence of each section is the point, and no section opens with a lead-in
  about the writing.
- Each sentence holds at most one link, and every "so" or "because" is true.
- No sentence is a fragment of a thought that the next sentence finishes.
- Parallel items have parallel form, and no scope, condition or promise is stated twice.
- Every explained mechanism has a worked example.
- The document describes the subject in the present, with no narration of the conversation,
  the decision or the code history that produced it.
- No standard term is defined, and no metaphor, idiom, hedge or filler transition remains.

A `PostToolUse` hook runs Vale on every `.md` you write. It flags filler words, hedges,
pointers off the page, ALL CAPS and nested parentheses. Fix what it reports, except a
`we'd` in a true conditional whose condition is in the same sentence.

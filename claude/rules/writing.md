# How to write for Ben and his readers

Write the way one expert writes to another: direct, technical and easy to scan. Ben is the
first reader of most of what you write. He is an expert on this codebase and has severe
dyslexia. Fragmented prose is harder for him to follow, not easier, so make text readable
through structure, such as the point first, bold labels and bullets for emphasis, and let
each sentence carry a complete, connected thought. He knows the domain better than you, and
he does not know names you coined today. When the reader is someone else, such as a client's
technical team, pitch to their expertise in the same voice.

These rules apply to everything you write: Markdown files, CLAUDE.md and AGENTS.md, PR and
commit bodies, Jira tickets, plan files, documents written for clients, and chat replies.
They do not apply inside code fences or inline code.

## Voice

1. **Write as a peer.** The default register is one technical team writing to another.
   Compact technical prose is fine for dense material such as arithmetic or specs. Never
   adopt a teaching tone that walks the reader through what they already know.
2. **State the choice and the reason.** Never define standard terms of the reader's field,
   such as precision, recall, ROC, one-hot encoding or false-discovery rate. Spell out an
   acronym only when the reader may not know it.
3. **No analogies or idioms.** Use precise technical language, such as objective, negatives
   or pooling. A metaphor reads as talking down to a technical reader, and an idiom costs a
   reader with dyslexia a second pass.
4. **Say what you do directly.** Never route a point through "the way you'd…", and keep
   asides out of lists.
5. **Join linked ideas.** When one idea causes, qualifies or completes another, put them in
   one sentence with "so that", "because" or "which means". Never split a thought into
   fragments. Split a sentence only when it holds two separate ideas.
6. **Be candid.** Name the limits of your own approach next to the limits of the data or
   the system. In a proposal or plan, say what each step delivers on its own.

## Structure

7. **Thesis first.** The first sentence of a file, section or paragraph is the point. Put
   supporting examples in bold-label bullets after it, and what we do about it last. Put
   framing, such as why the document exists, at the end rather than the start.
8. **Bold labels for scanning.** Lead a bullet or paragraph with a short bold label so the
   reader can scan, and let the sentences after it flow. Use bullets for points of emphasis
   and paragraphs for arguments, where each sentence builds on the last.
9. **Lists and tables by job.** Numbered lists for sequences, bullets for unordered sets,
   tables for lookup.
10. One topic per paragraph, at most 4 sentences.
11. Headings say what the reader can do or learn there. Never "Overview" or "Notes".
12. A **Summary** block at the top of any file over 60 lines. That block is the file's whole
    introduction. Never add a "Who this is for" section. The one-line cue about who opens
    the file belongs in the index that links to it, a README or a CLAUDE.md.
13. Active voice, present tense, "you", and imperative mood for steps. Bold for emphasis,
    never ALL CAPS or underline. Never `above`, `below`, `aforementioned` or `the former`:
    name the thing.

## Self-contained pages

14. One name per thing, the name the code uses. Gloss a term you coined the first time it
    appears, in half a sentence. A **Terms used here** table is optional, and usually not
    worth it.
15. Never send the reader away mid-sentence. State the fact here in one line, then link.
    Ticket ids, section numbers, line numbers and people's remarks are not explanations.
16. Every command shows the directory it runs from and the venv or env file it needs.
17. Every procedure has a **Before you begin** block, at most 10 steps, and the expected
    output after any step whose result is not obvious.

For a new or rewritten document, use the `write-doc` skill. It carries the templates.

## Before you finish

Read the prose once and check these:

- The first sentence of each section is the point.
- No sentence is a fragment of a thought that the next sentence finishes.
- No standard term is defined, and no metaphor or idiom remains.

A `PostToolUse` hook runs Vale on every `.md` you write. It flags filler words, pointers off
the page, ALL CAPS and nested parentheses. Fix what it reports.

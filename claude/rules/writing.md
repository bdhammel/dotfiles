# How to write for Ben and his readers

These rules apply to all prose you write: documents, Claude Docs, PR and commit bodies,
beads, Jira tickets and chat replies. Code and inline code are exempt. The `writing-review`
skill holds the detailed checklist and the worked examples. Before you deliver a document,
such as a Markdown file, a Claude Doc or a Google Doc, run the `writing-review` skill on the
document and fix what the skill reports. Chat replies, commit messages, PR bodies and beads skip the review.

**The reader.** Write for a reader who is an expert in the field and has never seen your
work, such as the referee of a journal paper. That reader knows the field's methods and
standard terms, so never explain them. That reader has not seen your experiments, your data
or your working session, so name each of them in full. Ben is the first reader of most of
what you write. He knows the domain better than you do. He has severe dyslexia, so connected
sentences and clear structure help him, and fragments make text harder for him to read.
He reads a figure or a table faster than the same facts in sentences, so draw any structure
before the prose that explains it.

1. **Describe the subject literally.** Cut analogies, idioms and filler. Describe the subject
   as it is now, never the conversation or the history that produced it.
2. **Name everything explicitly.** Name each thing by what it is, never by an ID from the
   work, so write "the experiment on data scaling", never "the experiment" or "run 7b". Use
   one name for each thing, and coin as few terms as you can. Never use "this", "that",
   "these", "those", "it" or "which" on its own to refer back to an idea or an earlier
   sentence. Name the referent instead, as in "this hyperparameter sweep shows", not "this
   shows".
3. **Subject and conclusion first, example next.** The first sentence of a document names its
   subject in words the reader knew before opening the document, such as "This document
   compares two retrieval pipelines on support-ticket search". The second sentence states the
   conclusion. Each later section and paragraph opens on its conclusion and says how that
   conclusion follows from the paragraph before. When you explain how a method works, follow
   the conclusion with one worked example on the smallest real input that shows the method at
   work, such as one support ticket passing through both pipelines. Then give the general
   rule.
4. **One connected thought per sentence.** When one idea causes, qualifies or completes
   another, join the two ideas with the word that names the relation, such as "because" or
   "so that". Never join two ideas with a semicolon, and never split one thought into
   fragments. Finish the subject, verb and object before any aside. Give a definition its own
   sentence, and put a short label in parentheses.
5. **Keep claims checkable.** Put the evidence next to each claim: the number, the output of
   a real run, or the source. Mark an interpretation as one, and state each limit plainly as
   what fails. Never describe unbuilt work as done.
6. **End on the answer to the question asked.** Close each result by answering the question
   the work was run to answer, in the reader's units, such as "a 23% match rate means
   analysts review 230 of every 1,000 candidates". Recommend a decision only when the reader
   asked for one.

When two rules conflict, move content instead of cutting it. Evidence can move to a table or
an appendix, but evidence never leaves the page.

**Decisions for Ben.** Protect Ben's time by putting a decision to him only when only he can
make it: approving spend or a GPU-day, touching a client deliverable, clearing a security or
compliance gate, or choosing scope. Make every other decision yourself with a safe, reversible
default, and state the default in the reply as an assumption he can override. When a chat
reply needs a decision from Ben, end the reply with a horizontal rule and a
`## ❓❓ Decisions for you` heading, so that the decisions are the last thing on screen and
stand apart from earlier lists. Number each question and put it in bold, so that Ben can
answer with "1 yes, 2 no". Under each question, give your recommendation and why, because Ben
asks for a recommendation on every decision put to him.

```markdown
---

## ❓❓ Decisions for you

1. **Run the 24k-step training, which costs one GPU-day?**
   - Recommendation: no. Why: the 12k-step run already beats the baseline by 0.13 recall@10,
     so a longer run can widen the margin but cannot change the decision to ship.
```

**Actions for Ben.** Ask Ben to do a step only when you cannot or should not do the step
yourself: a sign-in that needs his browser, a permission you lack, such as a post in a channel
you may not use, or a change to his own setup that he did not ask for. Do every other step
yourself. When a chat reply needs such a step, put a `## 👉👉 Actions for you` block after the
horizontal rule and directly above the decisions block, or alone when the reply has no
decisions, so that every ask sits at the end of the reply. Number each action and write it in
bold as the exact step, such as a command to run with `!`. Under each action, say why only Ben
can do it, what it unblocks, and whether it blocks the work or can wait.

```markdown
---

## 👉👉 Actions for you

1. **Run `! git -C ~/dotfiles switch master && git -C ~/dotfiles merge --ff-only origin/master`.**
   - Why: the checkout is behind master, and catching up also changes your live shell config,
     so the timing is yours. Nothing waits on it.
```

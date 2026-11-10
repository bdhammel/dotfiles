# How to write beads

**Summary.** A bead, an issue in the `bd` tracker, is a message to an agent that cannot ask
you questions, so write it for that reader. A bead holds one theme's verifiable outcome that
a fresh agent can reach in one context, never a single step or a lone finding. A finding
found by chance joins the bead on its theme before it gets one of its own. Every bead has a
brief that Ben reads and a detail layer that the agent reads. Run labels say how Claude runs
the bead, because an effort size measures human work. A close reason states the result
itself, so that Ben reviews the result without opening a log. The `bead` skill adds the
workspace, the tracker used for other people's issues, and worked examples from real threads.

## Pick the bead's shape by who reads it

Beads serve three readers, and each needs a different amount of text.

| Reader | Shape | What it must carry |
|---|---|---|
| Your own next session, on a thread you are running | Self-tracking | A session-sized scope, an `--acceptance` check, and `--parent` / `--deps` for order |
| A subagent you spawn now | Subagent brief | The goal, the scope fence, what is already ruled out, and what to return |
| An agent with no prior context | Cold-start handoff | The full template in "Templates", anchored to a commit, because the code will drift |

All three share four habits, because they decide whether the reader can act alone:

- **The title is the outcome,** such as "CSV export reads off the event loop", not the
  activity, such as "look at CSV export".
- **Acceptance is a check that a command can run,** such as "`make test` exits 0 and
  `export_csv` makes no blocking call". Put it in `--acceptance`, never only in prose.
- **State what is ruled out,** with the evidence, so that the reader does not repeat a
  dead end.
- **Point at evidence,** such as a file and line, a commit, a log query or a run id, never
  "as discussed".

## Write each bead in two layers: a brief for Ben, then the detail for the agent

Ben reads the brief on the board to learn what the work is for and where it stands, and he
opens the detail only when he wants to. The agent reads both layers, because the brief tells
it what the work is for and so which choices would pass the check but miss the goal. Write
the brief in Ben's terms, and leave every path, flag, commit id and name coined in a session
to the detail. That keeps the brief readable cold and keeps the detail complete.

| Layer | Field | What to write | Writing rule it applies |
|---|---|---|---|
| Brief | Title | The outcome in plain words, as in the first habit | **Headings state the finding** |
| Brief | `kind:<kind>` and run labels | One kind from the next table, a `ben:` label, and `wait:` or `mode:` when they apply | Lets Ben filter the board, such as every one-shot he can launch tonight |
| Brief | `## Summary`, first in the description | One to three sentences: the problem in Ben's terms, what the bead changes, and what that unblocks or decides | **Thesis first**; **Give the reason as what the choice buys** |
| Brief | `--acceptance` | The definition of done as one check, or one item per line when the theme carries several. For an experiment, the decision rule fixed before the run, such as "B ships if recall@10 beats the baseline by 0.05 or more" | **End an analysis on the decision** |
| Brief | `Needs from Ben:` list and the `needs:ben` label | One bullet per question that only Ben can answer, with the options, in the newest dated note or the close reason. Remove the label once he answers | **End on action** |
| Brief | Close reason | The result, as in "Close a bead with its result" | **Keep claims checkable** |
| Detail | `## Context`, `## Already known` | Facts with the commit or date they were true at, and what has been ruled out with its evidence | **Point at evidence** |
| Detail | `## Location`, `## Verify first` | Files and functions, the directory and venv each command runs from, and the command that shows the problem still exists | **Commands show where they run** |
| Detail | Dated notes | `bd update <id> --append-notes "<date>: <state and next step>"`, one entry per session. The board shows the newest entry as the current state | **Describe the subject, not the process** |

| Kind | Use it when the bead… |
|---|---|
| `experiment` | trains, runs or scores a model and reports a number |
| `analysis` | answers a question from existing data, runs or code, without a new training run |
| `feature` | adds behaviour to code |
| `bugfix` | corrects wrong behaviour or a wrong number in code |
| `labeling` | produces or audits labels or gold data |
| `doc` | writes or updates a document, a figure or a doc tab |
| `decision` | waits on a person's decision, approval, review or merge |
| `ops` | deploys, moves data, provisions infrastructure or requests access |

For example, a brief reads: "Retraining the reranker on identical inputs changed a third of
its top-1 picks, so no reranker number can be quoted yet. This bead makes the reranker's
decision the same across 5 seeds and reports the spread across seeds. The launch review
needs that before it cites a reranker number." The early-stopping metric, the file and line,
and the run directory belong in the detail.

`bd lint <id>` reports a missing `## Summary` or acceptance check. The board also marks a
bead with ⚠ when it has no kind or `ben:` label, when its summary holds paths, flags or
commit ids, or when an experiment's result opens without a number. Run `bd lint <id>` before
you hand a bead to anyone.

## A bead is one theme that fits one context

A fresh agent must reach the bead's outcome in one context, starting from the bead alone.
Test the upper bound when you file it: if the bead needs two unrelated acceptance checks or
more than one PR, it is too big, so split it. A bead is also at least one theme: the outcome
Ben would name in a status update, such as "every reranker run is reproducible and checks
its own validation curve". Related checks on one theme are one bead with several acceptance
items, because each extra bead makes a fresh session read the same code and thread again.
Split a theme, and planned work, only at these boundaries, because a split anywhere else
creates handoffs that cost more than they save.

| Split here | Why | Example |
|---|---|---|
| Where a fresh session would start with cleared context | The next session reads the bead, not the chat | Port the code and pass the regression in one bead; run the prod job in the next |
| Where the next part needs only a summary of the part before | The upstream close reason becomes the downstream input | "Find the cause" closes with the file and line; "Fix it" starts from that reason |
| Where parts can run in parallel | Each subagent or session takes one bead | Score three folds as three beads, one per subagent |
| Where someone else's decision, approval or gate blocks the next step | `bd ready` holds the downstream work back only while the gate is an open bead | "Get the design decision" and "Clear the security review" each block the prod run |

The steps inside one bead, such as edit, test, lint and commit, are never beads. Track them
in the session's own task list, or in the bead's notes when they must survive compaction. A
wait on CI, a review or a deploy is a boundary only when the session ends during the wait or
another person must act.

A follow-up that you find by chance, such as a one-line bug spotted mid-task or a point from
a PR review, is always tracked, because untracked it is forgotten. Track it in the first
place that fits:

1. **The bead you are working on,** when the finding shares its theme. Add it to that bead's
   acceptance.
2. **An open, unclaimed bead on its theme,** which `bd search` under the same epic finds.
   Append it there.
3. **A new bead,** one for every finding on that theme, such as all the points from one PR
   review, never one bead per finding.

Two guards stop a fold from costing more than the split it saves:

- **The upper bound wins.** A finding joins a bead only if it lands in that bead's PR and
  leaves its run labels unchanged. A finding that adds a second PR, raises the `ben:` level
  or adds a `wait:` gets its own bead.
- **Never fold toward more Ben.** A finding that a command decides (`ben:none`) never joins a
  `ben:plan` or `ben:pair` bead, because the one-shot would then wait for an approval it does
  not need. When it needs that bead's outcome, add a blocks dependency instead.

When you add an item to a bead's acceptance, append a dated note that names it, so that Ben
sees that the definition of done grew after he read it.

## Run labels say how Claude runs a bead

Beads carry run labels instead of an effort size, because writing code costs Claude about
the same at any size. What changes how a bead is run is who decides that it is done, when
Ben must be present, whether the session waits on compute, and whether the hard part is depth
or breadth. Every bead except an epic or a `kind:decision` gate carries one `ben:` label. Add
`wait:` and `mode:` only when they apply, because their absence is the default.

| Label | Use it when | What the implementer does |
|---|---|---|
| `ben:none` | A command in `--acceptance` decides done, such as a test, a row-for-row diff or a merged PR | Runs it as a background job; Ben skims the PR or close reason |
| `ben:review` | Claude can finish alone, but the result is a reading that Ben must judge before anything builds on it, such as a diagnosis or an experiment's number | Runs unattended and closes with a result headline, which Ben reviews on the board |
| `ben:plan` | A wrong approach wastes a GPU-day, touches a client deliverable, or meets a fork only Ben can choose | Writes the approach as a dated note, adds `needs:ben`, and stops before code or compute |
| `ben:pair` | The context is in Ben's head, such as a client constraint, an unstated preference or a design worked out together | Runs only in a live session with Ben, never as a background job |
| `wait:short` | The session blocks on something under about 30 minutes, such as CI, a dev job or a short eval | Stays in the session and waits with Monitor |
| `wait:long` | The session blocks for hours, such as training, a prod job, a backfill or another person's review | Appends the run id or PR as a note before waiting, so that a fresh session can read the result; never runs two GPU beads at once on a shared GPU |
| `mode:ultrathink` | The hard part is reasoning in one context, such as a cause nobody has found, a decision rule to design, or results to interpret | Starts the session with `ultrathink` |
| `mode:ultracode` | The work splits into three or more independent parts, each a context's worth, such as many files or repos, a sweep or several review lenses | Starts the session with `ultracode` and runs a workflow; parts that share one GPU or one file gain nothing |

A **one-shot** is a bead with `ben:none` and neither `wait:` nor `mode:`, and the board marks
it with its own chip. A bead too large for one context is split, or marked `mode:ultracode`
when its parts can run in parallel. A bead whose spec is unclear and that does not need Ben
is written as a `kind:analysis` bead first, whose close reason becomes the spec.

| Bead | Run labels | Why |
|---|---|---|
| Two rows with the same timestamp sort the same way in either input order | `ben:none` | A unit test decides it, so it is a one-shot |
| A missing value gets its own embedding bucket | `ben:plan` | A new bucket changes the vocabulary and invalidates trained checkpoints, which is Ben's call |
| The new pipeline rebuilds a table row for row | `ben:none wait:short` | A row diff decides it, after a dev build |
| The reranker gives the same decision across seeds | `ben:review wait:long mode:ultrathink` | The unstable early stopping needs a diagnosis, then a five-seed retrain, and the spread needs judging |
| The next model trains on one of two label schemes | `ben:pair wait:long mode:ultrathink` | The scheme is Ben's choice, and training takes hours |

When unsure between two `ben:` values, pick the one that involves Ben more, because a bead
that stalls on a missing decision costs more than a plan he approves in a minute.

## A thread of work is one epic

Ben runs several threads at once, such as a prod run, a review and a doc, often in parallel
sessions. Each thread is one epic, so that `bd epic status` lists every thread with its
progress, and a session resumes a thread from the epic instead of from chat history.

- **One epic per thread.** A thread is work with an end that spans sessions. Before you
  create an epic, run `bd search "<keywords>"` and continue an existing thread if one matches.
- **Labels go on the epic,** because children inherit them at creation: `repo:<name>` when
  the thread lives in one repo, and `area:<slug>` for the long-running area. Run
  `bd label list-all` and reuse an existing area label before you coin one.
- **The epic holds the thread's state.** Its description states the goal, the worktree and
  branch, and links to PRs and docs. At the end of each session, append one dated line, such
  as `bd update <epic> --append-notes "<date>: fold 1 scored; next: open PR"`.
- **Claim children, never the epic.** Every session runs as Ben, so a claim cannot tell
  sessions apart. Before you claim a child, check that it is not already in progress, and
  append the worktree you are working in as a note.
- **Park and finish explicitly.** `bd defer <epic> --until <date>` hides a parked thread and
  its children from `bd ready`. Close a finished epic with a reason that states its result,
  and `bd epic close-eligible` closes epics whose children are all done.
- **Memories point at the epic.** A project memory names the epic id and leaves the status in
  the bead, so that the two never disagree.

A follow-up that belongs to no thread is a standalone bead with an `area` label. When your
own work crosses a split boundary, make it an epic with one child per session-sized piece,
so that `bd ready --parent <epic>` shows the next piece. Write each child's description for
the session that will start it, because by then the context that filed it is gone.

```bash
epic=$(bd create "CSV export is async" -t epic -l repo:<repo>,area:export --silent)
a=$(bd create "export_csv runs off the event loop, with route, tests and PR" --parent "$epic" \
     -l kind:feature,ben:none --acceptance "make test exits 0 and the PR is open" --silent)
b=$(bd create "Load-test the async export on dev" --parent "$epic" --deps "$a" \
     -l kind:experiment,ben:review,wait:short --acceptance "p95 export latency is reported for 1k, 10k and 100k rows" --silent)
bd update "$a" --claim
bd close "$a" --reason "PR <repo>#123 at 3f2c1ab; asyncio.to_thread offload; 202 + job id"
```

## Close a bead with its result and its follow-ups

Ben reviews results on the board, which reads the close reason as the bead's outcome. For an
experiment, "done" means a result that Ben still has to review, so the close reason states
the result itself. A "PR merged" line or "see the log" does not give him the result. The
close reason has up to four parts:

1. **Headline:** the first line states the number or finding, what it was compared against,
   and the decision it supports under the rule in the acceptance check. The board shows this
   line in every list, so it must stand alone.
2. **Evidence:** a table when there are several arms, folds or classes. Mark any reading of
   the numbers as an interpretation, and name only the limits that change the decision. Then
   link each deliverable: a PR as `repo#N`, a doc URL or tab, or a run directory.
3. **Follow-ups:** a `Follow-ups:` line, then one bullet per suggested next step. Each bullet
   names the bead that carries it, an existing bead on the same theme when there is one.
   Write `Follow-ups: none` when there are none.
4. **Needs from Ben:** a `Needs from Ben:` line, then one bullet per open question with its
   options, when the result leaves a decision that only Ben can make.

```bash
bd close <id> --reason "$(cat <<'EOF'
Reranker B 0.71 vs BM25 0.58 recall@10 on the dev split (+0.13), rule met: B ships.

| Arm | Steps | recall@10 |
|---|---|---|
| BM25 | n/a | 0.58 |
| B | 3k | 0.68 |
| B | 12k | 0.71 |

The gain from 3k to 12k steps suggests B has not converged; a longer run would settle it.
Code <repo>#37; log: the experiment log's reranker tab.

Follow-ups:
- <id> holdout on next month's queries

Needs from Ben:
- Is a 24k-step run worth one GPU-day? Yes: file it under the epic. No: B ships at 12k.
EOF
)"
```

The board flags every follow-up bullet without a bead id as unfiled, so name the bead that
carries any step you would otherwise only mention. File a new one only when no bead on its
theme is open. It lists each `Needs from Ben:` bullet in its
**Waiting on you** inbox. A closed bead counts as awaiting review until Ben adds the
`reviewed` label with the board's **Mark reviewed** button, so never add that label yourself.

## Templates

### Subagent brief

When you hand a task to a subagent, file the bead first and make its description the brief.
Claim the bead yourself before you spawn, because claims are per actor and every agent runs
as Ben. Then pass the subagent the id with these instructions:

> Your task is bead `<id>`. Run `bd show <id>` and follow it. Append progress with
> `bd update <id> --append-notes "..."`. When done, run `bd close <id> --reason "<finding>"`,
> where the finding states the result with its links and ends with a `Follow-ups:` list,
> and return the same finding. If you are blocked, append the blocker as a note and return
> without closing.

```markdown
## Summary
<The goal in one to three sentences, written for Ben as well as the subagent.>

## Scope
In: <files, modules, question>. Out: <what not to touch or chase>.

## Already known
<What you have ruled out, with evidence, and the facts the subagent should trust.>

## Return
<The exact shape you want back, such as "the file and line of the cause, and one sentence
on why", or "a table of endpoint, latency before, latency after".>
```

Parallel subagents can each write their own bead, because concurrent `bd create` calls all
succeed. Read results back with `bd show <id>` after the subagents return.

### Cold-start handoff

Deferred work gets the full description, a `repo` label and the run labels. Write the
description to `${CLAUDE_JOB_DIR:-$TMPDIR}/bead-<slug>.md`, then file it:

```bash
bd create "<outcome title>" -t task|bug|chore -p <0-4> \
  -l repo:<repo>,kind:<kind>,ben:<none|review|plan|pair>[,wait:<short|long>][,mode:<ultrathink|ultracode>] \
  --acceptance "<runnable check>" \
  --body-file "${CLAUDE_JOB_DIR:-$TMPDIR}/bead-<slug>.md" --silent
```

`repo` is the main repo's name, never a worktree's. Priority 2 is the default, 0 is critical
and 4 is backlog. Add `--deps discovered-from:<id>` when the follow-up came out of another
bead. Report one line, such as "Tracked **<id>** — <title>", then return to the core work.

The reader has no memory of this session, so anchor every claim to something it can check.

```markdown
## Summary
<One to three plain sentences: what changes and why it matters.>

## Context
<Where this came up and why it matters. State the commit or date the facts were true at,
such as "as of <repo> 3f2c1ab".>

## Objective
<One sentence: what "done" looks like.>

## How it runs
**`ben:<value>`** because <who or what decides done>. <`wait:` and `mode:` with one reason
each, or "One-shot.">

## Location
- `path/to/file.py` — `function_or_class`

## Already known
<Facts established and approaches ruled out, each with its evidence.>

## Suggested Approach
1. <step>

## Verify first
<The command that shows the problem still exists, because the code may have moved on.>
```

These rules live in a public repo, so every example in this file is generic. Examples
drawn from real work, the workspace location and the tracker for issues that other teams own
stay in the `bead` skill.

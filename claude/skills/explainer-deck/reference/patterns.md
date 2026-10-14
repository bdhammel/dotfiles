# Slide patterns

An explainer deck reuses about ten layouts. Pick the layout from what the content is, and
write the snippets from `style.md` into it.

## Pick the layout from the content

| The content is | Layout |
|---|---|
| A mechanism with ordered parts | Build sequence, 3 to 6 slides |
| Three parallel questions, limits or options | Card row of three, with a navy summary strip |
| A staged plan with gates | Pinned diagram in two regions, gate labels in eyebrow orange beside the arrows |
| One headline result | Navy slide with two numbers at 200px, result against baseline |
| A single message to remember | Blue statement slide, one 72px line and one 32px line |
| A setup or a cost | Row or 2×2 grid of big-number tiles |
| A deliverable | Key-facts rows on the left (960px), a visual card on the right (640px) |
| Numbers across bands or items | A table of 5 rows or fewer, or horizontal bars on one baseline |
| A result that exists as a figure | The image on the left, at its own aspect ratio, with 2 or 3 stats beside it |
| What happens next | Numbered cards, one step each |

## The build sequence

A build shows a mechanism the way a presenter explains it: one part at a time on a diagram
that never moves. A masked-training build, for example, runs over six slides. They show a
window of tokens, one token hidden, the transformer, a dot product with the output table, a
softmax and the loss.

1. **Draw the final slide first.** Place every box of the finished diagram on a grid and note
   it in a comment, such as `<!-- tok1 128,310,320,110  trans 128,480,1664,90 -->`.
2. **Give every element a stable `id`.** The same element carries the same `id` and the same
   coordinates on every slide where it appears.
3. **Cut backwards.** Each earlier slide is the final one with the later parts removed. Each
   slide adds exactly one part, and its title names that part as an action, such as "Hide
   15% of the tokens".
4. **Change state in place.** When a part changes, such as a token becoming MASK, keep its `id`
   and position and change only its fill and words.
5. **Set the transition.** Put `data-transition="magic"` on every slide of the build except
   the last, so that shared elements glide while new ones appear. When the layout changes
   completely between two steps, such as a diagram turning into a matrix, drop the transition
   on that step.
6. **Use the free space early.** On the first slides the lower half is empty. Put one sentence
   there that the later parts will replace, so the slide does not look unfinished.

Good builds from past decks:

- **Data preparation:** raw records, then the units the model reads, then one input window.
- **Token construction:** one row looked up from each field's table, then the sum. Add a note
  on what happens to an input the table has never seen.
- **Masked training:** tokens, mask, transformer, dot product, softmax, loss.
- **Contrastive training:** split a window into halves, encode each half, a similarity matrix
  over the batch, then the loss on one row.

## Space budget

The canvas is 1920 × 1080 with 128px margins, so content runs from y 300 to y 952.

- **Header:** the eyebrow, title and subtitle end at about y 300.
- **Text height:** lines × font size × line height. Add padding for a box.
- **Text width:** about 0.6 × font size per character, so a 28px line holds about 60
  characters in 1,032px.
- **Callouts and strips:** a two-line strip at 28px with 28px padding is about 134px tall, so
  start it at y 800 or higher up.
- **Overflow:** when content does not fit, shrink secondary text to 24px or nudge blocks up.
  Never shrink the takeaway.

# The house style

Every explainer deck uses this palette, these typefaces and these snippets, so that decks
look alike and the audience learns the visual code once.

## Palette and type

Colour carries meaning, so each colour keeps one job across the deck.

| Token | Hex | Job |
|---|---|---|
| Navy | `#14213D` | Headings, dark slides, the model's core box, callout strips |
| Off-white | `#F5F4F0` | Content slide background, text on navy |
| White | `#FFFFFF` | Cards, tables, image backgrounds |
| Blue | `#2F6FB0` | Inputs, data, the first half of a pair |
| Blue tint | `#DCE8F5` | Fill for blue boxes |
| Orange | `#D9622B` | The thing being hidden, highlighted or scored |
| Orange tint | `#FBE3D6` | Fill for orange boxes and the takeaway callout |
| Light orange | `#F2A57A` | The second half of a pair, accents on navy |
| Eyebrow | `#B4501F` | Eyebrow labels and gate labels on light slides |
| Body | `#3E4A5C` | Subtitles and body text |
| Muted | `#6A7280` | Labels, connectors, notes |
| Rule | `#C8CDD5` | Card borders |

- **Typefaces:** IBM Plex Sans for all text, and IBM Plex Mono for field names, table
  rows and code identifiers. Load both in `deck.json` `faces` with Google Fonts links.
- **Type scale:** 96 cover, 56 slide title, 40 card title, 32 lead line, 28 body, 24 labels.
  Nothing goes below 24px.
- **Backgrounds:** off-white for content slides. Navy is for the cover and the headline
  result slide, and blue for one statement slide per deck.

## Snippets

**Header block.** Every content slide opens with these three pinned lines at the same
positions, so the title never moves between slides. A title holds 49 characters at most; the
subtitle holds two lines.

```html
<p style="position:absolute;left:128px;top:104px;width:1664px;font-size:24px;font-weight:600;letter-spacing:3px;color:#B4501F">SECTION · 2 OF 6</p>
<h2 style="position:absolute;left:128px;top:144px;width:1664px;font-size:56px;font-weight:600;line-height:1.1;color:#14213D">Hide 15% of the tokens</h2>
<p style="position:absolute;left:128px;top:224px;width:1600px;font-size:28px;line-height:1.35;color:#3E4A5C">One or two sentences that say what to look at.</p>
```

**Diagram box.** Swap the fill and border for blue (input), orange (highlighted) or navy with
light text (the model).

```html
<div id="tok1" style="position:absolute;left:128px;top:310px;width:320px;height:110px;display:flex;flex-direction:column;justify-content:center;align-items:center;gap:4px;background:#DCE8F5;border:2px solid #2F6FB0;border-radius:12px"><p style="font-size:30px;font-weight:600;color:#14213D">Step 1 · input</p><p style="font-size:24px;color:#3E4A5C">one short detail line</p></div>
```

**Connector.** Edge midpoint to edge midpoint, 3px muted. Use `head="none"` for bus segments.

```html
<x-connector x1="288" y1="420" x2="288" y2="480" style="color:#6A7280;border-width:3px"></x-connector>
```

**Takeaway callout.** The one point the presenter must land.

```html
<p style="position:absolute;left:760px;top:748px;width:1032px;font-size:26px;line-height:1.4;padding:24px 32px;background:#FBE3D6;border:2px solid #D9622B;border-radius:12px;color:#14213D"><b>The one point to land.</b> One or two sentences of evidence.</p>
```

**Summary strip.** A navy band across the bottom that ties a card row together.

```html
<p style="position:absolute;left:128px;top:796px;width:1664px;font-size:28px;line-height:1.4;padding:28px 40px;background:#14213D;color:#F5F4F0;border-radius:16px">Every experiment is scored against your own methods.</p>
```

**Big-number tile.** Size the number so it fits its tile: about 0.6 × font size per character.

```html
<div style="flex:1;display:flex;flex-direction:column;gap:8px;padding:40px;background:#FFFFFF;border:2px solid #C8CDD5;border-radius:16px"><p style="font-size:80px;font-weight:600;line-height:1;color:#14213D">1.2B</p><p style="font-size:28px;line-height:1.4;color:#3E4A5C">records in the training month</p></div>
```

**Key-facts row.** Stack four of these for a deliverable: what it produces, what it is
compared with, what it needs, and when it advances. Colour the last label with the eyebrow
colour.

```html
<div style="display:flex;gap:24px;padding:22px 0px;border-top:2px solid #DAD7CF"><p style="width:240px;font-size:24px;font-weight:600;letter-spacing:2px;color:#6A7280">PRODUCES</p><p style="flex:1;font-size:28px;line-height:1.4;color:#14213D">What this stage delivers on its own</p></div>
```

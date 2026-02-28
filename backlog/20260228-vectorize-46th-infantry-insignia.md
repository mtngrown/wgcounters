---
id: BL-0005
title: Create proper vector paths for 46th Infantry insignia
type: task
status: backlog
value: 4
effort: 4
urgency: 1
risk: 3
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: []
area: counter-art
adr_refs: []
links: []
labels: [art, insignia]
---

## Why

The 46th Infantry Regiment counter currently embeds a JPG image (`original/46_INF_RGT_DUI.jpg`) because automated bitmap-to-vector tracing (potrace) produced poor quality results. Embedded JPGs don't scale cleanly at sheet size (0.2 scale) and break the pure-SVG approach used by Blackhorse and 1st Cav counters.

## Outcome

`Fortysixth` class renders the insignia using SVG `<path>` elements with extracted path data, matching the pattern established by `Blackhorse` and `FirstCav`. The embedded JPG reference is removed.

## Acceptance Criteria

- [ ] Shield outline with proper curves
- [ ] Canton with Roman numeral X and crosses
- [ ] Five-pointed star
- [ ] Torch with flame details
- [ ] Color layers: blue field (#003087), gold elements (#FFD700), white canton
- [ ] Path constants extracted at class level (same pattern as Blackhorse)
- [ ] Counter sheet renders cleanly at 0.2 scale
- [ ] `xlink:href` image reference removed from generated SVG

## Notes

Source comments at `fortysixth.rb:13-19` enumerate the required vector elements. An SVG version exists at `original/46_INF_RGT_DUI.svg` (92KB) but it was converted from bitmap and may contain noisy paths. Options:

1. **Manual trace**: Hand-draw paths in a vector editor (Inkscape/Illustrator), export clean path data
2. **Clean up existing SVG**: Simplify the potrace output from `original/46_INF_RGT_DUI.svg`
3. **Find better source**: Locate a pre-existing clean vector version of the 46th Infantry DUI

This is the highest-effort item due to the manual art work involved.

## LLM Context

- Files likely affected: fortysixth.rb, fortysixth_counter_sheet.rb (remove xlink namespace)
- Invariants to preserve: OG-107 olive drab background, 1024x1024 counter size, sheet layout
- Style constraints: path data as class-level constants, render in bottom-to-top layer order
- Known traps: the existing SVG at `original/46_INF_RGT_DUI.svg` is 92KB of noisy potrace output — likely needs heavy simplification rather than direct extraction

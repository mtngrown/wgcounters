---
id: WGC-0001
title: Migrate counter geometry from 1024 to 1200 master grid
type: task
status: backlog
value: 4
effort: 3
urgency: 2
risk: 2
score: null
owner: dave
created: 2026-03-14
updated: 2026-03-14
parent: null
depends_on: [WGC-0003, WGC-0004]
area: counter-layout
adr_refs: []
links: [COUNTER_DESIGN.md]
labels: [geometry, breaking-change]
---

## Why

The current 1024×1024 coordinate system (2¹⁰) lacks factors of 3 and 5, producing fractional thirds and fifths. This causes subtle alignment drift, off-center elements, and inconsistent stroke weights. A 1200×1200 master grid (2⁴ × 3 × 5²) provides clean divisibility for binary, third-based, and fifth-based layouts, and maps exactly to standard ½″ (600) and ⅝″ (750) physical counter sizes. See COUNTER_DESIGN.md for full rationale.

## Outcome

All counters render on a 1200×1200 coordinate system with integer-aligned geometry. Counter sheets tile correctly at the new dimensions. Generated SVGs visually match the intent of the originals (insignia centered, proportions preserved) but at the new canvas size.

## Acceptance Criteria

- [ ] `Counter#counter_width` and `Counter#counter_height` return 1200
- [ ] Bounding box dimensions recalculated for 1200 canvas (x, width, height)
- [ ] `offset_x` and `offset_y` derived from counter dimensions (resolves WGC-0003)
- [ ] Text positions (`top_left_value`, `top_right_value`) recalculated for 1200
- [ ] Font size scaled proportionally
- [ ] Blackhorse insignia transform recalculated: `translate` and `scale` center on 1200×1200
- [ ] FirstCav insignia transform recalculated: `translate` and `scale` center on 1200×1200
- [ ] Fortysixth insignia transform recalculated for 1200×1200 canvas
- [ ] Counter sheet tile size and scale factor updated (either 200px tiles with scale ~0.1667, or 240px tiles with adjusted sheet dimensions)
- [ ] Counter sheet layout still produces 80 counters (8×10)
- [ ] All existing specs updated and passing
- [ ] CLAUDE.md dimension references updated (1024→1200, sheet scale factor, sheet tile size)
- [ ] Visual inspection confirms insignia are centered and properly scaled

## Notes

### Base class changes (counter.rb)

| Value | Current (1024) | Action |
|-------|---------------|--------|
| `counter_width` / `counter_height` | 1024 | → 1200 |
| `offset_y` | `(1024 - 628) / 2` = 198 | Derive from new dimensions |
| `offset_x` | -80 | Derive from new dimensions |
| bounding_box x | 236 | Recalculate |
| bounding_box width | 728 | Recalculate |
| bounding_box height | 628 | Recalculate |
| top_left_value x/y | 200, 300 | Recalculate |
| top_right_value x/y | 800, 300 | Recalculate |
| font_size | 300px | Recalculate (~350px) |

### Subclass insignia transforms

| Class | Current transform | Action |
|-------|------------------|--------|
| Blackhorse | `translate(277,207) scale(2.0)` | Recalculate to center on 1200 |
| FirstCav | `translate(312,255) scale(2.0)` | Recalculate to center on 1200 |
| Fortysixth | `translate(100,0) scale(0.9)` | Recalculate for 1200 canvas |

Path data constants (PATH_OUTER, PATH_WHITE, etc.) are unchanged — only the transforms that position them on the canvas.

### Counter sheet options

| Approach | Tile scale | Tile size | Sheet size | Translate step |
|----------|-----------|-----------|------------|----------------|
| A: Keep 200px tiles | 1/6 (~0.1667) | 200×200 | 1000×800 | 200 |
| B: Keep 0.2 scale | 0.2 | 240×240 | 1200×960 | 240 |

Decision needed on which approach to use for sheets.

### Opportunity

This migration is a natural time to resolve WGC-0003 (derive offsets from dimensions) and WGC-0004 (extract magic numbers), since every hardcoded value must be touched anyway.

## LLM Context

- Files likely affected: lib/wgcounters/counter.rb, lib/wgcounters/blackhorse.rb, lib/wgcounters/first_cav.rb, lib/wgcounters/fortysixth.rb, CLAUDE.md, spec/ files
- Invariants to preserve: insignia path data must not change; insignia must remain visually centered; sheet must produce 80 counters (8×10)
- Style constraints: all coordinates must be integers per COUNTER_DESIGN.md; use class-level constants for dimensions
- Known traps: the 0.2 sheet scale was chosen to map 1024→~205 which approximated 200px tiles; with 1200 the math no longer works at 0.2 scale. Bounding box x + width = 964 currently (related to 1024), this relationship should be made explicit in the new system.

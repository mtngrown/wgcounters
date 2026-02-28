---
id: BL-0004
title: Extract magic numbers to named constants
type: task
status: backlog
value: 2
effort: 2
urgency: 1
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: []
area: counter-layout
adr_refs: []
links: []
labels: [refactor]
---

## Why

The base `Counter` class and subclasses contain numerous literal values for coordinates, dimensions, and positions (e.g., bounding box at x=236, width=728, height=628; text positions at x=200/800, y=300; font size 300px). These are hard to understand and maintain without named constants.

## Outcome

All layout-related numeric literals in `Counter` are extracted to named constants with descriptive names. The relationship between values is clearer from reading the code.

## Acceptance Criteria

- [ ] Bounding box dimensions and position are named constants
- [ ] Text position coordinates are named constants
- [ ] Font size is a named constant
- [ ] Counter dimensions (1024x1024) remain as methods but are referenced consistently
- [ ] Generated SVGs are identical before and after

## Notes

Key magic numbers in `counter.rb`:
- Bounding box: x=236, y=0, width=728, height=628
- Top-left text: x=200, y=300
- Top-right text: x=800, y=300
- Font size: 300px
- Gray index: 90 (already a method, but unnamed)

Subclass-specific magic numbers (e.g., `translate(277,207) scale(2.0)` in Blackhorse) are in scope if a pattern emerges, but may be left as subclass-specific values since they depend on each insignia's source dimensions.

## LLM Context

- Files likely affected: counter.rb (primary), possibly blackhorse.rb, first_cav.rb, fortysixth.rb
- Invariants to preserve: all generated SVG output must be identical
- Style constraints: use class-level constants (ALL_CAPS), keep `def method = value` for computed values
- Known traps: some values may be interdependent (bounding box x + width = 964, which relates to counter_width 1024); extracting constants should make these relationships visible, not hide them

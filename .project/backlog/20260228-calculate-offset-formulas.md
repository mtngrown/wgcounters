---
id: BL-0003
title: Derive offset calculations from counter dimensions
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
depends_on: [BL-0008]
area: counter-layout
adr_refs: []
links: []
labels: [refactor]
---

## Why

`offset_x` returns a hardcoded `-80` with the comment "No idea why -80 is the correct (or close enough) offset." `offset_y` uses `(1024 - 628) / 2` which is closer to a formula but still relies on magic numbers. Both should derive from counter dimensions and bounding box size so they remain correct if dimensions change.

## Outcome

`offset_x` and `offset_y` are computed from `counter_width`, `counter_height`, and bounding box dimensions. The formulas are documented with comments explaining the geometry.

## Acceptance Criteria

- [ ] `offset_x` is derived from `counter_width` and bounding box width, not hardcoded
- [ ] `offset_y` is derived from `counter_height` and bounding box height, not hardcoded
- [ ] Generated SVGs are visually identical (or improved) after the change
- [ ] Formula logic is documented in comments

## Notes

Source comments at `counter.rb:30-31` and `counter.rb:36`:
```ruby
# No idea why -80 is the correct (or close enoug) offset.
# It needs to be calculated based on the counter width.
def offset_x
  -80
end

# This needs to be calculated based on the counter height
def offset_y
  (1024 - 628) / 2
end
```

The bounding box is 728x628 starting at x=236. The offset_x of -80 likely compensates for centering the 728+236=964 wide content within 1024. Understanding this geometry is the core of the task.

## LLM Context

- Files likely affected: counter.rb
- Invariants to preserve: visual centering of bounding box and insignia on 1024x1024 counter
- Style constraints: use `counter_width` / `counter_height` methods rather than literal 1024
- Known traps: offset values feed into `translate()` transforms in subclasses; changing them affects insignia positioning too

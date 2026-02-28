---
id: BL-0001
title: Refactor Counter initialize to accept options hash
type: task
status: backlog
value: 3
effort: 2
urgency: 1
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: [BL-0008]
area: counter-api
adr_refs: []
links: []
labels: [refactor]
---

## Why

`Counter#initialize` currently takes a single positional `fill` parameter defaulting to `color` (provided by a background module mixin). This limits extensibility — adding new options (e.g., stroke, dimensions, label text) requires changing the method signature each time.

## Outcome

`Counter#initialize` accepts a keyword arguments hash. Existing subclasses continue to work without modification. The constructor API is open for future options without signature changes.

## Acceptance Criteria

- [ ] `Counter.new` still works with no arguments (defaults preserved)
- [ ] `Counter.new(fill: 'red')` sets background fill
- [ ] All three counter subclasses (Blackhorse, FirstCav, Fortysixth) pass their existing behavior
- [ ] Generated SVG output is identical before and after refactor

## Notes

Source comment at `counter.rb:9`:
```ruby
# TODO: change this to an options hash.
# `color` is the background color which is currently
# currently defined in a module. This smells like an
# anti-pattern, but I'm rolling with it for now.
```

The color module concern is tracked separately in BL-0002.

## LLM Context

- Files likely affected: counter.rb, blackhorse.rb, first_cav.rb, fortysixth.rb
- Invariants to preserve: all generated SVGs must be pixel-identical after refactor
- Style constraints: use keyword arguments, keep `def method = value` pattern for simple getters
- Known traps: `initialize(fill = color)` relies on `color` from the mixin — default must still call `color` when no fill kwarg is provided

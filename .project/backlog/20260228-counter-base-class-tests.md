---
id: BL-0012
title: Test Counter base class and background modules
type: story
status: backlog
value: 4
effort: 2
urgency: 2
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: BL-0008
depends_on: [BL-0011]
area: testing
adr_refs: []
links: []
labels: [testing]
---

## Why

The base `Counter` class defines the template method pattern that all subclasses rely on. Background modules are mixins consumed by `Counter` subclasses. Testing them together validates the foundation before testing specific counter output.

## Outcome

Unit tests exist for `Counter` base class behavior and all background modules. Developers can verify that the rendering contract (dimensions, colors, offsets, bounding box) is correct in isolation.

## Acceptance Criteria

- [ ] `Counter` dimensions tested (counter_width, counter_height)
- [ ] `Counter` rendering methods tested (counter_background, bounding_box produce correct SVG elements)
- [ ] Offset calculations tested (offset_x, offset_y)
- [ ] Text positioning methods tested (top_left_value, top_right_value)
- [ ] `BackgroundFill` raises `NotImplementedError` when `color` not implemented
- [ ] `UsBackground` returns correct OG-107 olive drab color
- [ ] `NvBackground` returns correct light red color
- [ ] All tests pass via `bundle exec rake spec`

## Notes

### Implementation order (2 of 4 in BL-0008 epic)

Second child. Depends on BL-0011 (framework setup). Independent of BL-0013 (subclass tests).

### Testing approach

`Counter` is abstract (requires a background module to instantiate). Tests should use a concrete subclass or a test double that includes `UsBackground` or `NvBackground` to exercise base class behavior.

Background modules are tested here because they're thin mixins — two lines each — that only make sense in the context of `Counter`. Dedicated test files would be overkill.

## LLM Context

- Files likely affected: spec/counter_spec.rb (new), spec/background_spec.rb (new, or folded into counter_spec)
- Invariants to preserve: tests should not write to generated/
- Style constraints: frozen string literals, use SVG matchers from BL-0011
- Known traps: Counter cannot be instantiated without a color module; use a concrete subclass or anonymous test class

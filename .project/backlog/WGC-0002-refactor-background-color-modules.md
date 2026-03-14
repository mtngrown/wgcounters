---
id: WGC-0002
title: Refactor background color module pattern
type: task
status: backlog
value: 3
effort: 3
urgency: 1
risk: 2
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: [WGC-0015, WGC-0008]
area: counter-api
adr_refs: []
links: []
labels: [refactor]
---

## Why

Background colors are supplied via module mixins (`UsBackground`, `NvBackground`) that define a `color` method. This is acknowledged as an anti-pattern in the source — it couples color selection to the class hierarchy via `include`, making it hard to create a counter with an arbitrary color without defining a new module.

## Outcome

Colors are passed as data (e.g., via the options hash from WGC-0015) rather than inherited through mixins. The `BackgroundFill`, `UsBackground`, and `NvBackground` modules are either removed or repurposed as simple color constant holders.

## Acceptance Criteria

- [ ] Counter color is configurable without creating a new module
- [ ] Existing color values (OG-107 olive drab, NV light red) are preserved as named constants or a lookup
- [ ] All three counter subclasses produce identical SVG output
- [ ] No orphaned modules left in the codebase

## Notes

Source comment at `counter.rb:10-12`:
```ruby
# `color` is the background color which is currently
# currently defined in a module. This smells like an
# anti-pattern, but I'm rolling with it for now.
```

This depends on WGC-0015 (options hash) being completed first, since the options hash provides the mechanism to pass colors as constructor arguments.

Possible approaches:
1. Simple constants hash: `COLORS = { us: 'rgb(106,92,64)', nv: 'rgb(253,191,191)' }`
2. Keep modules but only as constant containers, not mixins
3. Pass color directly: `Blackhorse.new(fill: Counter::US_OLIVE_DRAB)`

## LLM Context

- Files likely affected: counter.rb, background_fill.rb, us_background.rb, nv_background.rb, blackhorse.rb, first_cav.rb, fortysixth.rb
- Invariants to preserve: OG-107 `rgb(106,92,64)` for US, `rgb(253,191,191)` for NV — historical accuracy matters
- Style constraints: frozen string literals, simple getters with `def method = value`
- Known traps: removing `include UsBackground` changes the method resolution order; ensure `color` is still available if any code calls it

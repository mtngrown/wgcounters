---
id: WGC-0013
title: Test counter subclass SVG output
type: story
status: done
value: 4
effort: 2
urgency: 2
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
completed: 2026-02-28
parent: WGC-0008
depends_on: [WGC-0011]
area: testing
adr_refs: []
links: []
labels: [testing]
---

## Why

The three counter subclasses (Blackhorse, FirstCav, Fortysixth) are the actual deliverables of this project. Structural tests verify that each generates well-formed SVG with the correct insignia paths, background colors, transforms, and counter sheet layout.

## Outcome

Each counter subclass has specs covering both `to_svg` (individual counter) and `counter_sheet_svg` (80-counter sheet). Tests use Nokogiri to parse output and assert structural correctness rather than exact string matching.

## Acceptance Criteria

- [x] Blackhorse `to_svg` tested: SVG root dimensions, OG-107 background rect, 4 insignia paths present, correct transform
- [x] Blackhorse `counter_sheet_svg` tested: SVG root 1000x800, 80 counters rendered
- [x] FirstCav `to_svg` tested: SVG root dimensions, OG-107 background rect, 4 insignia paths present, correct transform
- [x] FirstCav `counter_sheet_svg` tested: SVG root 1000x800, 80 counters rendered
- [x] Fortysixth `to_svg` tested: SVG root dimensions, OG-107 background rect, embedded image element present, xlink namespace
- [x] Fortysixth `counter_sheet_svg` tested: SVG root 1000x800, 80 counters rendered, xlink namespace
- [x] All tests pass via `bundle exec rake spec` (47 examples, 0 failures)

## Notes

### Implementation order (3 of 4 in WGC-0008 epic)

Third child. Depends on WGC-0011 (framework setup). Independent of WGC-0012 (base class tests) — both can be worked in parallel.

### Testing approach

Structural testing with Nokogiri as recommended in the epic. For each counter:

1. Generate SVG string via `to_svg` / `counter_sheet_svg`
2. Parse with `Nokogiri::XML`
3. Assert elements exist with correct attributes (fill colors, path count, transforms, dimensions)

Fortysixth is a special case — it uses an embedded `<image>` element with `xlink:href` instead of `<path>` elements. Tests should assert the image element and its attributes rather than path data.

### Counter sheet structure

All three sheets share the same layout: 8 rows x 10 columns = 80 counters, each at scale 0.2, wrapped in a global scale(0.5) group. Tests can verify the outer structure without checking every individual counter.

## LLM Context

- Files likely affected: spec/blackhorse_spec.rb (new), spec/first_cav_spec.rb (new), spec/fortysixth_spec.rb (new)
- Invariants to preserve: tests should not write to generated/
- Style constraints: frozen string literals, use SVG matchers from WGC-0011
- Known traps: Fortysixth embeds `../original/46_INF_RGT_DUI.jpg` — this is an SVG-internal reference, not a Ruby path. Tests parse the SVG string and check the attribute value, they don't need the image file to exist.

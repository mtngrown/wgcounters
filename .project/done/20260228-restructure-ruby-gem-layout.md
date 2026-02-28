---
id: BL-0006
title: Restructure project to conform to Ruby gem specification
type: story
status: done
value: 4
effort: 3
urgency: 1
risk: 2
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
completed: 2026-02-28
parent: null
depends_on: []
area: project-structure
adr_refs: []
links: []
labels: [infrastructure, refactor]
---

## Why

All Ruby source files currently live in the project root with no namespacing. This makes the project harder to require as a library, test in isolation, or distribute. Conforming to the standard gem layout provides conventional structure that Ruby tooling (Bundler, RSpec, Rake, Rubocop) expects.

## Outcome

Project follows standard Ruby gem directory layout:

```
wgcounters/
├── lib/
│   ├── wgcounters.rb              # top-level require
│   └── wgcounters/
│       ├── counter.rb             # base class
│       ├── background_fill.rb
│       ├── us_background.rb
│       ├── nv_background.rb
│       ├── blackhorse.rb
│       ├── first_cav.rb
│       └── fortysixth.rb
├── bin/ or exe/                   # generator executables (see decision below)
├── spec/ or test/                 # test directory
├── wgcounters.gemspec
├── Gemfile
├── Rakefile
└── ...
```

## Acceptance Criteria

- [x] All counter classes live under `lib/wgcounters/` and are namespaced in `module WGCounters`
- [x] `require 'wgcounters'` loads the library
- [x] A `.gemspec` file exists with valid metadata
- [x] `ruby exe/generate_*` produces identical SVG output (verified via diff against baseline)
- [x] Existing `require_relative` calls updated; top-level loader handles all requires
- [x] `generated/` output directory still works (executables run from project root)

## Notes

### Decision needed: output targets

The current generators (e.g., `blackhorse.rb`) both define the counter class *and* write the SVG file inline. Under gem layout, class definition and file generation need to be separated. Alternatives for the generation/output mechanism:

1. **`bin/` executables** — e.g., `bin/generate_blackhorse`. Simple scripts that require the library and write SVGs. Invoked with `bundle exec bin/generate_blackhorse`.

2. **Rake tasks** — e.g., `rake generate:blackhorse`, `rake generate:all`. Conventional for build-like operations. Discoverable via `rake -T`.

3. **CLI with subcommands** — e.g., `wgcounters generate blackhorse`. More structure, but heavier (may need Thor or optparse). Overkill for current scope.

4. **Library API only** — No executables; user writes a script or uses IRB. Maximally flexible but less convenient.

This decision should be made before implementation begins.

### Namespace consideration

`Wgcounters` or `WGCounters` — the gem name `wgcounters` maps to `Wgcounters` by Ruby convention, but `WGCounters` reads better as an acronym. Either works; pick one and be consistent.

## Implementation Notes

### Decisions Made
- **Namespace**: `WGCounters` (acronym style, reads better)
- **Output targets**: Executables in `exe/` + Rake tasks as thin wrappers (principle: "Rake tasks should most often be thin wrappers around executable code which is independently testable")
- **Sheet generation**: Merged standalone `*_counter_sheet.rb` files into class methods (`self.counter_sheet_svg`) on each counter class

### Key Changes
- All 7 source `.rb` files moved via `git mv` to `lib/wgcounters/` and wrapped in `module WGCounters`
- 3 standalone sheet generator files removed (merged into counter classes)
- Top-level `lib/wgcounters.rb` handles all requires
- `wgcounters.gemspec` created with nokogiri runtime dep, rake dev dep
- Rakefile with `rake generate` (all) and `rake generate:{unit}` tasks
- All 6 generated SVG files verified identical to pre-restructure baseline

### Traps Avoided
- `fortysixth.rb` embeds `../original/46_INF_RGT_DUI.jpg` as an SVG-internal reference — this resolves relative to `generated/` at render time, not at Ruby require time, so it still works
- Executables run from project root, so `File.write('generated/...')` paths resolve correctly

## LLM Context

- Files likely affected: every `.rb` file in root (move to lib/), Gemfile, new .gemspec, new Rakefile
- Invariants to preserve: all generated SVG output must be identical; `original/` asset paths must resolve correctly after restructure
- Style constraints: frozen string literals, `def method = value` for simple getters, Nokogiri builder pattern
- Known traps: `require_relative` paths all change; `File.write('generated/...')` paths need to resolve relative to project root not `lib/`; `fortysixth.rb` references `../original/46_INF_RGT_DUI.jpg` as a relative path inside the SVG itself (not a Ruby require)

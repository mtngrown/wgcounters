---
id: WGC-0007
title: Add Rubocop for static analysis and style enforcement
type: task
status: done
value: 3
effort: 2
urgency: 1
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-03-14
completed: 2026-03-14
parent: null
depends_on: []
area: tooling
adr_refs: []
links: []
labels: [tooling, quality]
---

## Why

The project has no automated style enforcement. As the codebase grows with more counter types, consistent style becomes harder to maintain manually. Rubocop provides static analysis, catches common bugs, and enforces the Ruby conventions already documented in CLAUDE.md (frozen string literals, etc.).

## Outcome

`bundle exec rubocop` runs cleanly against the codebase with a project-specific `.rubocop.yml` configuration.

## Acceptance Criteria

- [x] Rubocop added to gemspec (development dependency)
- [x] `.rubocop.yml` configured with project-appropriate rules
- [x] All existing files pass `rubocop` without errors (fix or disable as needed)
- [x] Frozen string literal cop enabled (already present in code)
- [x] Generated files excluded from linting

## Notes

### Plugins installed

All relevant plugins added:
- `rubocop-performance ~> 1.25`
- `rubocop-rake ~> 0.7`
- `rubocop-rspec ~> 3.6`

### Cops disabled with rationale

- `Style/Documentation` — counter subclasses are self-documenting via class name and inheritance
- `Gemspec/DevelopmentDependencies` — single-gem project, dev deps in gemspec is fine
- `RSpec/SpecFilePathFormat` — spec files live flat in `spec/`, not nested under `wg_counters/`
- `RSpec/MultipleExpectations` — raised to max 5; SVG structural tests naturally assert multiple attributes
- `RSpec/MultipleDescribes` — counter and background specs share files reasonably

### Cops configured

- `Layout/LineLength` max 120, with exclusions for `blackhorse.rb` and `first_cav.rb` (SVG path data)
- `Metrics/ClassLength` exclusion for `counter.rb`
- `Metrics/MethodLength` max 20 (SVG builder methods)

### Auto-corrected offenses

- Added frozen string literal comment to `Gemfile`
- Removed extra spacing in `us_background.rb`
- Added `rubygems_mfa_required` metadata to gemspec
- Wrapped long description line in gemspec

### Verification

- 21 files inspected, 0 offenses
- 47 specs passing, 100% line coverage preserved

## LLM Context

- Files affected: wgcounters.gemspec, Gemfile, Gemfile.lock, .rubocop.yml (new), us_background.rb (spacing fix)
- Invariants preserved: existing code style conventions, all specs green, 100% coverage
- Style constraints: configured Rubocop to match existing conventions, not fight them
- Known traps: PATH_* constants contain extremely long strings; line length cop excluded for those files

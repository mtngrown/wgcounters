---
id: BL-0011
title: Set up RSpec, SimpleCov, and SVG matchers
type: task
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
parent: BL-0008
depends_on: []
area: testing
adr_refs: []
links: []
labels: [testing, infrastructure]
---

## Why

All other testing work depends on having the framework wired up. RSpec is the chosen framework, SimpleCov provides coverage reporting, and custom SVG matchers give the remaining test stories a clean assertion vocabulary. This is the foundation — nothing else starts until it's green.

## Outcome

`bundle exec rake spec` runs zero specs successfully. SimpleCov generates a coverage report on each run. Custom RSpec matchers exist for common SVG assertions (parsing output, checking elements/attributes). The test infrastructure is ready for the stories that follow.

## Acceptance Criteria

- [x] RSpec added to gemspec as development dependency and configured (`.rspec`, `spec/spec_helper.rb`)
- [x] SimpleCov added and wired into spec_helper (generates `coverage/` report)
- [x] `coverage/` added to `.gitignore`
- [x] Rakefile updated: `rake spec` works, `rake` default runs specs
- [x] Custom SVG matchers/helpers in `spec/support/` for parsing SVG output and asserting elements
- [x] `bundle exec rake spec` passes with 0 examples, 0 failures
- [x] Minitest removed (replaced by RSpec)

## Notes

### Implementation order (1 of 4 in BL-0008 epic)

This is the first child of the testing epic. All subsequent test stories depend on this.

### SVG matcher ideas

- `parse_svg(xml_string)` — returns Nokogiri doc
- `have_svg_root(width:, height:)` — asserts `<svg>` element with attributes
- `have_rect(fill:)` — asserts `<rect>` with given fill
- `have_path_count(n)` — asserts number of `<path>` elements
- Keep it simple; add matchers as needed in later stories

### Minitest cleanup

The gemspec currently lists minitest. Replace with rspec. Remove `test/` directory and minitest Rake::TestTask if present.

## LLM Context

- Files likely affected: wgcounters.gemspec, Gemfile.lock, Rakefile, .rspec (new), spec/spec_helper.rb (new), spec/support/ (new), .gitignore
- Invariants to preserve: existing `rake generate` tasks unchanged
- Style constraints: frozen string literals, match existing Ruby conventions
- Known traps: SimpleCov must be required before application code in spec_helper

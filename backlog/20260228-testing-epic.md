---
id: BL-0008
title: Establish testing infrastructure and coverage
type: epic
status: backlog
value: 5
effort: 4
urgency: 2
risk: 2
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: []
area: testing
adr_refs: []
links: []
labels: [testing, infrastructure, epic]
---

## Why

The project has zero tests. Refactoring tasks (BL-0001 through BL-0004) and new counter development both carry regression risk without automated verification. Tests are a prerequisite for confident refactoring and a safety net as the counter library grows.

## Outcome

A test suite exists that verifies counter generation produces correct SVG output. Developers can run `bundle exec rspec` (or `rake test`) and know whether changes broke anything.

## Acceptance Criteria

- [ ] Test framework chosen and configured (RSpec or Minitest)
- [ ] Test directory structure created (`spec/` or `test/`)
- [ ] Base Counter class has unit tests
- [ ] Each counter subclass (Blackhorse, FirstCav, Fortysixth) has tests verifying SVG output
- [ ] Counter sheet generators have tests
- [ ] Background module behavior is tested
- [ ] Tests runnable via single command (`bundle exec rspec` or `rake test`)
- [ ] Test helper/support files established for common SVG assertions

### Potential child items

This epic may be broken into discrete tasks as work progresses:

- Test framework setup and configuration
- Counter base class unit tests
- Subclass SVG output tests (snapshot or structural)
- Counter sheet layout tests
- Background color module tests
- SVG assertion helpers (e.g., parse output, check for expected elements/attributes)

## Notes

### Test strategy considerations

**Snapshot testing**: Generate SVG, compare against a known-good baseline. Simple, catches any change. Brittle if output format changes intentionally.

**Structural testing**: Parse generated SVG with Nokogiri, assert specific elements exist with correct attributes (rect with right fill, paths present, transforms correct). More resilient to formatting changes.

**Recommended**: Start with structural tests using Nokogiri to parse output SVG. Snapshot tests as an optional second layer.

### Framework choice

- **RSpec**: More expressive, widely used, good matchers. Heavier dependency.
- **Minitest**: Ships with Ruby, lighter, sufficient for this scope.

Either works; defer to owner preference.

## LLM Context

- Files likely affected: Gemfile, Rakefile, new spec/ or test/ directory, possibly a test helper
- Invariants to preserve: tests should not modify generated/ output files
- Style constraints: match existing Ruby conventions (frozen string literals, etc.)
- Known traps: fortysixth.rb uses an embedded JPG with a relative path — tests may need to run from project root or handle path resolution

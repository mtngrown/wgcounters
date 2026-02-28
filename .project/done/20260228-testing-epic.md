---
id: BL-0008
title: Establish testing infrastructure and coverage
type: epic
status: done
value: 5
effort: 4
urgency: 2
risk: 2
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
completed: 2026-02-28
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

A test suite exists that verifies counter generation produces correct SVG output. Developers can run `bundle exec rake spec` and know whether changes broke anything.

## Acceptance Criteria

- [x] Test framework chosen and configured (RSpec)
- [x] Test directory structure created (`spec/`)
- [x] Base Counter class has unit tests
- [x] Each counter subclass (Blackhorse, FirstCav, Fortysixth) has tests verifying SVG output
- [x] Counter sheet generators have tests
- [x] Background module behavior is tested
- [x] Tests runnable via single command (`bundle exec rake spec`)
- [x] Line and branch coverage is reported (SimpleCov, 100% line, thresholds enforced)
- [x] Test helper/support files established for common SVG assertions

### Child items (implementation order)

1. **BL-0011** — Set up RSpec, SimpleCov, and SVG matchers (done)
2. **BL-0012** — Test Counter base class and background modules (done)
3. **BL-0013** — Test counter subclass SVG output (done)
4. **BL-0014** — Drive full test coverage (done)

## Notes

### Test strategy considerations

**Snapshot testing**: Generate SVG, compare against a known-good baseline. Simple, catches any change. Brittle if output format changes intentionally.

**Structural testing**: Parse generated SVG with Nokogiri, assert specific elements exist with correct attributes (rect with right fill, paths present, transforms correct). More resilient to formatting changes.

**Recommended**: Start with structural tests using Nokogiri to parse output SVG. Snapshot tests as an optional second layer.

### Framework choice

**RSpec** chosen. More expressive matchers, widely used, supports custom matcher DSL for SVG assertions.

## LLM Context

- Files likely affected: Gemfile, Rakefile, new spec/ directory, .rspec
- Invariants to preserve: tests should not modify generated/ output files
- Style constraints: match existing Ruby conventions (frozen string literals, etc.)
- Known traps: fortysixth.rb uses an embedded JPG with a relative path — tests may need to run from project root or handle path resolution

---
id: BL-0014
title: Drive full test coverage
type: task
status: done
value: 3
effort: 2
urgency: 1
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
completed: 2026-02-28
parent: BL-0008
depends_on: [BL-0012, BL-0013]
area: testing
adr_refs: []
links: []
labels: [testing]
---

## Why

BL-0012 and BL-0013 establish test coverage for the known surface area. This final pass reviews the SimpleCov report to find uncovered lines and branches, then fills the gaps. It's the cleanup pass that turns "we have tests" into "we have confidence."

## Outcome

SimpleCov reports full line and branch coverage. Any remaining uncovered code is either tested or explicitly marked with a justification for exclusion.

## Acceptance Criteria

- [x] SimpleCov report reviewed after BL-0012 and BL-0013 are complete
- [x] All uncovered lines identified — already at 100% from BL-0012/BL-0013
- [x] Branch coverage gaps addressed (no conditional branches in codebase)
- [x] Coverage thresholds configured: `minimum_coverage line: 100, branch: 100`
- [x] Final `bundle exec rake spec` passes with full coverage (47 examples, 0 failures)
- [x] Refactoring tickets BL-0001/0002/0003/0004 updated with `depends_on: [BL-0008]`

## Notes

### Implementation order (4 of 4 in BL-0008 epic)

Last child. Depends on both BL-0012 and BL-0013 being complete — this is a gap-filling pass, not greenfield.

### Likely gaps

Based on the current codebase, areas that BL-0012/BL-0013 might not fully cover:

- `BackgroundFill#color` raising `NotImplementedError` (may already be covered in BL-0012)
- `Counter#fill_color` and `Counter#gray_index` interaction
- Edge cases in text positioning methods
- `VERSION` constant

### Coverage exclusions

Some lines may not warrant testing (e.g., `VERSION = '0.1.0'`). Use SimpleCov's `# :nocov:` annotation sparingly with a comment explaining why.

## LLM Context

- Files likely affected: existing spec files (additions), spec/spec_helper.rb (coverage thresholds)
- Invariants to preserve: all previously passing tests remain green
- Style constraints: frozen string literals, match existing spec conventions
- Known traps: don't write tests just to hit a number — each test should assert something meaningful about behavior

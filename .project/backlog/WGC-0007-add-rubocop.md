---
id: WGC-0007
title: Add Rubocop for static analysis and style enforcement
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

- [ ] Rubocop added to Gemfile (development group)
- [ ] `.rubocop.yml` configured with project-appropriate rules
- [ ] All existing files pass `rubocop` without errors (fix or disable as needed)
- [ ] Frozen string literal cop enabled (already present in code)
- [ ] Generated files excluded from linting

## Notes

Some existing patterns may need targeted cop disables:
- `def method = value` one-liner syntax (supported in modern Rubocop)
- Long path data strings in counter constants (line length exceptions)
- `File.write` at bottom of executable files
- The `if __FILE__ == $PROGRAM_NAME` guard in fortysixth.rb

Consider whether to also add `rubocop-performance` and `rubocop-rake` plugins.

## LLM Context

- Files likely affected: Gemfile, Gemfile.lock, new .rubocop.yml
- Invariants to preserve: existing code style conventions from CLAUDE.md
- Style constraints: configure Rubocop to match existing conventions, not fight them
- Known traps: PATH_* constants contain extremely long strings; line length cop needs generous exclusion or per-constant disables

---
id: BL-0009
title: Move backlog/ under .project/ directory
type: task
status: backlog
value: 2
effort: 1
urgency: 1
risk: 1
score: null
owner: dave
created: 2026-02-28
updated: 2026-02-28
parent: null
depends_on: []
area: project-management
adr_refs: []
links: []
labels: [infrastructure]
---

## Why

Project management artifacts (backlog, future ADRs, meeting notes, etc.) are currently mixed into the repo root. A `.project/` directory provides a single location for all project management information, keeping the root clean and establishing a convention for non-code assets.

## Outcome

`backlog/` lives at `.project/backlog/`. The `.project/` directory serves as the home for all project management concerns.

## Acceptance Criteria

- [ ] `backlog/` moved to `.project/backlog/`
- [ ] AGENT.md updated to reference new path (`.project/backlog/template.md`)
- [ ] CLAUDE.md updated to reference new path
- [ ] All backlog item cross-references still valid
- [ ] Source code `TODO(BL-XXXX)` comments unchanged (they reference IDs, not paths)
- [ ] Git history preserved via `git mv`

## Notes

The `.project/` directory could eventually house:
- `backlog/` — work items (current)
- `adrs/` — architectural decision records (referenced in template `adr_refs` field)
- `docs/` — project-level documentation
- `templates/` — shared templates

Using a dotfile directory keeps it visually separate from source code in file listings while remaining tracked by git.

## LLM Context

- Files likely affected: AGENT.md, CLAUDE.md, backlog/README.md (path references), all files under backlog/ (move)
- Invariants to preserve: backlog item content unchanged; template.md unchanged
- Style constraints: use `git mv` to preserve history
- Known traps: any tooling or scripts referencing `./backlog/` path will break; grep for `backlog/` across the repo before finalizing

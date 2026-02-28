---
id: BL-0010
title: Establish .project/ subdirectory structure
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
depends_on: [BL-0009]
area: project-management
adr_refs: []
links: []
labels: [infrastructure]
---

## Why

BL-0009 creates `.project/backlog/` but the broader `.project/` directory structure is not yet established. Additional subdirectories for completed items, ADRs, and project documentation should be scaffolded so they're ready for use.

## Outcome

`.project/` has a clear, documented structure beyond just `backlog/`.

## Acceptance Criteria

- [ ] `.project/done/` directory exists for completed backlog items
- [ ] `.project/adrs/` directory exists (or is documented as planned)
- [ ] `.project/docs/` directory exists for project management documentation
- [ ] `.project/README.md` documents the directory structure and conventions
- [ ] No stale references to old root `backlog/` path remain anywhere in repo

## Notes

This is the follow-up to BL-0009 (the move). BL-0009 handles the migration and cleanup of root `backlog/`. This ticket scaffolds the rest of `.project/`.

Subdirectories per BL-0009 notes:
- `backlog/` — active work items (created by BL-0009)
- `done/` — completed items (moved from backlog when status is done)
- `adrs/` — architectural decision records
- `docs/` — project-level documentation, metadata, discussion

## LLM Context

- Files likely affected: new directories and README under .project/
- Invariants to preserve: .project/backlog/ content from BL-0009 untouched
- Style constraints: match existing README conventions from backlog/README.md
- Known traps: don't create empty directories without a .gitkeep or README since git won't track them

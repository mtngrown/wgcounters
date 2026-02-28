# .project/

Project management directory for the WGCounters repository.

## Structure

```
.project/
├── backlog/     Active work items (one file per item)
├── done/        Completed backlog items (moved from backlog/)
├── adrs/        Architectural decision records
└── docs/        Project-level documentation, metadata, discussion
```

## Conventions

- All backlog items conform to `backlog/template.md`
- Completed items move from `backlog/` to `done/` (preserve filename)
- ADRs follow a separate template (TBD)
- Agents must read `AGENT.md` in the repo root before modifying this directory

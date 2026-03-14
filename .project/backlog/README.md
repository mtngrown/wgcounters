# Backlog

This directory contains all backlog items for the project.

## Canonical Template

All entries MUST conform to:

    ./template.md

No alternate formats are permitted.

## Creating a Backlog Item

1. Copy `template.md`.
2. Create a new file in this directory.
3. Name the file:

       WGC-<####>-short-kebab-title.md

   Example:

       WGC-<####>-ci-hardening.md

4. Fill in all required YAML fields.
5. Do not remove sections from the template.
6. Keep entries self-contained and atomic where possible.

## Updating a Backlog Item

- Preserve the original structure.
- Update status and metadata in the YAML header.
- Add notes under the appropriate sections.
- Do not modify historical content unless correcting factual errors.

## Scope Rules

- One file per discrete unit of work.
- Epics may reference child items but must still conform to the template.
- Architectural decisions belong elsewhere (e.g., ADRs), not in this directory.

## Enforcement

Agents must read `AGENT.md` before interacting with this directory.
Humans are responsible for approving structural changes.


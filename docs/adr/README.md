# Architecture decision records

ADRs record decisions that constrain multiple parts of gradar or are expensive
to reverse. Use the next four-digit number and the template below.

```markdown
# NNNN: Decision title

- Status: Proposed | Accepted | Superseded
- Date: YYYY-MM-DD

## Context
## Decision
## Consequences
## Alternatives considered
```

A **Proposed** ADR may be amended in place; record the amendment date in the
header. Once **Accepted**, it is history: do not rewrite it, add a superseding
ADR instead.

## Index

| ADR | Decision | Status |
| --- | --- | --- |
| [0001](0001-application-stack.md) | Rust, Tauri 2 and Svelte | Proposed |
| [0002](0002-system-git.md) | System Git with a hardened invocation contract | Proposed |
| [0003](0003-trusted-actions.md) | Repository-provided actions are untrusted | Proposed |
| [0004](0004-worktree-primary-unit.md) | The worktree is the primary unit of work | Proposed |
| [0005](0005-linux-packaging.md) | Source-first Arch packaging for V1 | Proposed |

ADRs 0001 and 0002 are accepted or superseded by the phase-zero spike (#2).

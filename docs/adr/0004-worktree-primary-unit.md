# 0004: The worktree is the primary unit of work

- Status: Proposed
- Date: 2026-08-02

## Context

Multi-repository tools conventionally model one row per repository, with the
checked-out branch as a property of that row. That model assumes a developer has
one active line of work per repository.

gradar's primary user does not. Linked worktrees are used routinely, and
coding-agent workflows produce several concurrent branches per repository, each
in its own worktree, each with independent dirty state, test evidence and pull
request. Under a repository-first model these collapse into one row and the
distinguishing information — which of them needs attention, which is finished —
is exactly what is lost.

The states gradar cares about are properties of a worktree, not a repository:
dirty, ahead/behind, merged, prunable, currently being written to, tested at a
given commit, associated with a pull request.

## Decision

Model the worktree as the primary entity. `WorktreeIdentity` is a first-class
identity; `RepositoryIdentity` groups worktrees that share a Git common
directory.

Domain classification, signals, evidence, task results, handovers and actions
are defined against a worktree. Repository-level values are explicitly derived
rollups with defined aggregation rules, not independently computed state.

The default overview may render one row per repository for compactness, but that
row is a rollup, expanding to worktree rows must not lose information, and no
repository-level rollup may claim a state that contradicts its worktrees.

## Consequences

- Agent-generated work becomes visible and individually actionable instead of
  being averaged away.
- "Finished" and "reclaimable" become expressible, which repository-first models
  cannot represent well.
- Aggregation rules must be defined and tested once, in the domain.
- The primary worktree is not special-cased; a repository with no linked
  worktrees is simply a repository with one.
- Identity must survive a worktree being moved, locked, pruned or made missing.
- The UI carries additional density and grouping work in the read-only cockpit.

## Alternatives considered

- Repository-first with a worktree count column: the conventional model; it
  hides precisely the distinctions this product exists to surface.
- Branch-first: closer to how users talk about work, but branches without
  worktrees have no filesystem state, dirty tree or test evidence to observe.
- Dual first-class entities: maximum flexibility, but two sources of truth for
  the same state is how classification bugs become unfalsifiable.

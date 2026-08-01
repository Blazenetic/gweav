# 0002: Use the system Git executable as the authority

- Status: Proposed
- Date: 2026-08-02

## Context

gradar must describe real repositories including worktrees, submodules,
unusual configuration and credentials already used successfully by the user.
Embedding another Git implementation could produce different behaviour and
lag features relied on by current Git installations.

## Decision

Use the system `git` executable through a typed adapter. Invoke known commands
with explicit argument arrays, controlled environment, timeouts and output
limits. Prefer machine-readable formats and NUL-delimited fields.

Observation commands must be demonstrably read-only. Tests use generated Git
fixtures rather than a developer's repositories.

## Consequences

- Behaviour aligns with command-line Git and supports linked worktrees.
- Missing or incompatible Git becomes an explicit capability state.
- Process spawning and parsing require strong tests and diagnostics.
- Git credentials remain managed by existing user tooling.

## Alternatives considered

- libgit2 bindings: fewer subprocesses, but adds native dependency and semantic
  differences.
- pure Rust Git implementation: promising but creates unnecessary compatibility
  risk for V1.
- parsing porcelain intended for humans: rejected as fragile.

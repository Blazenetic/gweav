# 0002: Use the system Git executable as the authority

- Status: Proposed
- Date: 2026-08-02
- Amended: 2026-08-02 (hardened invocation contract added before acceptance)

## Context

gweav must describe real repositories including worktrees, submodules,
unusual configuration and credentials already used successfully by the user.
Embedding another Git implementation could produce different behaviour and
lag features relied on by current Git installations.

Using the system Git executable inherits one property that is easy to miss:
repository-local configuration can name programs that Git executes during
commands that look passive. `core.fsmonitor` runs a program during
`git status`; `diff.external` and `diff.*.textconv` run programs during
diff-like commands; `core.hooksPath` is reached through automatic maintenance;
aliases can shadow subcommand names. A scanner that walks untrusted
repositories with default settings is an arbitrary code execution surface.

## Decision

Use the system `git` executable through a typed adapter. Invoke known commands
with explicit argument arrays, controlled environment, timeouts and output
limits. Prefer machine-readable plumbing output and NUL-delimited fields.

All observation invocations are constructed by a single hardened adapter
function that applies the configuration overrides, environment settings and
invocation rules listed in `docs/SECURITY.md`. Call sites may not build their
own argument lists. In particular, observation always runs with `core.fsmonitor`
disabled, hooks path neutralised, automatic maintenance off, external diff and
credential helpers cleared, `protocol.ext` refused, `GIT_TERMINAL_PROMPT=0` and
`GIT_OPTIONAL_LOCKS=0`.

Observation commands must be demonstrably read-only and demonstrably
non-executing. Tests use generated Git fixtures, including hostile ones, rather
than a developer's repositories.

## Consequences

- Behaviour aligns with command-line Git and supports linked worktrees.
- Missing, incompatible or ownership-refusing Git becomes an explicit capability
  state rather than a scan failure.
- Process spawning and parsing require strong tests and diagnostics.
- Git credentials remain managed by existing user tooling.
- The hardened contract is a single, testable chokepoint; a regression is a test
  failure rather than a silent exposure.
- `GIT_OPTIONAL_LOCKS=0` also prevents gweav from interrupting a human or agent
  who is working in the repository being observed.

## Alternatives considered

- libgit2 bindings: fewer subprocesses and no alias/hook execution surface, but
  adds a native dependency and semantic differences from the user's Git.
- pure Rust Git implementation: promising but creates unnecessary compatibility
  risk for V1.
- parsing porcelain intended for humans: rejected as fragile.
- relying on a documented convention that observation is read-only: rejected,
  because the failure mode is silent code execution rather than a wrong number.

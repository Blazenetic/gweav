# gweav

**A local-first control plane for work spread across many repositories and
worktrees — including work done by coding agents.**

A modern developer workstation no longer holds a handful of repositories with
one branch checked out. It holds dozens of repositories, many linked worktrees,
several branches that a coding agent started and did not finish, test results
that may or may not still describe the code on disk, and pull requests waiting
on someone. Answering "what is actually going on here?" currently means visiting
directories one at a time.

gweav answers it in one calm, fast, keyboard-first view, then launches the
tools you already use for the deep work.

## Product promise

Open gweav and answer four questions in seconds:

1. What needs attention?
2. What is safe and current?
3. Where should I resume work?
4. What is finished and can be cleaned up?

gweav is not a full Git client, hosted platform, project manager, or autonomous
agent. It is the overview and launchpad between the filesystem, Git, editors,
terminals, task runners and optional forge integrations.

## Why this exists

Multi-repository status tools are not new. gweav differs in three ways that
matter when humans and coding agents share a workstation:

- **Evidence has a source and an age.** Every signal states where it came from
  and when it was observed. Unknown is a state; it is never rendered as healthy.
- **The worktree is the unit of work.** Repository rollups exist, but the thing
  you resume, hand over or delete is a worktree — which is exactly what agent
  workflows produce in quantity.
- **Results are bound to the code they describe.** A test result records the
  commit and dirty-tree fingerprint it ran against, so a stale pass reads as
  outdated rather than green.

## V1 MVP+

- Discover repositories and linked worktrees under configured roots without
  following unsafe paths.
- Show working-tree, branch, upstream, fetch-freshness, worktree, activity and
  disk-usage signals.
- Identify finished work: merged branches, prunable worktrees and the disk they
  still occupy.
- Show whether a worktree currently has work in progress in it.
- Record test results against the exact commit and dirty-tree state tested.
- Link the current branch to a GitHub pull request, with review and check state,
  when `gh` is available.
- Filter, group, pin and search from a keyboard-first desktop UI.
- Open configured terminals, editors, file managers and Git tools.
- Run explicitly trusted tasks with confirmation, timeout and captured output.
- Copy deterministic compact, agent and diagnostic handovers.
- Expose the same read model through a small CLI and JSON output.
- Install on Arch-family Linux from source through a documented, reproducible
  build path.

See [Product](docs/PRODUCT.md), [Architecture](docs/ARCHITECTURE.md) and
[Delivery](docs/DELIVERY.md) for the governing contracts.

## Planned stack

- Rust workspace for the domain, Git adapter, scanner, task runner and CLI
- Tauri 2 desktop shell
- Svelte + TypeScript interface
- SQLite cache and history
- TOML configuration using XDG paths
- system `git` as the source of truth
- optional `gh` adapter for GitHub metadata

These choices are recorded as ADRs and may be changed through evidence-backed
review before the implementation boundary is crossed.

## Platform

The reference environment is CachyOS with KDE Plasma and Wayland. The core is
kept portable and free of desktop-specific assumptions, but only the reference
environment is validated for V1.

V1 ships a source-first Arch build path. Portable single-file bundles
(AppImage), Flatpak and other operating systems are deliberately post-V1; see
[ADR 0005](docs/adr/0005-linux-packaging.md).

## Project status

The repository is in **foundation**. Work is delivered through sequenced GitHub
issues and small pull requests. The first implementation issue proves the risky
filesystem and Git assumptions before UI work begins.

## Start contributing

Humans should read [CONTRIBUTING.md](CONTRIBUTING.md). Coding agents must begin
with [AGENTS.md](AGENTS.md). Both lead to the same issue-driven workflow and
validation requirements.

## Principles

- Local-first and useful offline
- Explain state; do not hide it behind a score
- Read-only by default; confirm consequential actions
- Never execute repository-provided commands until the user trusts them
- Observe work; never run or supervise it
- Complement existing developer tools instead of rebuilding them
- Fast on a real workstation with many repositories
- Accessible, keyboard-first and visually calm
- No telemetry by default

## Licence

Apache-2.0. See [LICENSE](LICENSE).

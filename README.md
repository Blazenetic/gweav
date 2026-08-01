# gradar

**A local-first repository operations cockpit.**

gradar gives developers a calm, fast view across all Git repositories on a
workstation: what is dirty, unpublished, stale, failing, under review, or ready
to resume. It stays local, integrates with the tools developers already use,
and produces trustworthy handovers for people and coding agents.

The project is initially optimised for Linux, CachyOS, KDE Plasma and Wayland,
while keeping the core portable.

## Product promise

Open gradar and answer three questions in seconds:

1. What needs attention?
2. What is safe and current?
3. Where should I resume work?

gradar is not a full Git client, hosted platform, project manager, or autonomous
agent. It is the overview and launchpad between the filesystem, Git, editors,
terminals, task runners and optional forge integrations.

## V1 MVP+

- Discover repositories under configured roots without following unsafe paths.
- Show working-tree, branch, upstream, fetch-freshness, worktree, activity and
  disk-usage signals.
- Record test results against the exact commit and dirty-tree state tested.
- Link the current branch to a GitHub pull request when `gh` is available.
- Filter, group, pin and search repositories from a keyboard-first desktop UI.
- Open configured terminals, editors, file managers and Git tools.
- Run explicitly trusted tasks with confirmation, timeout and captured output.
- Copy deterministic compact, agent and diagnostic handovers.
- Expose the same read model through a small CLI and JSON output.
- Package for CachyOS through an AppImage and an AUR-friendly build path.

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
- Complement existing developer tools instead of rebuilding them
- Fast on a real workstation with many repositories
- Accessible, keyboard-first and visually calm
- No telemetry by default

## Licence

Apache-2.0. See [LICENSE](LICENSE).

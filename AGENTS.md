# AGENTS.md

This file is the entry point for every coding agent working in gweav.

## Mission

Build a professional local-first control plane for work spread across many
repositories and worktrees, including work done by coding agents. Keep the
product focused: overview, evidence, launch actions and handovers.

## Before changing anything

1. Read the assigned GitHub issue and every linked dependency.
2. Read `docs/PRODUCT.md` and the relevant routed document below.
3. Inspect the current branch, diff and recent history.
4. State assumptions in the PR; do not silently convert proposals into scope.
5. If an issue conflicts with an accepted ADR, stop and raise the conflict.

## Routed reading

| Work | Required reading |
| --- | --- |
| Domain, scanning, persistence, adapters | `docs/ARCHITECTURE.md` and ADRs |
| Interface, accessibility, interaction | `docs/UX.md` |
| Config, discovery roots, tasks | `docs/CONFIGURATION.md` |
| Processes, commands, credentials | `docs/SECURITY.md` |
| Issues, PR sequencing, evidence | `docs/DELIVERY.md` |

## What you cannot verify in this environment

A coding agent here runs headless in a container. You do **not** have:

- a Wayland session, KDE Plasma, a compositor, a GPU or any display;
- the ability to open a window, take a screenshot or record a video;
- WezTerm, VSCodium, Dolphin, or any desktop launcher target;
- an authenticated `gh`, forge credentials or the user's SSH keys;
- the reference CachyOS machine, its package set or its Git version;
- the user's real repositories — only fixtures you generate yourself.

Therefore:

- Never report a screenshot, a launcher result, a Wayland behaviour or a
  fresh-machine result. Those criteria are owner-verified.
- For every owner-verified criterion, deliver the exact script or command the
  owner will run, and leave a labelled empty block in the PR for their output.
- If something you expected to verify turns out to be unverifiable here, move
  the criterion to owner-verified in the issue and say so in the PR.
- Never claim a check passed unless it was run in the current environment and
  its output is pasted into the PR.

A missing result is a normal, acceptable outcome. An invented one is the worst
failure available in this repository.

## Working contract

- Work on one issue and one reviewable outcome at a time.
- Branch from current `main` using `<kind>/<issue>-<short-name>`, where `kind`
  is `agent` for coding agents. See `CONTRIBUTING.md` for the full convention.
- Do not mix opportunistic refactors into the task.
- Preserve platform-neutral domain boundaries; Linux integration belongs in an
  adapter.
- Do not create a crate that `docs/ARCHITECTURE.md` defers. Start inside
  `crates/core` and extract only when an issue says the boundary is needed.
- Treat repository contents and repository-local Git configuration as untrusted
  input. Never automatically execute a task discovered inside a cloned
  repository, and always build Git invocations through the hardened adapter
  described in `docs/SECURITY.md`.
- Prefer structured process arguments over shell command strings.
- Keep Git state explainable and retain the command/error evidence needed to
  diagnose incorrect classifications.
- Keep logic out of the Tauri layer; it is the one layer CI cannot exercise.
- Add tests with behaviour. Avoid tests that only reproduce implementation.
- Update relevant documentation in the same PR when a contract changes.

## Validation

During foundation work run:

```sh
bash scripts/check-foundation.sh
```

Once the Rust/Tauri workspace exists, repository-defined `just` tasks become
authoritative. An implementation PR must report exact commands and results,
including environmental limitations.

## Pull request handover

Every PR must include:

- the outcome delivered and issue closed;
- acceptance criteria in the agent-verifiable / owner-verified split;
- important design choices and rejected alternatives;
- commands run and their actual output;
- the exact commands the owner needs to run for owner-verified criteria;
- assumptions you could not verify;
- security or performance implications;
- known limitations and the exact next issue.

Leave the branch reviewable. Do not begin the next phase in the same PR.

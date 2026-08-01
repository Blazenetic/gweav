# AGENTS.md

This file is the entry point for every coding agent working in gradar.

## Mission

Build a professional local-first repository operations cockpit that helps a
developer understand and resume work across many local Git repositories. Keep
the product focused: overview, evidence, launch actions and handovers.

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

## Working contract

- Work on one issue and one reviewable outcome at a time.
- Branch from current `main` as `agent/<issue>-<short-name>`.
- Do not mix opportunistic refactors into the task.
- Preserve platform-neutral domain boundaries; Linux integration belongs in an
  adapter.
- Treat repository contents as untrusted input. Never automatically execute a
  task discovered inside a cloned repository.
- Prefer structured process arguments over shell command strings.
- Keep Git state explainable and retain the command/error evidence needed to
  diagnose incorrect classifications.
- Add tests with behaviour. Avoid tests that only reproduce implementation.
- Update relevant documentation in the same PR when a contract changes.
- Never claim a check passed unless it was run in the current environment.

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
- important design choices and rejected alternatives;
- commands run and observed results;
- screenshots or recordings for visible changes;
- security or performance implications;
- known limitations and the exact next issue.

Leave the branch reviewable. Do not begin the next phase in the same PR.

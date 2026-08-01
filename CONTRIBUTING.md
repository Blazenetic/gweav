# Contributing to gweav

Thank you for helping make local development calmer and easier to understand.

## Find a task

Start with an open GitHub issue that has explicit acceptance criteria. Comment
before beginning substantial work so contributors do not duplicate effort.
Early phases are intentionally sequenced; check dependencies in the issue.

For a new proposal, open a feature request and describe the user problem before
the implementation. A feature belongs in gweav when it improves multi-repo and
multi-worktree visibility, safe resumption, trusted local actions, or handover
quality.

## Branch naming

One convention, used by humans and coding agents alike:

```text
<kind>/<issue-number>-<short-name>
```

`kind` is one of `feature`, `fix`, `docs`, `spike`, or `agent` when the work is
produced by a coding agent. Examples:

```text
feature/5-repository-discovery
agent/4-evidence-model
spike/2-git-platform-risk
```

## Development flow

1. Fork or branch from current `main`.
2. Name the branch as above.
3. Keep commits understandable and the PR limited to one outcome.
4. Add or update tests and documentation.
5. Run the repository-defined checks and paste their output into the PR.
6. Open a draft PR early and complete the PR template.

Architecture changes require an ADR under `docs/adr/`. Small implementation
decisions can stay in code or the PR when they do not establish a lasting
contract.

## Evidence

Acceptance criteria are split into agent-verifiable and owner-verified, because
some behaviour needs a real Wayland desktop, real launchers or a clean machine.
See `docs/DELIVERY.md`. Report what you actually ran; state plainly what you
could not.

## Review standard

A change is ready when it:

- meets the linked issue acceptance criteria;
- behaves safely with malformed paths, unusual Git state, hostile repository
  configuration and missing tools;
- has meaningful automated coverage;
- keeps UI states accessible by keyboard and assistive technology;
- reports errors with enough context to act on them;
- includes evidence for performance or UX claims;
- introduces no silent command execution or telemetry.

## Scope discipline

gweav should open and orchestrate excellent existing tools. It should not grow
into an editor, terminal emulator, hosting service, issue tracker, complete Git
GUI, or a supervisor that runs coding agents.

## Community conduct and security

Be respectful, specific and generous in review. Report security problems using
the private process in [SECURITY.md](SECURITY.md), not a public issue.

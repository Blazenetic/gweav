# Contributing to gradar

Thank you for helping make local development calmer and easier to understand.

## Find a task

Start with an open GitHub issue that has explicit acceptance criteria. Comment
before beginning substantial work so contributors do not duplicate effort.
Early phases are intentionally sequenced; check dependencies in the issue.

For a new proposal, open a feature request and describe the user problem before
the implementation. A feature belongs in gradar when it improves multi-repo
visibility, safe resumption, trusted local actions, or handover quality.

## Development flow

1. Fork or branch from current `main`.
2. Use a narrow branch name such as `feature/42-repository-discovery`.
3. Keep commits understandable and the PR limited to one outcome.
4. Add or update tests and documentation.
5. Run the repository-defined checks.
6. Open a draft PR early and complete the PR template.

Architecture changes require an ADR under `docs/adr/`. Small implementation
decisions can stay in code or the PR when they do not establish a lasting
contract.

## Review standard

A change is ready when it:

- meets the linked issue acceptance criteria;
- behaves safely with malformed paths, unusual Git state and missing tools;
- has meaningful automated coverage;
- keeps UI states accessible by keyboard and assistive technology;
- reports errors with enough context to act on them;
- includes evidence for performance or UX claims;
- introduces no silent command execution or telemetry.

## Scope discipline

gradar should open and orchestrate excellent existing tools. It should not grow
into an editor, terminal emulator, hosting service, issue tracker, or complete
Git GUI.

## Community conduct and security

Be respectful, specific and generous in review. Report security problems using
the private process in [SECURITY.md](SECURITY.md), not a public issue.

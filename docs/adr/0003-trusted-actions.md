# 0003: Repository-provided actions are untrusted by default

- Status: Proposed
- Date: 2026-08-02

## Context

Tests and project tasks are useful signals, but a cloned repository can contain
arbitrary executable code or malicious task definitions. Automatic discovery
must not become automatic code execution.

## Decision

V1 actions originate in user-owned configuration. A future committed project
manifest is displayed as an untrusted suggestion until the user approves its
expanded executable, arguments, working directory and environment policy.
Approval is bound to the definition fingerprint and is revoked on change.

Automatic scans never execute configured tasks. Scheduling, if introduced,
requires separate opt-in per task and repository.

## Consequences

- First use has an intentional trust step.
- Task evidence can state exactly which definition ran.
- Convenient auto-detection may suggest but never silently run commands.
- Trust storage and invalidation become tested domain behaviour.

## Alternatives considered

- Trust every repository under a configured root: too broad.
- Trust manifests after the first repository visit: insufficiently explicit.
- Exclude tasks from V1: safer but removes a central product benefit.

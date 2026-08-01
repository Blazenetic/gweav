# MVP+ delivery system

## Operating model

GitHub is the delivery source of truth. Repository docs hold durable contracts;
issues define bounded outcomes; PRs contain implementation, evidence, review and
handover. Chat is never the only place where a decision or resumption point
exists.

## Sequence

| Phase | Outcome | Exit evidence |
| --- | --- | --- |
| 0 | Foundation and risk spike | accepted contracts and measured Git fixtures |
| 1 | Domain and local scanner | deterministic snapshots across topology fixtures |
| 2 | Desktop read-only cockpit | usable keyboard-first overview on CachyOS/KDE |
| 3 | Persistence and configuration | migrations, profiles and validated settings |
| 4 | Worktrees, tasks and forge evidence | trusted execution and freshness semantics |
| 5 | Actions and handovers | guarded operations and deterministic exports |
| 6 | Performance, packaging and release | workload evidence, AppImage and V1 docs |

The live GitHub issues carry exact scope and dependencies. This table is a map,
not a second backlog.

## One issue, one PR

An issue must describe:

- user or engineering outcome;
- context and constraints;
- in-scope and out-of-scope work;
- acceptance criteria observable by a reviewer;
- dependencies;
- required evidence;
- exact next action.

Each PR closes one primary issue. If discoveries materially change the outcome,
update or split the issue before expanding the diff.

## Agent autonomy

An agent may independently:

- inspect code and documented dependencies;
- choose implementation details inside accepted contracts;
- add tests and diagnostics required by the issue;
- repair directly caused lint, type or test failures;
- document evidence and open a draft PR.

An agent must stop and request review before:

- crossing an explicit non-goal or trust boundary;
- changing an accepted ADR;
- adding a service, framework or persistent background daemon;
- introducing telemetry, automatic command execution or credential storage;
- weakening tests to make a check pass;
- combining separately reviewable phases.

## Review gates

Every implementation PR reports:

1. acceptance criteria and how each was demonstrated;
2. automated checks with exact commands;
3. manual evidence for behaviour not reasonably automated;
4. screenshots for visible interface changes;
5. performance evidence when scan/UI latency is affected;
6. security impact for process, path, network or persistence changes;
7. known limitations and the next issue.

## Decision management

Accepted ADRs define lasting architecture. A proposed replacement is added as a
new ADR that supersedes the old one after review; historical ADRs are not
rewritten. Product-scope changes update `docs/PRODUCT.md` in the same PR.

## Release definition

V1 requires all phase exit evidence, clean CI, documented configuration,
installation and recovery paths, a fresh-machine smoke test on CachyOS/KDE/
Wayland, licence notices and a changelog. Features not needed for that outcome
remain issues for later releases rather than silently joining V1.

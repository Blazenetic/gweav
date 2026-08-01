# MVP+ delivery system

## Operating model

GitHub is the delivery source of truth. Repository docs hold durable contracts;
issues define bounded outcomes; PRs contain implementation, evidence, review and
handover. Chat is never the only place where a decision or resumption point
exists.

## Sequence

Issue numbers are authoritative. This table is a map, not a second backlog: if
it disagrees with an issue, the issue wins and the table is wrong.

| Issue | Phase label | Outcome |
| --- | --- | --- |
| #1 | Foundation | Accepted product and engineering contracts |
| #2 | Phase 0 | Git, filesystem and desktop risk spike |
| #3 | Phase 1A | Workspace scaffold, desktop shell and quality gates |
| #4 | Phase 1B | Evidence model and state classification |
| #5 | Phase 1C | Discovery, local snapshots and a useful CLI |
| #6 | Phase 2A | Versioned configuration, profiles and SQLite |
| #7 | Phase 2B | Accessible visual system and desktop navigation |
| #8 | Phase 2C | Read-only cockpit and inspector |
| #9 | Phase 3A | Worktree, remote freshness and pull request intelligence |
| #10 | Phase 3B | Trusted tasks and commit-aware test evidence |
| #11 | Phase 4 | Guarded Git actions and deterministic handovers |
| #12 | Phase 5 | Performance, packaging and V1 release |

Phase labels exist only to communicate ordering. Never introduce a second
numbering scheme for the same work.

## One issue, one PR

An issue must describe:

- user or engineering outcome;
- context and constraints;
- in-scope and out-of-scope work;
- acceptance criteria observable by a reviewer, split into agent-verifiable and
  owner-verified;
- dependencies;
- required evidence;
- exact next action.

Each PR closes one primary issue. If discoveries materially change the outcome,
update or split the issue before expanding the diff.

An issue whose diff cannot plausibly be reviewed in one sitting should be split
before work begins, not after. Review capacity is the scarce resource in this
project, not implementation capacity.

## Verification split

Some acceptance criteria cannot be demonstrated by a coding agent running in a
headless environment: anything needing a Wayland session, KDE, a GPU, a
desktop launcher, an authenticated `gh`, or a clean reference machine.

Every issue therefore separates:

- **Agent-verifiable** — demonstrable by commands in a headless container, with
  the exact command and output pasted into the PR.
- **Owner-verified** — demonstrable only by the repository owner on the
  reference environment.

Rules:

1. An agent must never mark an owner-verified criterion as met.
2. For each owner-verified criterion, the agent supplies the exact script,
   command or checklist the owner will run, and a place to paste the result.
3. A PR is mergeable when the agent-verifiable criteria are demonstrated and the
   owner has recorded the owner-verified results in the PR.
4. If a criterion is unexpectedly unverifiable in the agent environment, the
   agent moves it to owner-verified in the issue and says so, rather than
   inferring a result.

Inferred, remembered or plausible results are not evidence. Fabricating one is
the most serious process failure available in this repository.

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
- extracting a crate that the architecture contract defers;
- combining separately reviewable phases.

## Review gates

Every implementation PR reports:

1. acceptance criteria and how each was demonstrated, in the agent/owner split;
2. automated checks with exact commands and output;
3. manual evidence for behaviour not reasonably automated;
4. screenshots for visible interface changes, or an explicit statement that the
   environment could not produce them;
5. performance evidence when scan/UI latency is affected;
6. security impact for process, path, network or persistence changes;
7. assumptions that could not be verified;
8. known limitations and the next issue.

CI is the primary review instrument. From #3 onward, a PR whose checks are not
green is not ready for human attention.

## Decision management

Accepted ADRs define lasting architecture. A proposed replacement is added as a
new ADR that supersedes the old one after review; historical ADRs are not
rewritten. A proposed ADR may still be amended in place until it is accepted.
Product-scope changes update `docs/PRODUCT.md` in the same PR.

## Release definition

V1 requires all phase exit evidence, clean CI, documented configuration,
installation and recovery paths, a fresh-machine smoke test on CachyOS/KDE/
Wayland from the documented source build, licence notices and a changelog.

Portable bundles are not a V1 gate (ADR 0005). Features not needed for the V1
outcome remain issues for later releases rather than silently joining V1.

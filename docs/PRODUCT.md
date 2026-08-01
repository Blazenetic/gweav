# Product contract

## Problem

Developers working across many local repositories repeatedly inspect
directories one at a time to discover dirty trees, unpublished commits,
obsolete branches, active worktrees, stale test evidence and related pull
requests. Existing tools usually optimise for deep work inside one repository
or for remote forge activity.

Delegating work to coding agents makes this sharply worse. A single day can
produce a dozen worktrees on generated branches, each with its own dirty state,
its own test run of unknown age and its own pull request. The expensive question
stops being "what is the diff here?" and becomes "which of these thirty places
still needs me, and which are finished?"

gradar provides one trustworthy local overview and launches the user's preferred
tools for deeper work.

## Primary user

V1 is designed around an individual developer using Linux with approximately
10–200 repositories, multiple worktrees per repository, and a mixture of human
and coding-agent work in flight at the same time. CachyOS with KDE Plasma and
Wayland is the first reference environment.

The design must remain portable enough for later validation on other Linux
distributions, macOS and Windows. Cross-platform packaging is not a V1 gate.

## Core jobs

1. Find unfinished or risky work before it is forgotten.
2. Resume a repository or worktree in the correct terminal, editor or shell.
3. Know whether local test evidence still applies to current code.
4. Understand local/remote state without implying a fetch happened when it did
   not.
5. Hand coherent state to another person or coding agent.
6. Recognise finished work and reclaim the space and attention it holds.

## Unit of work

The **worktree** is the primary unit gradar reasons about, groups by identity
and acts on. A repository is a grouping of worktrees that share a Git common
directory, and repository-level views are rollups over worktree state.

This inverts the usual repository-row model and is recorded in
[ADR 0004](adr/0004-worktree-primary-unit.md). It exists because the thing a
user resumes, hands over, finishes or deletes is a worktree, and because agent
workflows routinely produce more worktrees than repositories.

The default overview may still present one row per repository for compactness,
but that row is a summary of worktree state, never a substitute for it, and
expanding to worktree rows must not lose information.

## Repository and worktree states

The interface uses explainable signals rather than a composite score:

- **Attention**: failed current tests, divergence, broken worktree, failed scan,
  or another actionable fault.
- **Unpublished**: commits ahead of upstream or a branch lacking an upstream.
- **In progress**: dirty tree, staged changes or active secondary worktrees.
- **Active now**: evidence that something is currently working in this worktree,
  such as a held index lock or very recent write activity.
- **Waiting**: clean pushed branch associated with an open pull request.
- **Quiet**: clean and current according to available evidence.
- **Finished**: the branch is merged into its integration branch, or its pull
  request is merged or closed, and nothing local is unpublished.
- **Reclaimable**: finished or prunable, with a measured amount of disk held.
- **Dormant**: last activity exceeds a user-configured threshold.
- **Ignored**: excluded from attention calculations by the user.

A repository or worktree may carry several signals at once. The UI always
exposes the evidence and timestamp behind each one.

`Finished` and `Reclaimable` are reported, never acted on automatically.
Removing a worktree or branch is an explicit, confirmed, single-target user
action. V1 may present the list without offering any deletion at all.

## Provenance

Where the evidence is cheap and local, gradar labels the likely origin of a
worktree's work — for example a branch-name convention such as `agent/*`,
`claude/*` or `codex/*`, or the presence of agent instruction files in the
tree. Provenance is a filterable hint derived from observable facts. It is
never a claim of authorship and never a trust decision.

## V1 capabilities

### Observe

- configured-root discovery with exclusions and bounded traversal;
- dirty/staged/untracked counts without exposing file contents globally;
- current branch, detached HEAD, upstream and ahead/behind state;
- remote-state freshness and explicit unknown/offline states;
- linked worktrees grouped under their common Git directory, including locked,
  prunable and missing worktrees;
- merged-branch and closed/merged pull request detection;
- in-progress indicators for a worktree being written to right now;
- last commit time, local branch age and missing upstreams;
- disk size from cached, cancellable measurement, attributable to reclaimable
  work;
- trusted task result tied to commit, dirty fingerprint and timestamp;
- optional current-branch GitHub pull request lookup through `gh`, including
  review and check state.

### Act

- open terminal, editor, file manager, Git UI, remote or pull request;
- copy path, branch and handover;
- fetch explicitly;
- run a user-approved configured task;
- provide guarded staged-commit and labelled-stash actions only after the
  read-only experience is proven.

### Organise

- profiles, groups, pins, saved filters and search;
- filter and group by signal, provenance, root and repository;
- per-root and per-repository local overrides;
- compact, comfortable and dense layouts;
- import/export of non-secret configuration.

## Success measures

V1 is successful when a first-time user can:

- configure a discovery root and see useful results in under two minutes;
- identify every deliberately planted dirty/unpushed/test-failure fixture;
- understand when remote and test evidence was last refreshed;
- list every worktree whose work is finished, with the disk it holds;
- open the intended editor or terminal without editing application code;
- copy an accurate handover for a selected repository or worktree;
- operate primary navigation without a mouse;
- scan 100 ordinary repositories without UI blocking.

Exact latency budgets will be established from the scanner spike rather than
invented in advance.

## Non-goals for V1

- diff editing, partial staging or conflict resolution;
- interactive rebase and comprehensive branch management;
- cloud accounts, sync, teams or central servers;
- issue/PR authoring and merge administration;
- autonomous cleanup, bulk deletion or autonomous agent execution;
- launching, supervising or scheduling coding agents;
- plugin marketplace, embedded terminal or editor;
- AI-generated summaries as a requirement.

## Product principles

- Evidence has a source and freshness.
- Unknown is a valid state and must not be rendered as healthy.
- Safe actions are fast; destructive actions are explicit and reviewable.
- Observation describes work; it never performs or supervises it.
- Great defaults are paired with escape hatches.
- The dashboard remains useful with no network and no GitHub account.
- Configuration errors identify the field, source and corrective action.

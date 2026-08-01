# Product contract

## Problem

Developers working across many local repositories repeatedly inspect directories
one at a time to discover dirty trees, unpublished commits, obsolete branches,
active worktrees, stale test evidence and related pull requests. Existing tools
usually optimise for deep work inside one repository or remote forge activity.

gradar provides one trustworthy local overview and launches the user's preferred
tools for deeper work.

## Primary user

V1 is designed around an individual developer using Linux with approximately
10–200 repositories, multiple worktrees and a mixture of human and coding-agent
work. CachyOS with KDE Plasma and Wayland is the first reference environment.

The design must remain portable enough for later validation on other Linux
distributions, macOS and Windows. Cross-platform packaging is not a V1 gate.

## Core jobs

1. Find unfinished or risky work before it is forgotten.
2. Resume a repository in the correct terminal, editor or worktree.
3. Know whether local test evidence still applies to current code.
4. Understand local/remote state without implying a fetch happened when it did
   not.
5. Hand coherent repository state to another person or coding agent.

## Repository states

The interface uses explainable signals rather than a composite score:

- **Attention**: failed current tests, divergence, broken worktree, failed scan,
  or another actionable fault.
- **Unpublished**: commits ahead of upstream or a branch lacking an upstream.
- **In progress**: dirty tree, staged changes or active secondary worktrees.
- **Waiting**: clean pushed branch associated with an open pull request.
- **Quiet**: clean and current according to available evidence.
- **Dormant**: last activity exceeds a user-configured threshold.
- **Ignored**: excluded from attention calculations by the user.

A repository may have several signals. The UI always exposes the evidence and
timestamp behind each one.

## V1 capabilities

### Observe

- configured-root discovery with exclusions and bounded traversal;
- dirty/staged/untracked counts without exposing file contents globally;
- current branch, detached HEAD, upstream and ahead/behind state;
- remote-state freshness and explicit unknown/offline states;
- linked worktrees grouped under their common Git directory;
- last commit time, local branch age and missing upstreams;
- disk size from cached, cancellable measurement;
- trusted task result tied to commit, dirty fingerprint and timestamp;
- optional current-branch GitHub PR lookup through `gh`.

### Act

- open terminal, editor, file manager, Git UI, remote or pull request;
- copy path, branch and handover;
- fetch explicitly;
- run a user-approved configured task;
- provide guarded staged-commit and labelled-stash actions only after the
  read-only experience is proven.

### Organise

- profiles, groups, pins, saved filters and search;
- per-root and per-repository local overrides;
- compact, comfortable and dense layouts;
- import/export of non-secret configuration.

## Success measures

V1 is successful when a first-time user can:

- configure a discovery root and see useful results in under two minutes;
- identify every deliberately planted dirty/unpushed/test-failure fixture;
- understand when remote and test evidence was last refreshed;
- open the intended editor or terminal without editing application code;
- copy an accurate handover for a selected repository;
- operate primary navigation without a mouse;
- scan 100 ordinary repositories without UI blocking.

Exact latency budgets will be established from the scanner spike rather than
invented in advance.

## Non-goals for V1

- diff editing, partial staging or conflict resolution;
- interactive rebase and comprehensive branch management;
- cloud accounts, sync, teams or central servers;
- issue/PR authoring and merge administration;
- autonomous cleanup or autonomous agent execution;
- plugin marketplace, embedded terminal or editor;
- AI-generated summaries as a requirement.

## Product principles

- Evidence has a source and freshness.
- Unknown is a valid state and must not be rendered as healthy.
- Safe actions are fast; destructive actions are explicit and reviewable.
- Great defaults are paired with escape hatches.
- The dashboard remains useful with no network and no GitHub account.
- Configuration errors identify the field, source and corrective action.

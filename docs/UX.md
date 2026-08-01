# Experience design contract

## Character

gweav should feel like a professional developer instrument: calm, precise,
fast and information-dense without becoming noisy. Decoration supports
orientation; it never competes with repository state.

The reference desktop is a widescreen KDE Plasma/Wayland workstation, but the
layout must remain effective in an ordinary resizable window.

## Information architecture

### Overview

- summary strip with actionable counts and freshness;
- saved views and profile selector;
- sortable table as the primary surface;
- search and command palette;
- optional detail inspector without losing list context.

### Rows and grouping

The worktree is the unit of work (ADR 0004). The table therefore supports two
row modes:

- **Repository rows** (default): one row per repository, summarising its
  worktrees, expandable in place.
- **Worktree rows**: one row per worktree, for triage and cleanup.

A repository row must never display a state that contradicts a worktree it
contains, and must indicate when its worktrees disagree. Expanding a repository
row must not lose any information available in worktree row mode.

Default columns:

| Column | Purpose |
| --- | --- |
| Name | Repository or worktree name, group, pin and scan errors |
| Signals | Explainable attention/in-progress/waiting/finished states |
| Branch | Current branch or detached HEAD |
| Sync | Ahead/behind/upstream plus fetch freshness |
| Worktrees | Count, active/broken/prunable indications (repository rows) |
| Tests | Passed/failed/outdated/never run |
| Activity | Relative last-commit time |
| PR | Optional linked pull request with review and check state |
| Size | Cached disk measurement |

Columns can be hidden and reordered. Dense, comfortable and compact row modes
are supported; large cards are not the default.

### Finished work

Finished and reclaimable work is presented as a reviewable list, sorted by disk
held, showing for each entry the evidence that it is finished — merged into
which branch, or which pull request in which state, observed when.

The list never selects entries for the user, never offers a bulk action in V1,
and treats a missing or stale merge signal as unknown rather than finished.

### Provenance

Provenance is a low-emphasis, filterable label — not a badge competing with
state. It is never presented as an authorship claim, and it never changes what
gweav is willing to do.

### Repository inspector

- reasons and evidence for every signal;
- worktree list with exact paths, lock and prune state;
- changed-file counts, not unsolicited file contents;
- recent commits;
- remotes and observation timestamps;
- task results and short output excerpt;
- contextual launch, copy and guarded Git actions.

### Command palette

All common navigation and safe actions are discoverable through a fuzzy command
palette. Commands show their target and shortcut before execution.

## Interaction principles

- A first scan is progressive and usable before every root finishes.
- Selection remains stable across refreshes, sorting and row-mode changes.
- Background changes animate subtly and never reorder the list while the user
  is interacting unless explicitly requested.
- Destructive or state-changing actions name the repository, worktree and exact
  operation in confirmation UI.
- Errors remain attached to the affected evidence and can be copied.
- Empty, loading, offline, unknown and permission-denied states are designed,
  not treated as edge cases.

## Accessibility

- complete keyboard operation with visible focus;
- semantic table/list structure and labelled controls;
- expandable rows exposed with correct roles and expansion state;
- no information encoded by colour alone;
- contrast meeting WCAG 2.2 AA;
- reduced-motion support;
- scalable text without clipped status content;
- screen-reader announcements for completed user-triggered actions, not every
  background refresh.

## Visual direction

- inherit system light/dark preference by default;
- neutral surfaces with a restrained accent colour;
- status colours reserved for meaning;
- monospaced text only where code-like alignment helps;
- icons paired with labels or accessible names;
- timestamps shown relatively with exact time available on hover/focus.

The UI implementation must include screenshots at common window sizes and a
short keyboard walkthrough in its PR evidence. Both are owner-verified: a
coding agent cannot produce them and must supply the walkthrough script
instead.

## KDE integration

V1 should provide presets for Dolphin, Konsole, WezTerm and VSCodium; a desktop
entry; clipboard integration; and native Wayland behaviour. Tray mode, global
shortcut and notifications are polish-phase features and must be individually
configurable.

Notifications should describe meaningful transitions, such as a trusted test
changing from passing to failing, or a watched pull request merging. They must
not report every dirty file change.

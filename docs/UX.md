# Experience design contract

## Character

gradar should feel like a professional developer instrument: calm, precise,
fast and information-dense without becoming noisy. Decoration supports
orientation; it never competes with repository state.

The reference desktop is a widescreen KDE Plasma/Wayland workstation, but the
layout must remain effective in an ordinary resizable window.

## Information architecture

### Overview

- summary strip with actionable counts and freshness;
- saved views and profile selector;
- sortable repository table as the primary surface;
- search and command palette;
- optional detail inspector without losing list context.

Default columns:

| Column | Purpose |
| --- | --- |
| Repository | Name, group, pin and scan errors |
| Signals | Explainable attention/in-progress/waiting states |
| Branch | Current branch or detached HEAD |
| Sync | Ahead/behind/upstream plus fetch freshness |
| Worktrees | Count and active/broken indications |
| Tests | Passed/failed/outdated/never run |
| Activity | Relative last-commit time |
| PR | Optional linked pull request |
| Size | Cached disk measurement |

Columns can be hidden and reordered. Dense, comfortable and compact row modes
are supported; large cards are not the default.

### Repository inspector

- reasons and evidence for every signal;
- worktree list and exact paths;
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
- Selection remains stable across refreshes and sorting.
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
short keyboard walkthrough in its PR evidence.

## KDE integration

V1 should provide presets for Dolphin, Konsole, WezTerm and VSCodium; a desktop
entry; clipboard integration; and native Wayland behaviour. Tray mode, global
shortcut and notifications are polish-phase features and must be individually
configurable.

Notifications should describe meaningful transitions, such as a trusted test
changing from passing to failing. They must not report every dirty file change.

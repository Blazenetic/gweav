# Configuration contract

## Goals

Configuration should be understandable, portable where practical, and safe to
share after secrets and machine-specific paths are removed. The application
uses XDG directories on Linux and supplies a validated settings interface.

## Sources and precedence

From lowest to highest precedence:

1. built-in defaults;
2. user config at `$XDG_CONFIG_HOME/gradar/config.toml`;
3. selected profile;
4. user-owned local override for a repository.

V1 does not automatically load or execute a `.gradar.toml` committed inside a
repository. A future project manifest requires an explicit trust flow and a
separate ADR.

## Illustrative configuration

```toml
version = 1

[discovery]
roots = ["~/Code", "~/Projects"]
exclude = ["**/node_modules/**", "**/.cache/**", "**/vendor/**"]
max_depth = 5
follow_symlinks = false
cross_filesystems = false
concurrency = 8

[health]
dormant_repository_days = 30
stale_branch_days = 21
dirty_warning_days = 3
remote_evidence_minutes = 60

[launchers]
terminal = ["wezterm", "start", "--cwd", "{path}"]
editor = ["codium", "{path}"]
file_manager = ["dolphin", "{path}"]
git_ui = ["wezterm", "start", "--cwd", "{path}", "--", "lazygit"]

[[tasks]]
id = "test"
label = "Test"
executable = "just"
args = ["test"]
timeout_seconds = 900
capture_limit_kib = 512
requires_confirmation = true

[[profiles]]
id = "complex-state"
label = "Complex State"
include_roots = ["~/Code/complex-state"]
```

This example is a design aid, not a frozen schema. The configuration PR must
publish a formal schema, compatibility rules and error examples.

## Validation

- reject unknown schema versions;
- report the source file and field path for invalid values;
- expand `~` and environment variables through an explicit documented policy;
- never print secret environment-variable values;
- detect duplicate IDs and contradictory root rules;
- preview resolved discovery roots and commands before saving;
- preserve comments when practical, otherwise warn before a rewriting action.

## Launcher placeholders

Only a small allowlist is supported, beginning with `{path}`, `{branch}` and
`{remote_url}`. Substitution produces individual process arguments; it never
creates a shell expression. Missing values disable the action with a reason.

## Import and export

Export excludes cache, task logs, credentials and trust decisions by default.
Imported configuration is validated and previewed before activation.

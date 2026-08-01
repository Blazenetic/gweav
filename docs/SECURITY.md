# Security and trust model

## Assets

gradar operates near private source code, Git credentials, SSH configuration,
developer tokens and executable build systems. It must protect:

- repository contents and metadata;
- credentials inherited by child processes;
- working-tree, index, refs and Git configuration integrity;
- user intent when launching commands;
- local paths and activity history;
- the availability of the workstation.

## Trust boundaries

1. **User configuration** is trusted intent after validation.
2. **Repository contents** are untrusted, including config-looking files,
   hooks, submodules, filenames and task definitions.
3. **Git and launcher output** is untrusted structured input.
4. **Forge metadata** is untrusted network content.
5. **Child processes** receive only the required arguments, directory and
   environment.

## Non-negotiable controls

- Observation never executes repository code or hooks.
- Process creation uses executable and argument arrays, not a shell by default.
- All child processes have timeouts, output limits and cancellation.
- `GIT_TERMINAL_PROMPT=0` is used for background observation.
- No state-changing Git command runs during an automatic scan.
- Repository task configuration is inert until explicitly trusted by path and
  content fingerprint.
- Trust is revoked when a trusted definition changes.
- Confirmations show expanded executable, arguments and working directory.
- Sensitive environment variables are opt-in for tasks.
- Logs redact configured secrets and are bounded in size and retention.
- URLs are opened through validated schemes.
- Symlink traversal and filesystem boundaries follow explicit policy.
- No analytics or crash upload occurs without informed opt-in.

## Action classes

| Class | Examples | Default policy |
| --- | --- | --- |
| Observe | `git status`, worktree list, log | Automatic, read-only |
| Launch | editor, terminal, browser | One action, configured executable |
| Network metadata | GitHub PR lookup | Optional, capability-gated |
| Ref update | fetch, push | Explicit user action and result |
| Working-tree change | stash, commit | Preview and confirmation |
| Arbitrary task | test, build, custom task | Explicit trust and confirmation |

## Threat-driven tests

Fixtures must include malicious filenames, invalid UTF-8 paths where supported,
symlink loops, huge output, hung processes, Git aliases, hostile repository
config, nested repositories and task definitions changed after trust.

Security-sensitive PRs must identify the threat addressed and include a
regression test. Convenience is not sufficient justification to weaken a trust
boundary.

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
3. **Repository-local Git configuration** is untrusted and can name programs
   that Git will execute during ordinary commands.
4. **Git and launcher output** is untrusted structured input.
5. **Forge metadata** is untrusted network content.
6. **Child processes** receive only the required arguments, directory and
   environment.

## Observation is not read-only by default

Scanning an untrusted repository with ordinary Git commands can execute code
chosen by that repository. This is the most easily overlooked risk in gradar's
design, because the commands involved look passive.

Known execution and interference paths:

| Path | Effect |
| --- | --- |
| `core.fsmonitor` | Names a program that `git status` runs |
| `core.hooksPath` and hooks | Reached through commands that trigger `gc --auto` |
| `gc.auto` | Turns an observation into a background repository mutation |
| `diff.*.textconv`, `diff.external` | Runs a program during diff-like commands |
| `filter.*.process` | Long-lived helper process for filtered paths |
| Aliases | Shadow a subcommand name with arbitrary behaviour |
| `protocol.ext` | Executes a command for `ext::` remote URLs |
| `credential.helper` | Runs a helper program on any authenticated operation |
| `uploadpack.*`, `receive.*` | Repository-controlled remote-side hooks |
| Index locks | A passive-looking command can block a concurrent agent |

### Hardened invocation contract

Every observation invocation must be constructed by a single adapter function
that applies all of the following. Individual call sites must not build their
own argument lists.

Configuration overrides passed as leading `-c` arguments:

```text
-c core.fsmonitor=false
-c core.hooksPath=/dev/null
-c gc.auto=0
-c maintenance.auto=false
-c diff.external=
-c protocol.ext.allow=never
-c credential.helper=
-c advice.detachedHead=false
```

Environment:

```text
GIT_TERMINAL_PROMPT=0
GIT_OPTIONAL_LOCKS=0
GIT_ASKPASS=
SSH_ASKPASS=
GIT_CONFIG_PARAMETERS unset
GIT_ALTERNATE_OBJECT_DIRECTORIES unset
LC_ALL=C
```

Invocation rules:

- never invoke a subcommand name that an alias could shadow without `--no-...`
  equivalent protection; prefer plumbing commands, which aliases cannot shadow;
- never pass `--textconv`, `--ext-diff` or `--patch` during observation;
- always pass `--` before user-controlled paths;
- always set an explicit working directory and never rely on the inherited one;
- always apply a timeout, an output cap and cancellation.

`GIT_OPTIONAL_LOCKS=0` is a correctness requirement as well as a safety one:
gradar observes repositories that a human or coding agent may be actively
using, and must not take a lock that interrupts them.

### Ownership refusal

Git refuses to operate on repositories owned by another user unless they appear
in `safe.directory`. gradar must surface this as a named capability state with a
copyable remedy, never as a scan crash and never by adding `safe.directory`
entries on the user's behalf.

## Non-negotiable controls

- Observation never executes repository code or hooks, enforced through the
  hardened invocation contract above rather than by convention.
- Process creation uses executable and argument arrays, not a shell by default.
- All child processes have timeouts, output limits and cancellation.
- No state-changing Git command runs during an automatic scan, including
  implicit maintenance.
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
| Observe | `git status`, worktree list, log | Automatic, hardened, read-only |
| Launch | editor, terminal, browser | One action, configured executable |
| Network metadata | GitHub PR lookup | Optional, capability-gated |
| Ref update | fetch, push | Explicit user action and result |
| Working-tree change | stash, commit | Preview and confirmation |
| Arbitrary task | test, build, custom task | Explicit trust and confirmation |

## Threat-driven tests

Fixtures must include:

- a repository whose local config sets `core.fsmonitor` to a program that
  writes a marker file, asserting the marker is never created;
- the same for `core.hooksPath`, `diff.external` and a `credential.helper`;
- an alias shadowing a subcommand gradar invokes;
- an `ext::` remote URL;
- a repository owned by another user, or a simulated ownership refusal;
- malicious filenames, invalid UTF-8 paths where supported, symlink loops;
- huge output, hung processes, nested repositories;
- task definitions changed after trust.

Security-sensitive PRs must identify the threat addressed and include a
regression test. Convenience is not sufficient justification to weaken a trust
boundary.

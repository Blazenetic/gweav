#!/usr/bin/env bash
set -euo pipefail

# Zero-dependency contract checks. These guard the promises the foundation
# makes to coding agents; they are not a substitute for the real quality gates
# that arrive with the Rust workspace.

failures=0

fail() {
  echo "FAIL: $1" >&2
  failures=$((failures + 1))
}

required_files=(
  README.md
  AGENTS.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
  docs/PRODUCT.md
  docs/ARCHITECTURE.md
  docs/UX.md
  docs/CONFIGURATION.md
  docs/SECURITY.md
  docs/DELIVERY.md
  docs/adr/README.md
  docs/adr/0001-application-stack.md
  docs/adr/0002-system-git.md
  docs/adr/0003-trusted-actions.md
  docs/adr/0004-worktree-primary-unit.md
  docs/adr/0005-linux-packaging.md
  .github/PULL_REQUEST_TEMPLATE.md
)

for required_file in "${required_files[@]}"; do
  if [[ ! -s "$required_file" ]]; then
    fail "missing or empty required file: $required_file"
  fi
done

if grep -RInE --include='*.md' --include='*.yml' --include='*.yaml' \
  --include='*.toml' '[[:blank:]]+$' .; then
  fail "trailing whitespace found"
fi

# Agents must be routed to the product contract and told what they cannot
# verify, because acceptance criteria depend on that distinction.
grep -q 'docs/PRODUCT.md' AGENTS.md ||
  fail "AGENTS.md must route agents to the product contract"

grep -q '## What you cannot verify in this environment' AGENTS.md ||
  fail "AGENTS.md must state the limits of the agent environment"

grep -q 'owner-verified' AGENTS.md ||
  fail "AGENTS.md must describe the owner-verified criteria split"

grep -q '## Verification split' docs/DELIVERY.md ||
  fail "docs/DELIVERY.md must define the verification split"

grep -q 'Acceptance criteria (owner-verified)' \
  .github/ISSUE_TEMPLATE/task.yml ||
  fail "the task template must separate owner-verified criteria"

for heading in \
  'Acceptance evidence — agent-verifiable' \
  'Acceptance evidence — owner-verified' \
  'Assumptions I could not verify'; do
  grep -qF "$heading" .github/PULL_REQUEST_TEMPLATE.md ||
    fail "the PR template must contain the section: $heading"
done

# One branch convention, stated identically in both entry points.
for entry_point in AGENTS.md CONTRIBUTING.md; do
  grep -qF '<kind>/<issue' "$entry_point" ||
    fail "$entry_point must state the shared branch convention"
done

# Relative links between contracts must resolve, so routed reading cannot
# silently break when a document is renamed.
while IFS= read -r source_file; do
  while IFS= read -r target; do
    [[ -z "$target" ]] && continue
    target="${target%%#*}"
    [[ -z "$target" ]] && continue
    resolved="$(dirname "$source_file")/$target"
    if [[ ! -e "$resolved" ]]; then
      fail "broken link in $source_file: $target"
    fi
  done < <(grep -oE '\]\([^):]*\.md[^)]*\)' "$source_file" |
    sed -E 's/^\]\(//; s/\)$//' || true)
done < <(find . -name '*.md' -not -path './.git/*')

if ((failures > 0)); then
  echo "foundation checks failed: $failures" >&2
  exit 1
fi

echo "foundation checks passed"

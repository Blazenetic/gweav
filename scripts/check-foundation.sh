#!/usr/bin/env bash
set -euo pipefail

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
)

for required_file in "${required_files[@]}"; do
  if [[ ! -s "$required_file" ]]; then
    echo "missing or empty required file: $required_file" >&2
    exit 1
  fi
done

if grep -RInE --include='*.md' --include='*.yml' --include='*.yaml' \
  --include='*.toml' '[[:blank:]]+$' .; then
  echo "trailing whitespace found" >&2
  exit 1
fi

if ! grep -q 'docs/PRODUCT.md' AGENTS.md; then
  echo "AGENTS.md must route agents to the product contract" >&2
  exit 1
fi

echo "foundation checks passed"

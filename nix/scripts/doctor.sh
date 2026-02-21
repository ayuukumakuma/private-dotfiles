#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

echo "=== nix version ==="
command -v nix || true
if ! command -v nix >/dev/null 2>&1; then
  echo "nix が未導入です。./scripts/bootstrap.sh を先に実行してください。"
  exit 0
fi

nix --version || true

echo "=== nix doctor ==="
nix doctor || true

echo "=== flake metadata ==="
nix flake metadata . || true

echo "=== flake check ==="
nix flake check || true

echo "=== darwin build ==="
if command -v darwin-rebuild >/dev/null 2>&1; then
  darwin-rebuild build --flake .#ayuu-mac || true
else
  echo "darwin-rebuild が見つかりません。./scripts/bootstrap.sh で初期化してください。"
fi

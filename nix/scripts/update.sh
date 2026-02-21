#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

nix flake update
nix flake check

if command -v darwin-rebuild >/dev/null 2>&1; then
  darwin-rebuild build --flake .#ayuu-mac
else
  sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- build --flake .#ayuu-mac
fi

./scripts/switch.sh

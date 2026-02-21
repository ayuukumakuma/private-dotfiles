#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

if command -v darwin-rebuild >/dev/null 2>&1; then
  darwin-rebuild switch --flake .#ayuu-mac
else
  sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .#ayuu-mac
fi

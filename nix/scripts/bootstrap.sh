#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

if ! command -v nix >/dev/null 2>&1; then
  echo "Nix が見つかりません。Determinate Installer で導入します。"
  curl --proto '=https' --tlsv1.2 -sSfL https://install.determinate.systems/nix | sh -s -- install
  echo "新しいシェルを開いてから、再度 ./scripts/bootstrap.sh を実行してください。"
  exit 0
fi

if command -v darwin-rebuild >/dev/null 2>&1; then
  darwin-rebuild switch --flake .#ayuu-mac
else
  sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .#ayuu-mac
fi

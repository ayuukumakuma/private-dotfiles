#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"
source "${ROOT_DIR}/scripts/lib-darwin-rebuild.sh"

if ! command -v nix >/dev/null 2>&1; then
  echo "Nix が見つかりません。NixOS/nix-installer で導入します。"
  curl -sSfL https://artifacts.nixos.org/nix-installer | sh -s -- install
  echo "新しいシェルを開いてから、再度 ./scripts/bootstrap.sh を実行してください。"
  exit 0
fi

darwin_rebuild switch

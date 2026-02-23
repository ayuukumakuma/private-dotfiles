#!/usr/bin/env bash

darwin_rebuild() {
  local action="$1"
  shift

  if command -v darwin-rebuild >/dev/null 2>&1; then
    darwin-rebuild "${action}" --flake .#ayuu-mac "$@"
    return
  fi

  sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- "${action}" --flake .#ayuu-mac "$@"
}

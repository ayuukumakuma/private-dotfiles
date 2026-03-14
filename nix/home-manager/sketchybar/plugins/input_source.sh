#!/usr/bin/env bash

set -u

LABEL_ENGLISH="A"
LABEL_JAPANESE="あ"
JAPANESE_KEYWORDS=(
  "inputmethod.japanese"
  "kotoeri"
  "hiragana"
  "katakana"
  "azookey"
  "japanese"
)

resolve_macism_bin() {
  local candidate
  local user_name="${USER:-$(id -un 2>/dev/null || true)}"

  for candidate in \
    "${MACISM_BIN:-}" \
    "$(command -v macism 2>/dev/null || true)" \
    "${user_name:+/etc/profiles/per-user/${user_name}/bin/macism}" \
    "$HOME/.nix-profile/bin/macism" \
    "/run/current-system/sw/bin/macism" \
    "/nix/var/nix/profiles/default/bin/macism"; do
    [[ -n "$candidate" && -x "$candidate" ]] || continue
    printf '%s\n' "$candidate"
    return 0
  done

  return 1
}

is_japanese_context() {
  local value="$1"
  local normalized keyword

  normalized="$(printf '%s' "$value" | tr '[:upper:]' '[:lower:]')"

  for keyword in "${JAPANESE_KEYWORDS[@]}"; do
    [[ "$normalized" == *"$keyword"* ]] && return 0
  done

  return 1
}

item_name="${NAME:-input_source}"
label="$LABEL_ENGLISH"
macism_bin="$(resolve_macism_bin || true)"
source_id=""

if [[ -n "$macism_bin" ]]; then
  source_id="$("$macism_bin" 2>/dev/null || true)"
fi

if is_japanese_context "$source_id"; then
  label="$LABEL_JAPANESE"
fi

sketchybar --set "$item_name" drawing=on label="$label"

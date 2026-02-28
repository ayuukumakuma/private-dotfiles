#!/usr/bin/env bash

set -u

LABEL_ENGLISH="A"
LABEL_JAPANESE="あ"
PLIST_PATH="${PLIST_PATH:-$HOME/Library/Preferences/com.apple.HIToolbox.plist}"

read_plist_key() {
  local key_path="$1"

  /usr/libexec/PlistBuddy -c "Print ${key_path}" "$PLIST_PATH" 2>/dev/null || true
}

read_defaults() {
  local key="$1"

  defaults read com.apple.HIToolbox "$key" 2>/dev/null || true
}

is_japanese_context() {
  local value="$1"
  local normalized

  normalized="$(printf '%s' "$value" | tr '[:upper:]' '[:lower:]')"
  [[ "$normalized" == *"inputmethod.japanese"* || "$normalized" == *"kotoeri"* || "$normalized" == *"hiragana"* || "$normalized" == *"katakana"* || "$normalized" == *"azookey"* || "$normalized" == *"japanese"* ]]
}

has_context_value() {
  local value="$1"

  [[ -n "${value//[[:space:]]/}" ]]
}

collect_primary_context() {
  local selected_kind selected_mode selected_bundle selected_layout
  local current_input_source_id current_layout_source_id

  selected_kind="$(read_plist_key ":AppleSelectedInputSources:0:InputSourceKind")"
  selected_mode="$(read_plist_key ":AppleSelectedInputSources:0:'Input Mode'")"
  selected_bundle="$(read_plist_key ":AppleSelectedInputSources:0:'Bundle ID'")"
  selected_layout="$(read_plist_key ":AppleSelectedInputSources:0:'KeyboardLayout Name'")"

  current_input_source_id="$(read_defaults AppleCurrentInputSourceID)"
  current_layout_source_id="$(read_defaults AppleCurrentKeyboardLayoutInputSourceID)"

  printf '%s %s %s %s %s %s\n' \
    "$selected_kind" \
    "$selected_mode" \
    "$selected_bundle" \
    "$selected_layout" \
    "$current_input_source_id" \
    "$current_layout_source_id"
}

collect_history_context() {
  printf '%s %s %s %s\n' \
    "$(read_plist_key ":AppleInputSourceHistory:0:InputSourceKind")" \
    "$(read_plist_key ":AppleInputSourceHistory:0:'Input Mode'")" \
    "$(read_plist_key ":AppleInputSourceHistory:0:'Bundle ID'")" \
    "$(read_plist_key ":AppleInputSourceHistory:0:'KeyboardLayout Name'")"
}

item_name="${NAME:-input_source}"
context="$(collect_history_context)"
label="$LABEL_ENGLISH"

if ! has_context_value "$context"; then
  context="$(collect_primary_context)"
fi

if is_japanese_context "$context"; then
  label="$LABEL_JAPANESE"
fi

sketchybar --set "$item_name" drawing=on label="$label"

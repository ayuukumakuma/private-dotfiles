#!/usr/bin/env bash

AEROSPACE_BIN="${AEROSPACE_BIN:-/etc/profiles/per-user/$USER/bin/aerospace}"
WORKSPACE="$1"
CURRENT="${FOCUSED_WORKSPACE:-${AEROSPACE_FOCUSED_WORKSPACE:-}}"
ACTIVE_COLOR="0xffeff1f5"
ACTIVE_BACKGROUND="0xff7287fd"
INACTIVE_ICON_COLOR="0xff4c4f69"
APP_ICON_SCALE="0.55"
APP_ITEM_WIDTH="18"
APP_ICON_GAP="4"
WORKSPACE_GROUP_GAP="10"

get_current_workspace() {
  if [ -n "$CURRENT" ]; then
    printf '%s\n' "$CURRENT"
    return
  fi

  "$AEROSPACE_BIN" list-workspaces --focused 2>/dev/null
}

workspace_item_name() {
  printf 'workspace.%s\n' "$WORKSPACE"
}

app_item_name() {
  printf 'workspace.%s.app.%s\n' "$WORKSPACE" "$1"
}

workspace_bracket_name() {
  printf 'workspace.%s.group\n' "$WORKSPACE"
}

workspace_spacer_name() {
  printf 'workspace.%s.spacer\n' "$WORKSPACE"
}

workspace_bracket_exists() {
  [ -n "$(sketchybar --query "$(workspace_bracket_name)" 2>/dev/null)" ]
}

app_item_exists() {
  [ -n "$(sketchybar --query "$1" 2>/dev/null)" ]
}

ensure_workspace_spacer() {
  local item_name=""
  item_name="$(workspace_spacer_name)"

  if ! app_item_exists "$item_name"; then
    sketchybar --add item "$item_name" left
  fi

  sketchybar --set "$item_name" \
    icon.drawing=off \
    label.drawing=off \
    width="$WORKSPACE_GROUP_GAP" \
    padding_left=0 \
    padding_right=0 \
    background.drawing=off
}

workspace_is_active() {
  [ "$WORKSPACE" = "$1" ]
}

workspace_windows() {
  "$AEROSPACE_BIN" list-windows --workspace "$WORKSPACE" 2>/dev/null |
    awk -F'|' '
      {
        window_id = $1
        app_name = $2

        gsub(/^[[:space:]]+|[[:space:]]+$/, "", window_id)
        gsub(/^[[:space:]]+|[[:space:]]+$/, "", app_name)

        if (window_id != "" && app_name != "" && !seen[app_name]++) {
          print window_id "|" app_name
        }
      }
    '
}

set_workspace_item() {
  local active_workspace="$1"
  local icon_color="$INACTIVE_ICON_COLOR"

  if workspace_is_active "$active_workspace"; then
    icon_color="$ACTIVE_COLOR"
  fi

  sketchybar --set "$(workspace_item_name)" \
    icon.color="$icon_color" \
    label="" \
    label.drawing=off \
    background.drawing=off
}

set_workspace_bracket() {
  local active_workspace="$1"
  shift
  local members=("$@")
  local background_drawing="off"

  if workspace_is_active "$active_workspace"; then
    background_drawing="on"
  fi

  if workspace_bracket_exists; then
    sketchybar --remove "$(workspace_bracket_name)"
  fi

  sketchybar --add bracket "$(workspace_bracket_name)" "${members[@]}"
  sketchybar --set "$(workspace_bracket_name)" \
    background.drawing="$background_drawing" \
    background.color="$ACTIVE_BACKGROUND" \
    background.height=24 \
    background.corner_radius=6
}

ensure_app_item() {
  local index="$1"
  local window_id="$2"
  local app_name="$3"
  local item_name=""
  local anchor_item=""

  item_name="$(app_item_name "$index")"
  if [ "$index" -eq 1 ]; then
    anchor_item="$(workspace_item_name)"
  else
    anchor_item="$(app_item_name "$((index - 1))")"
  fi

  if ! app_item_exists "$item_name"; then
    sketchybar --add item "$item_name" left
  fi

  sketchybar --set "$item_name" \
    icon.drawing=off \
    label.drawing=off \
    padding_left=0 \
    padding_right="$APP_ICON_GAP" \
    width="$APP_ITEM_WIDTH" \
    background.drawing=on \
    background.color=0x00000000 \
    background.border_width=0 \
    background.image="app.$app_name" \
    background.image.drawing=on \
    background.image.scale="$APP_ICON_SCALE" \
    background.image.padding_left=1 \
    background.image.padding_right=1 \
    click_script="$AEROSPACE_BIN workspace $WORKSPACE && $AEROSPACE_BIN focus --window-id $window_id"

  sketchybar --move "$item_name" after "$anchor_item"
}

set_workspace_spacing() {
  local app_count="$1"
  local workspace_item=""
  local last_app_item=""
  local spacer_item=""

  workspace_item="$(workspace_item_name)"
  spacer_item="$(workspace_spacer_name)"

  sketchybar --set "$workspace_item" padding_right="$APP_ICON_GAP"

  if [ "$app_count" -gt 0 ]; then
    last_app_item="$(app_item_name "$app_count")"
    sketchybar --set "$last_app_item" padding_right="$APP_ICON_GAP"
    sketchybar --move "$spacer_item" after "$last_app_item"
    return
  fi

  sketchybar --move "$spacer_item" after "$workspace_item"
}

remove_stale_app_items() {
  local index="$1"
  local item_name=""

  while true; do
    item_name="$(app_item_name "$index")"
    if ! app_item_exists "$item_name"; then
      break
    fi

    sketchybar --remove "$item_name"
    index=$((index + 1))
  done
}

sync_workspace_icons() {
  local active_workspace="$1"
  local index=1
  local window_id=""
  local app_name=""
  local members=()

  members+=("$(workspace_item_name)")
  ensure_workspace_spacer

  while IFS='|' read -r window_id app_name; do
    [ -n "$window_id" ] || continue
    [ -n "$app_name" ] || continue

    ensure_app_item "$index" "$window_id" "$app_name"
    members+=("$(app_item_name "$index")")
    index=$((index + 1))
  done <<EOF
$(workspace_windows)
EOF

  remove_stale_app_items "$index"
  set_workspace_spacing "$((index - 1))"
  set_workspace_bracket "$active_workspace" "${members[@]}"
}

active_workspace="$(get_current_workspace)"
set_workspace_item "$active_workspace"
sync_workspace_icons "$active_workspace"

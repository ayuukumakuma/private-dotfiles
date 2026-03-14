#!/usr/bin/env bash

set -u

ICON_CHARGING=""
ICON_EMPTY=""
ICON_LOW=""
ICON_MID=""
ICON_HIGH=""
ICON_FULL=""

hide_and_exit() {
  sketchybar --set "$NAME" drawing=off
  exit 0
}

icon_for_level() {
  local level="$1"

  if (( level <= 10 )); then
    printf '%s' "$ICON_EMPTY"
  elif (( level <= 35 )); then
    printf '%s' "$ICON_LOW"
  elif (( level <= 60 )); then
    printf '%s' "$ICON_MID"
  elif (( level <= 85 )); then
    printf '%s' "$ICON_HIGH"
  else
    printf '%s' "$ICON_FULL"
  fi
}

if ! command -v pmset >/dev/null 2>&1; then
  hide_and_exit
fi

line="$(pmset -g batt 2>/dev/null | awk 'NR == 2 { print; exit }')"
if [[ -z "$line" || "$line" == *"No batteries"* ]]; then
  hide_and_exit
fi

percent="$(printf '%s' "$line" | sed -nE 's/.*[^0-9]([0-9]{1,3})%.*/\1/p')"
status="$(printf '%s' "$line" | awk -F';' '{ gsub(/^ +| +$/, "", $2); print $2 }')"

if [[ -z "$percent" ]]; then
  hide_and_exit
fi

case "$status" in
  charging|"finishing charge")
    icon="$ICON_CHARGING"
    ;;
  charged)
    icon="$ICON_FULL"
    ;;
  *)
    icon="$(icon_for_level "$percent")"
    ;;
esac

sketchybar --set "$NAME" drawing=on icon="$icon" label="${percent}%"

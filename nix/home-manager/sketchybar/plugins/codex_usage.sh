#!/usr/bin/env bash

set -u

ITEM_NAME="${NAME:-codex_usage}"
POPUP_ITEM_FIVE_HOURS="codex_usage_5h"
POPUP_ITEM_WEEKLY="codex_usage_weekly"
POPUP_ITEM_UPDATED="codex_usage_updated"
LOCK_DIR="${TMPDIR:-/tmp}/sketchybar-codex-usage.lock"
FIVE_HOUR_RESET_PLACEHOLDER="--:--"
WEEKLY_RESET_PLACEHOLDER="--/-- --:--"

current_time() {
  date '+%H:%M'
}

set_popup_visible() {
  local drawing="$1"
  sketchybar --set "$ITEM_NAME" popup.drawing="$drawing"
}

popup_drawing_state() {
  sketchybar --query "$ITEM_NAME" | python3 -c 'import json, sys; print((json.load(sys.stdin).get("popup") or {}).get("drawing", "off"))' 2>/dev/null || printf 'off'
}

format_limit_label() {
  local name="$1"
  local remaining_percent="$2"
  local resets_at="$3"

  printf '%s: %s — resets at %s' "$name" "$remaining_percent" "$resets_at"
}

set_usage_values() {
  local five_hour="$1"
  local five_hour_reset="$2"
  local weekly="$3"
  local weekly_reset="$4"
  local updated="$5"

  sketchybar --set "$POPUP_ITEM_FIVE_HOURS" label="$(format_limit_label "5h" "$five_hour" "$five_hour_reset")" \
    --set "$POPUP_ITEM_WEEKLY" label="$(format_limit_label "Weekly" "$weekly" "$weekly_reset")" \
    --set "$POPUP_ITEM_UPDATED" label="Updated At: ${updated}"
}

set_unavailable_values() {
  local updated="$1"

  sketchybar --set "$POPUP_ITEM_FIVE_HOURS" label="$(format_limit_label "5h" "--" "$FIVE_HOUR_RESET_PLACEHOLDER")" \
    --set "$POPUP_ITEM_WEEKLY" label="$(format_limit_label "Weekly" "--" "$WEEKLY_RESET_PLACEHOLDER")" \
    --set "$POPUP_ITEM_UPDATED" label="Updated At: Failed (${updated})"
}

acquire_lock() {
  mkdir "$LOCK_DIR" 2>/dev/null
}

release_lock() {
  rmdir "$LOCK_DIR" 2>/dev/null || true
}

fetch_usage_values() {
  python3 - <<'PY'
import json
import sys
from collections import deque
from datetime import datetime
from pathlib import Path

FIVE_HOUR_RESET_PLACEHOLDER = "--:--"
WEEKLY_RESET_PLACEHOLDER = "--/-- --:--"


def remaining_percent(value):
    try:
        percent = int(float(value))
    except (TypeError, ValueError):
        return None
    return max(0, 100 - percent)


def format_reset_time(timestamp, include_date=False):
    if not timestamp:
        return WEEKLY_RESET_PLACEHOLDER if include_date else FIVE_HOUR_RESET_PLACEHOLDER
    reset_time = datetime.fromtimestamp(timestamp).astimezone()
    if include_date:
        return f"{reset_time.month}/{reset_time.day} {reset_time:%H:%M}"
    return reset_time.strftime("%H:%M")


def iter_recent_lines(path: Path, max_lines: int = 400):
    with path.open("r", encoding="utf-8", errors="ignore") as handle:
        yield from reversed(deque(handle, maxlen=max_lines))


sessions_dir = Path.home() / ".codex" / "sessions"
session_files = sorted(
    sessions_dir.rglob("rollout-*.jsonl"),
    key=lambda path: path.stat().st_mtime,
    reverse=True,
)

for session_file in session_files:
    for line in iter_recent_lines(session_file):
        try:
            payload = json.loads(line)
        except json.JSONDecodeError:
            continue

        if payload.get("type") != "event_msg":
            continue

        token_count = payload.get("payload", {})
        if token_count.get("type") != "token_count":
            continue

        rate_limits = token_count.get("rate_limits") or {}
        primary = rate_limits.get("primary") or {}
        secondary = rate_limits.get("secondary") or {}
        primary_percent = remaining_percent(primary.get("used_percent"))
        secondary_percent = remaining_percent(secondary.get("used_percent"))
        if primary_percent is None or secondary_percent is None:
            continue

        primary_reset = format_reset_time(primary.get("resets_at"))
        secondary_reset = format_reset_time(secondary.get("resets_at"), include_date=True)
        print(f"{int(primary_percent)}%|{primary_reset}|{int(secondary_percent)}%|{secondary_reset}")
        sys.exit(0)

sys.exit(1)
PY
}

toggle_popup() {
  local popup_state

  popup_state="$(popup_drawing_state)"
  if [[ "$popup_state" == "on" ]]; then
    set_popup_visible off
  else
    set_popup_visible on
  fi
}

handle_mouse_click() {
  [[ "${BUTTON:-}" == "left" ]] || return
  toggle_popup
}

if [[ "${1:-}" == "--toggle-popup" ]]; then
  toggle_popup
  exit 0
fi

case "${SENDER:-}" in
  mouse.clicked)
    handle_mouse_click
    exit 0
    ;;
  mouse.exited.global)
    set_popup_visible off
    exit 0
    ;;
esac

if ! command -v codex >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
  set_unavailable_values "$(current_time)"
  exit 0
fi

if ! acquire_lock; then
  exit 0
fi

trap release_lock EXIT

if usage_values="$(fetch_usage_values 2>/dev/null)"; then
  IFS='|' read -r five_hour five_hour_reset weekly weekly_reset <<< "$usage_values"
  set_usage_values "$five_hour" "$five_hour_reset" "$weekly" "$weekly_reset" "$(current_time)"
else
  set_unavailable_values "$(current_time)"
fi

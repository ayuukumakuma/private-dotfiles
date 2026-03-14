#!/usr/bin/env bash

set -u

ITEM_NAME="${NAME:-clock}"
CALENDAR_TITLE_ITEM="clock_calendar_title"
CALENDAR_DAYS_ITEM="clock_calendar_days"
CALENDAR_WEEK_ITEMS=(
  "clock_calendar_week1"
  "clock_calendar_week2"
  "clock_calendar_week3"
  "clock_calendar_week4"
  "clock_calendar_week5"
  "clock_calendar_week6"
)
CALENDAR_NORMAL_COLOR="0xff5c5f77"
CALENDAR_HIGHLIGHT_COLOR="0xffeff1f5"
CALENDAR_HIGHLIGHT_BACKGROUND="0xffdf8e1d"

set_clock_label() {
  sketchybar --set "$ITEM_NAME" label="$(date '+%H:%M')"
}

set_popup_visible() {
  local drawing="$1"
  sketchybar --set "$ITEM_NAME" popup.drawing="$drawing"
}

popup_drawing_state() {
  sketchybar --query "$ITEM_NAME" | python3 -c 'import json, sys; print((json.load(sys.stdin).get("popup") or {}).get("drawing", "off"))' 2>/dev/null || printf 'off'
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

calendar_payload() {
  python3 - <<'PY'
import calendar
from datetime import date

today = date.today()
month_title = today.strftime("%B %Y")
weekday_header = "".join(f"{name:^4}" for name in ("Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"))

weeks = calendar.Calendar(firstweekday=6).monthdayscalendar(today.year, today.month)
while len(weeks) < 6:
    weeks.append([0] * 7)

highlighted_week = 0
print(month_title)
print(weekday_header)

for index, week in enumerate(weeks, start=1):
    cells = []
    for day in week:
        if day == 0:
            cells.append("    ")
            continue

        if day == today.day:
            cells.append(f"[{day:>2}]")
            highlighted_week = index
        else:
            cells.append(f"{day:>2}  ")

    print("".join(cells))

print(f"HIGHLIGHT_WEEK={highlighted_week}")
PY
}

update_calendar_popup() {
  local calendar_lines=()
  local highlight_week line index item_name

  if ! command -v python3 >/dev/null 2>&1; then
    return
  fi

  while IFS= read -r line; do
    calendar_lines+=("$line")
  done < <(calendar_payload)

  if [[ "${#calendar_lines[@]}" -lt 9 ]]; then
    return
  fi

  highlight_week="${calendar_lines[8]#HIGHLIGHT_WEEK=}"

  sketchybar --set "$CALENDAR_TITLE_ITEM" label="${calendar_lines[0]}" \
    --set "$CALENDAR_DAYS_ITEM" label="${calendar_lines[1]}"

  for index in "${!CALENDAR_WEEK_ITEMS[@]}"; do
    item_name="${CALENDAR_WEEK_ITEMS[$index]}"
    line="${calendar_lines[$((index + 2))]}"
    sketchybar --set "$item_name" label="$line"

    if [[ "$((index + 1))" -eq "$highlight_week" ]]; then
      sketchybar --set "$item_name" \
        label.highlight=on \
        label.highlight_color="$CALENDAR_HIGHLIGHT_COLOR" \
        background.drawing=on \
        background.color="$CALENDAR_HIGHLIGHT_BACKGROUND"
    else
      sketchybar --set "$item_name" \
        label.highlight=off \
        label.color="$CALENDAR_NORMAL_COLOR" \
        background.drawing=off
    fi
  done
}

handle_mouse_click() {
  [[ "${BUTTON:-}" == "left" ]] || return

  toggle_popup
  update_calendar_popup
}

refresh_clock() {
  set_clock_label
  update_calendar_popup
}

case "${SENDER:-routine}" in
  mouse.clicked)
    handle_mouse_click
    exit 0
    ;;
  mouse.exited.global)
    set_popup_visible off
    exit 0
    ;;
esac

refresh_clock

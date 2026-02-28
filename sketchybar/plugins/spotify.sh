#!/usr/bin/env bash

set -u

if [[ "${1:-}" == "--toggle" ]]; then
  osascript -e 'tell application "Spotify" to playpause' >/dev/null 2>&1 || true
  sketchybar --trigger spotify_change
  exit 0
fi

hide_item() {
  sketchybar --set "$NAME" drawing=off
}

hide_and_exit() {
  hide_item
  exit 0
}

if ! command -v osascript >/dev/null 2>&1; then
  hide_and_exit
fi

result="$(osascript <<'APPLESCRIPT' 2>/dev/null
if application "Spotify" is running then
  tell application "Spotify"
    set stateEnum to player state
    if stateEnum is playing then
      set stateText to "playing"
    else if stateEnum is paused then
      set stateText to "paused"
    else
      set stateText to "stopped"
    end if

    if stateText is "stopped" then
      return "stopped|||"
    end if
    return stateText & "|" & artist of current track & "|" & name of current track
  end tell
else
  return "not_running|||"
end if
APPLESCRIPT
)"

if [[ -z "$result" ]]; then
  hide_and_exit
fi

IFS='|' read -r state artist track <<< "$result"
case "$state" in
  playing)
    status_icon=""
    scroll_texts="on"
    ;;
  paused)
    status_icon=""
    scroll_texts="off"
    ;;
  stopped)
    status_icon=""
    scroll_texts="off"
    ;;
  *)
    hide_and_exit
    ;;
esac

track="${track//$'\n'/ }"
artist="${artist//$'\n'/ }"

if [[ -n "$track" && -n "$artist" ]]; then
  label="$track - $artist"
elif [[ -n "$track" ]]; then
  label="$track"
else
  label=""
fi

sketchybar --set "$NAME" drawing=on icon="$status_icon" label="$label" scroll_texts="$scroll_texts"

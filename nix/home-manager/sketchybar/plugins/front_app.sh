#!/usr/bin/env bash

_app_icon() {
  case "$1" in
    "Ghostty"|"Terminal"|"iTerm2"|"Alacritty"|"kitty"|"WezTerm") echo ":terminal:" ;;
    "Cursor"|"Code"|"VSCodium")                                    echo ":vscode:" ;;
    "Neovide"|"MacVim")                                            echo ":vim:" ;;
    "Firefox"|"Firefox Developer Edition")                         echo ":firefox:" ;;
    "Google Chrome"|"Chromium")                                    echo ":google_chrome:" ;;
    "Safari")                                                      echo ":safari:" ;;
    "Arc")                                                         echo ":arc:" ;;
    "Slack")                                                       echo ":slack:" ;;
    "Discord")                                                     echo ":discord:" ;;
    "Finder")                                                      echo ":finder:" ;;
    "1Password")                                                   echo ":1password:" ;;
    "Spotify")                                                     echo ":spotify:" ;;
    "Figma")                                                       echo ":figma:" ;;
    "Linear")                                                      echo ":linear:" ;;
    "Mail")                                                        echo ":mail:" ;;
    "Calendar")                                                    echo ":calendar:" ;;
    "Notes")                                                       echo ":notes:" ;;
    *)                                                             echo "" ;;
  esac
}

_front_window_info() {
  osascript <<'APPLESCRIPT' 2>/dev/null
tell application "System Events"
  set frontAppName to name of first application process whose frontmost is true
  tell process frontAppName
    set windowTitle to ""
    try
      if (count of windows) > 0 then
        set windowTitle to name of front window
      end if
    end try
  end tell
end tell

return frontAppName & linefeed & windowTitle
APPLESCRIPT
}

window_info="$(_front_window_info)"
IFS=$'\n' read -r app_name window_title <<EOF
$window_info
EOF
app_name="${INFO:-$app_name}"
app_name="${app_name:-No App}"
window_title="${window_title//$'\n'/ }"
window_title="${window_title//$'\r'/ }"

if [ -n "$window_title" ] && [ "$window_title" != "$app_name" ]; then
  label="$app_name: $window_title"
else
  label="$app_name"
fi

icon=$(_app_icon "$app_name")

sketchybar --set "$NAME" drawing=on label="$label" icon="$icon"

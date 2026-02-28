#!/usr/bin/env bash

set -u

WORKSPACE_ICON=""
WINDOWS_ICON=""

hide_item() {
  sketchybar --set "$NAME" drawing=off
}

hide_and_exit() {
  hide_item
  exit 0
}

if ! command -v rift-cli >/dev/null 2>&1 || ! command -v jq >/dev/null 2>&1; then
  hide_and_exit
fi

workspace_json="$(rift-cli query workspaces 2>/dev/null || true)"
if [[ -z "$workspace_json" ]]; then
  hide_and_exit
fi

summary="$(
  printf '%s' "$workspace_json" |
    jq -r '
      def to_array:
        if type == "array" then
          .
        elif type == "object" then
          if has("workspaces") and (.workspaces | type) == "array" then
            .workspaces
          elif has("data") and (.data | type) == "array" then
            .data
          else
            [.]
          end
        else
          []
        end;

      def ws_name($ws):
        ($ws.workspace_name // $ws.name // $ws.label // null)
        // ((($ws.workspace_index // $ws.index // 0) + 1) | tostring | "WS" + .);

      def ws_index($ws):
        ($ws.workspace_index // $ws.index // 0) + 1;

      def ws_count($ws):
        $ws.window_count
        // ($ws.windows | if type == "array" then length else null end)
        // ($ws.tiled_windows | if type == "array" then length else null end)
        // 0;

      (to_array) as $all
      | ($all | map(select((.is_active // .active // .is_active_space // false) == true)) | .[0]) as $active
      | ($active // ($all | .[0])) as $target
      | if $target == null then
          ""
        else
          "\(ws_name($target))|\(ws_index($target))|\(ws_count($target))"
        end
    ' 2>/dev/null
)"

if [[ -z "$summary" ]]; then
  hide_and_exit
fi

IFS='|' read -r ws_name ws_index window_count <<< "$summary"
ws_name="${ws_name//$'\n'/ }"
label="${ws_name}  ${WORKSPACE_ICON} ${ws_index}  ${WINDOWS_ICON} ${window_count}"

sketchybar --set "$NAME" drawing=on label="$label"

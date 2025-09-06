#!/usr/bin/env bash

FOCUSED_SPACE=$(yabai -m query --spaces --space | jq -r '.index')
FOCUSED_APP=$(yabai -m query --windows --window | jq -r '.app // empty')

case "$SENDER" in
"yabai_space_change")
  sketchybar --set spaces label="$FOCUSED_SPACE"
  ;;
"yabai_window_change")
  sketchybar --set front_app label="$FOCUSED_APP"
  ;;
esac

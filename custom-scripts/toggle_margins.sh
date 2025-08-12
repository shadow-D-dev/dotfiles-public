#!/bin/bash

SKETCHYBAR_CONFIG="$HOME/.config/sketchybar/sketchybarrc"
AEROSPACE_CONFIG="$HOME/.config/aerospace/aerospace.toml"

# Read current margin
current=$(grep -E "^[[:space:]]*margin=" "$SKETCHYBAR_CONFIG" | awk -F= '{print $2}')

if [ "$current" -eq 695 ]; then
  new_margin=10
  new_outer=15
else
  new_margin=695
  new_outer=700
fi

# Update sketchybarrc margin
sed -i '' "s/^[[:space:]]*margin=.*/  margin=$new_margin/" "$SKETCHYBAR_CONFIG"

# Update aerospace.toml outer.left and outer.right
sed -i '' "s/^\([[:space:]]*outer\.left[[:space:]]*=\).*/\1 $new_outer/" "$AEROSPACE_CONFIG"
sed -i '' "s/^\([[:space:]]*outer\.right[[:space:]]*=\).*/\1 $new_outer/" "$AEROSPACE_CONFIG"

# Reload both configurations
sketchybar --config "$SKETCHYBAR_CONFIG"

osascript <<EOF
tell application "System Events"
    key down {option, shift}
    keystroke ";"
    key up {option, shift}
    delay 0.1
    key code 53 -- ESC key
end tell
EOF

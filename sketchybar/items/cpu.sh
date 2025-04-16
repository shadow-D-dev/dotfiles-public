#!/bin/bash

cpu_top=(
  label.font="$FONT:Semibold:14"
  label="CPU Usage"
  icon.drawing=off
  width=200
  padding_right=20
  y_offset=0
  x_offset=10
)

cpu_percent=(
  label.font="$FONT:Heavy:12"
  label="45%" # Example value
  y_offset=0
  padding_right=10
  width=50
  icon.drawing=off
  update_freq=4
  mach_helper="$HELPER"
)

cpu_sys=(
  width=50
  graph.color=$RED
  graph.fill_color=$RED
  label.drawing=off
  icon.drawing=off
  background.height=20
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  width=50
  graph.color=$BLUE
  padding_right=10
  label.drawing=off
  icon.drawing=off
  background.height=20
  background.drawing=on
  background.color=$TRANSPARENT
)

# Add CPU elements in order to position them horizontally
sketchybar --add item cpu.percent right \
  --set cpu.percent "${cpu_percent[@]}" \
  \
  --add graph cpu.sys right 50 \
  --set cpu.sys "${cpu_sys[@]}" \
  \
  --add graph cpu.user right 50 \
  --set cpu.user "${cpu_user[@]}" \
  --add item cpu.top right \
  --set cpu.top "${cpu_top[@]}"

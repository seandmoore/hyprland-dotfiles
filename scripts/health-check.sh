#!/usr/bin/env bash
set -u
commands=(Hyprland hyprctl quickshell ghostty walker hyprlock hypridle hyprpaper wpctl playerctl)
failed=0
for cmd in "${commands[@]}"; do
  if command -v "$cmd" >/dev/null; then printf 'ok      %s\n' "$cmd"; else printf 'missing %s\n' "$cmd"; failed=1; fi
done
exit "$failed"

#!/usr/bin/env bash
set -Eeuo pipefail
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
for name in hypr quickshell ghostty fish; do
  target="$CONFIG_HOME/$name"
  [[ -L "$target" ]] && rm "$target"
done
printf 'Removed repository-managed symlinks. Packages and backups were preserved.\n'

#!/usr/bin/env bash
set -Eeuo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

for name in hypr quickshell ghostty; do
  target="$CONFIG_HOME/$name"
  if [[ -L "$target" ]]; then
    rm "$target"
  fi
done

if [[ -L "$HOME/.zshrc" ]]; then
  rm "$HOME/.zshrc"
fi

printf 'Removed repository-managed symlinks. Packages and backups were preserved.\n'

#!/usr/bin/env bash
set -Eeuo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

for name in hypr quickshell ghostty; do
  target="$CONFIG_HOME/$name"
  if [[ -L "$target" ]]; then
    rm "$target"
  fi
done

if [[ -L "$HOME/.zshrc" ]]; then
  rm "$HOME/.zshrc"
fi

if [[ -L "$BIN_HOME/hypr-gaming-mode" ]]; then
  rm "$BIN_HOME/hypr-gaming-mode"
fi

printf 'Removed repository-managed symlinks. Packages and backups were preserved.\n'

#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"

warn() { printf 'warning: %s\n' "$*" >&2; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }

[[ $EUID -ne 0 ]] || die "Run as your normal user, not root."
[[ "$HOME" == /* ]] || die "HOME must be an absolute path."
[[ "$CONFIG_HOME" == /* ]] || die "XDG_CONFIG_HOME must be an absolute path."
[[ "$BIN_HOME" == /* ]] || die "XDG_BIN_HOME must be an absolute path."

remove_managed_link() {
  local target="$1"
  local expected="$2"

  [[ -L "$target" ]] || return 0

  local actual_path expected_path
  actual_path="$(readlink -f -- "$target" || true)"
  expected_path="$(readlink -f -- "$expected" || true)"
  if [[ -n "$actual_path" && "$actual_path" == "$expected_path" ]]; then
    rm -- "$target"
  else
    warn "Preserved symlink not managed by this repository: $target"
  fi
}

for name in hypr quickshell ghostty; do
  remove_managed_link "$CONFIG_HOME/$name" "$ROOT/config/$name"
done

remove_managed_link "$HOME/.zshrc" "$ROOT/config/zsh/.zshrc"
remove_managed_link "$BIN_HOME/hypr-gaming-mode" "$ROOT/scripts/gaming-mode.sh"

printf 'Removed repository-managed symlinks. Packages and backups were preserved.\n'

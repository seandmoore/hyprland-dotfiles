#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
BACKUP="$STATE_HOME/hyprland-dotfiles/backups/$(date +%Y%m%d-%H%M%S)"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarning:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

[[ $EUID -ne 0 ]] || die "Run as your normal user, not root."
command -v pacman >/dev/null || die "This installer currently supports Arch-based systems."

install_list() {
  local file="$1"
  shift
  [[ -f "$file" ]] || return 0

  local -a packages=()
  mapfile -t packages < <(grep -Ev '^[[:space:]]*(#|$)' "$file")
  ((${#packages[@]})) || return 0

  "$@" -S --needed --noconfirm "${packages[@]}"
}

link_config() {
  local name="$1" src="$ROOT/config/$name" dst="$CONFIG_HOME/$name"
  [[ -e "$src" ]] || return 0
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
  fi
  ln -s "$src" "$dst"
  log "Linked $dst"
}

link_file() {
  local src="$1" dst="$2"
  [[ -e "$src" ]] || return 0
  if [[ -e "$dst" || -L "$dst" ]]; then
    mkdir -p "$BACKUP"
    mv "$dst" "$BACKUP/"
  fi
  ln -s "$src" "$dst"
  log "Linked $dst"
}

install_list "$ROOT/packages/arch.txt" sudo pacman
if command -v paru >/dev/null; then
  install_list "$ROOT/packages/aur.txt" paru
elif command -v yay >/dev/null; then
  install_list "$ROOT/packages/aur.txt" yay
else
  warn "No AUR helper found; skipped packages/aur.txt"
fi

mkdir -p "$CONFIG_HOME"
for name in hypr quickshell ghostty; do
  link_config "$name"
done
link_file "$ROOT/config/zsh/.zshrc" "$HOME/.zshrc"

log "Installed dotfiles. Existing configs, if any, were backed up to $BACKUP"
log "Zsh is installed and configured, but the installer does not change your login shell."
log "Run 'chsh -s /usr/bin/zsh' yourself if you want Zsh as the default shell."
log "Log out and start Hyprland after reviewing monitor and autostart settings."

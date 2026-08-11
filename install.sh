#!/usr/bin/env bash
set -Eeuo pipefail

readonly REPOSITORY_URL="https://github.com/seandmoore/hyprland-dotfiles.git"
readonly BRANCH="main"
readonly DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
readonly INSTALL_DIR="${HYPRLAND_DOTFILES_DIR:-$DATA_HOME/hyprland-dotfiles}"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
die() { printf '\033[1;31merror:\033[0m %s\n' "$*" >&2; exit 1; }

[[ $EUID -ne 0 ]] || die "Run as your normal user, not root."
[[ "$HOME" == /* ]] || die "HOME must be an absolute path."
[[ "$DATA_HOME" == /* ]] || die "XDG_DATA_HOME must be an absolute path."
[[ "$INSTALL_DIR" == /* ]] || die "HYPRLAND_DOTFILES_DIR must be an absolute path."
command -v pacman >/dev/null || die "This installer supports Arch-based systems."

if ! command -v git >/dev/null; then
  log "Installing Git"
  sudo pacman -S --needed --noconfirm -- git
fi

if [[ -d "$INSTALL_DIR/.git" ]]; then
  origin_url="$(git -C "$INSTALL_DIR" remote get-url origin 2>/dev/null || true)"
  case "$origin_url" in
    "$REPOSITORY_URL"|"https://github.com/seandmoore/hyprland-dotfiles"|"git@github.com:seandmoore/hyprland-dotfiles.git") ;;
    *) die "$INSTALL_DIR is a Git repository with an unexpected origin: ${origin_url:-none}" ;;
  esac

  [[ -z "$(git -C "$INSTALL_DIR" status --porcelain)" ]] || \
    die "$INSTALL_DIR has local changes. Commit, stash, or remove them before updating."

  log "Updating dotfiles in $INSTALL_DIR"
  git -C "$INSTALL_DIR" fetch --quiet origin "$BRANCH"
  git -C "$INSTALL_DIR" checkout --quiet "$BRANCH"
  git -C "$INSTALL_DIR" merge --ff-only --quiet FETCH_HEAD
elif [[ -e "$INSTALL_DIR" ]]; then
  die "$INSTALL_DIR already exists and is not this dotfiles repository."
else
  mkdir -p "$(dirname -- "$INSTALL_DIR")"
  log "Downloading dotfiles to $INSTALL_DIR"
  git clone --depth 1 --branch "$BRANCH" -- "$REPOSITORY_URL" "$INSTALL_DIR"
fi

[[ -f "$INSTALL_DIR/scripts/install.sh" ]] || die "Downloaded repository is missing scripts/install.sh."
exec bash "$INSTALL_DIR/scripts/install.sh"

# Interactive Zsh configuration for the Hyprland desktop.

export EDITOR="zed"
export VISUAL="zed"

# Keep user-installed tools available without assuming a specific package manager.
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  $path
)
export PATH

# Sensible history behavior.
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
mkdir -p "${HISTFILE:h}"
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Completion.
autoload -Uz compinit
compinit

# Convenient defaults.
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
bindkey -e

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

if command -v fastfetch >/dev/null 2>&1 && [[ -o interactive ]]; then
  fastfetch
fi
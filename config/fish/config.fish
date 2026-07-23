if status is-interactive
    set -gx EDITOR zed
    set -gx VISUAL zed
    command -q starship; and starship init fish | source
end

# Hyprland Dotfiles

A clean starting point for a modern Hyprland desktop using the current Lua configuration format, Quickshell, Ghostty, Walker, and Catppuccin Mocha.

## Status

This repository is an early scaffold. Review monitor, launcher, wallpaper, and autostart settings before using it as your daily desktop.

## Structure

```text
config/hypr/                    Hyprland, Hyprlock, Hypridle, Hyprpaper
config/hypr/modules/            Modular Lua configuration
config/quickshell/sean-shell/   Quickshell shell and future widgets
config/ghostty/                 Ghostty terminal configuration
config/fish/                    Fish shell configuration
packages/                       Arch repository and optional AUR lists
scripts/                        Installer, uninstaller, and health check
wallpapers/                     User-provided wallpapers
screenshots/                    Repository screenshots
```

## Install

```bash
git clone https://github.com/seandmoore/hyprland-dotfiles.git
cd hyprland-dotfiles
chmod +x scripts/*.sh
./scripts/install.sh
```

The installer targets Arch-based systems, installs required packages, backs up existing managed configuration directories, and creates symlinks from `~/.config` into the repository.

## Validate

```bash
./scripts/health-check.sh
hyprctl reload
```

## Important customization

1. Run `hyprctl monitors` and replace the generic monitor rule.
2. Add a wallpaper to `wallpapers/` and update `config/hypr/hyprpaper.conf`.
3. Review `config/hypr/modules/autostart.lua`.
4. Expand the Quickshell shell one component at a time.

## Safety

The installer does not change your login shell, configure a display manager, or delete backups. Do not run it as root.

## Acknowledgments

Created and maintained by Sean Moore, with development and documentation assistance from OpenAI Codex (ChatGPT).

Codex-assisted commits use GitHub's linked Codex co-author identity so the contribution history remains transparent.

## License

GPL-3.0-only. See [LICENSE](LICENSE).

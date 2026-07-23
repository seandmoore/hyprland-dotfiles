# Hyprland Dotfiles

A clean starting point for a modern Hyprland desktop using the current Lua configuration format, Quickshell, Ghostty, Zsh, and Catppuccin Mocha.

> [!WARNING]
> This is an AI-assisted ("vibe coded") personal dotfiles project. Review the scripts and configuration before using them. Use at your own risk.

## Status

This repository is an early scaffold. Review monitor, launcher, wallpaper, and autostart settings before using it as your daily desktop.

## Structure

```text
config/hypr/                    Hyprland, Hyprlock, Hypridle, Hyprpaper
config/hypr/modules/            Modular Lua configuration
config/quickshell/sean-shell/   Quickshell shell, launcher, and future widgets
config/ghostty/                 Ghostty terminal configuration
config/zsh/                     Zsh interactive shell configuration
packages/                       Arch repository and optional AUR lists
scripts/                        Bash installer, uninstaller, and health check
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

The installer targets Arch-based systems, installs required packages, backs up existing managed configuration directories, and creates symlinks from the repository into your home directory.

Quickshell is the intended interface for the launcher, panels, overlays, and related desktop widgets, so no separate application launcher is installed.

Zsh is installed and configured as the preferred interactive shell. The installer deliberately does not change your login shell automatically. To make Zsh your default after installation, run:

```bash
chsh -s /usr/bin/zsh
```

Log out and back in for the login-shell change to take effect.

Project automation remains written in Bash for portability and compatibility with Codex, CI environments, and other Arch-based systems.

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

This repository is developed with significant assistance from OpenAI Codex/ChatGPT using an AI-assisted ("vibe coding") workflow. It may contain mistakes, incomplete configuration, or assumptions that do not fit every system.

Review every script and configuration file before running the installer, especially on a production machine. You are responsible for any changes made to your system.

The installer does not change your login shell, configure a display manager, or delete backups. Do not run it as root.

## Acknowledgments

Created and maintained by Sean Moore, with development and documentation assistance from OpenAI Codex (ChatGPT).

Codex-assisted commits use GitHub's linked Codex co-author identity so the contribution history remains transparent.

## License

GPL-3.0-only. See [LICENSE](LICENSE).

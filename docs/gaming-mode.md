# Steam Gaming Mode

This repository supports two ways to open Steam's controller-first interface from Hyprland.

## Nested mode

Nested mode keeps Hyprland running and opens Steam Gamepad UI inside a fullscreen Gamescope window:

```bash
./scripts/gaming-mode.sh nested
```

This is the safest portable option and is useful while developing or testing the setup.

## Dedicated session mode

A dedicated Gamescope session is closer to SteamOS because Hyprland is not running underneath it. This requires a separately installed and configured `gamescope-session-steam` session plus a compatible session switcher or display manager.

On systems that provide `steamos-session-select`, run:

```bash
./scripts/gaming-mode.sh session
```

The script deliberately refuses to terminate Hyprland or the user session itself when no supported switcher is available. Session management differs between distributions and an unsafe fallback could leave the user at a black screen.

## Automatic mode

```bash
./scripts/gaming-mode.sh auto
```

Automatic mode uses a dedicated session when `steamos-session-select` is available; otherwise it falls back to nested Gamescope.

## Display selection

For a dedicated Gamescope session, the output can usually be selected through an environment file:

```ini
# ~/.config/environment.d/10-gamescope-session.conf
OUTPUT_CONNECTOR=DP-1
XKB_DEFAULT_LAYOUT=us
```

Find connected DRM outputs with:

```bash
grep -r '^connected' /sys/class/drm/*/status | grep -Po 'card.?-\K([^/]*)'
```

## Recommended desktop stack

The desktop side remains GTK-focused:

- Nautilus for files
- Mission Center for system monitoring
- Loupe for images
- Papers for PDFs
- GNOME Text Editor for quick text editing
- Ghostty for the terminal
- Quickshell for panels, launchers, and the Gaming Mode button

The Steam interface remains Valve's UI; these dotfiles only provide the launch and session-integration layer.

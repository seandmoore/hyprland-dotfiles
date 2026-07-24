#!/usr/bin/env bash
set -Eeuo pipefail

mode="${1:-auto}"
notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "Hyprland Gaming Mode" "$1"
    else
        printf '%s\n' "$1"
    fi
}

launch_nested() {
    command -v gamescope >/dev/null 2>&1 || {
        notify "gamescope is not installed."
        exit 1
    }
    command -v steam >/dev/null 2>&1 || {
        notify "Steam is not installed."
        exit 1
    }

    exec gamescope -e -f -- steam -gamepadui
}

switch_session() {
    if command -v steamos-session-select >/dev/null 2>&1; then
        exec steamos-session-select gamescope
    fi

    notify "No supported Gaming Mode session switcher was found. Install and configure gamescope-session-steam, then select its session from your display manager."
    exit 1
}

case "$mode" in
    auto)
        if command -v steamos-session-select >/dev/null 2>&1; then
            switch_session
        else
            launch_nested
        fi
        ;;
    nested)
        launch_nested
        ;;
    session)
        switch_session
        ;;
    *)
        printf 'Usage: %s [auto|nested|session]\n' "$0" >&2
        exit 2
        ;;
esac

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 12,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(cba6f7ee)", "rgba(89b4faee)" }, angle = 45 },
      inactive_border = "rgba(585b70aa)",
    },
    layout = "dwindle",
    resize_on_border = true,
  },
  decoration = {
    rounding = 12,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.96,
    shadow = { enabled = true, range = 14, render_power = 3, color = 0x66000000 },
    blur = { enabled = true, size = 7, passes = 2, vibrancy = 0.15 },
  },
  animations = { enabled = true },
  misc = { disable_hyprland_logo = true, force_default_wallpaper = 0 },
})

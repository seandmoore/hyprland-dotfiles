-- Hyprland dotfiles entry point.
-- Modules live beside this file under modules/.

package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua"

require("modules.monitors")
require("modules.programs")
require("modules.autostart")
require("modules.environment")
require("modules.appearance")
require("modules.input")
require("modules.keybinds")
require("modules.rules")

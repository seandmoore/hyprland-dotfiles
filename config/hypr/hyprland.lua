-- Hyprland dotfiles entry point.
-- Modules live beside this file under modules/.

local config_home = os.getenv("XDG_CONFIG_HOME")
if not config_home or config_home == "" then
  config_home = os.getenv("HOME") .. "/.config"
end
package.path = config_home .. "/hypr/?.lua;" .. package.path

require("modules.monitors")
require("modules.programs")
require("modules.autostart")
require("modules.environment")
require("modules.appearance")
require("modules.input")
require("modules.keybinds")
require("modules.rules")

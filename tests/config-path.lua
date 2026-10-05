-- Exercise the real entry point with a custom root (including spaces), empty XDG,
-- and default XDG. HOME is simulated here without changing the process environment.
local entry = assert(arg[1])
local original_getenv = os.getenv
local original_path = package.path
local modules = { 'monitors', 'programs', 'autostart', 'environment', 'appearance', 'input', 'keybinds', 'rules' }
local searcher = function(name)
  if name:match('^modules%.') then
    assert(package.path:sub(1, #_G.expected_prefix) == _G.expected_prefix, package.path)
    return function() return true end
  end
end
table.insert(package.searchers, 1, searcher)
for _, config in ipairs({ '/tmp/custom config', '', false }) do
  os.getenv = function(name)
    if name == 'HOME' then return '/tmp/test-user' end
    if name == 'XDG_CONFIG_HOME' then return config or nil end
    return original_getenv(name)
  end
  expected_prefix = ((config and config ~= '') and config or '/tmp/test-user/.config') .. '/hypr/?.lua;'
  package.path = original_path
  for _, name in ipairs(modules) do package.loaded['modules.' .. name] = nil end
  dofile(entry)
end
os.getenv = original_getenv
package.path = original_path
print('Config path regression checks passed (custom, empty, unset XDG_CONFIG_HOME)')

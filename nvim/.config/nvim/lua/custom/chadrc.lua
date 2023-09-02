---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

M.ui = {
  theme = "kanagawa",
  tabufline = {
    enabled = false,
  },
  statusline = {
    overriden_modules = function(modules)
      table.remove(modules, 5)
    end,
  },
}

return M

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
    theme = "vscode",
    overriden_modules = function(modules)
      -- cwd
      table.remove(modules, 13)
      -- file type
      table.remove(modules, 11)
      -- cursor position
      table.remove(modules, 9)
      -- lsp progress
      table.remove(modules, 5)
      -- file info
      table.remove(modules, 2)
    end,
  },
}

return M

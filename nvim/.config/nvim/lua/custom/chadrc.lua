---@type ChadrcConfig
local M = {}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

M.ui = {
  theme = "tokyonight",
  tabufline = {
    enabled = false,
  },
  statusline = {
    overriden_modules = function()
      return {
        LSP_progress = function()
          return ""
        end,
      }
    end,
  },
}

return M

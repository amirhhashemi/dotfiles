local M = {}

M.ui = {
  theme = "yoru",
  hl_add = {
    Winbar = { bg = "NONE", sp = "none" },
  },
}

M.mappings = require "custom.mappings"

M.plugins = {
  user = require "custom.plugins",
  remove = require "custom.plugins.remove",
  override = require "custom.plugins.override",
}

return M

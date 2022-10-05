local M = {}

M.ui = {
  theme = "tokyonight",
}

M.mappings = require "custom.mappings"

M.plugins = require("custom.plugins") 
-- {
--  --  user = require "custom.plugins",
--  -- remove = require "custom.plugins.remove",
--  -- override = require "custom.plugins.override",
-- }

return M

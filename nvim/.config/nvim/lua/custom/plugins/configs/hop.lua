local present, hop = pcall(require, "hop")

if not present then
   return
end

local options = {
   keys = "etovxqpdygfblzhckisuran",
}

local M = {}

M.options = options

M.config = function()
   hop.setup(options)
end

return M

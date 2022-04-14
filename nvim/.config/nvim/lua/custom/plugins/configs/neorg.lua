local present, neorg = pcall(require, "neorg")

if not present then
   return
end

local options = {
   load = {
      ["core.defaults"] = {},
      ["core.gtd.base"] = {
         config = {
            workspace = "personal",
            inbox = "todos.norg",
         },
      },
      ["core.norg.dirman"] = {
         config = {
            workspaces = {
               work = "~/Documents/notes/work",
               personal = "~/Documents/notes/personal",
            },
         },
      },
      ["core.norg.concealer"] = {},
      ["core.norg.completion"] = {
         config = {
            engine = "nvim-cmp",
         },
      },
      ["core.norg.qol.toc"] = {},
   },
}

local M = {}

M.options = options

M.config = function()
   neorg.setup(options)
end

return M

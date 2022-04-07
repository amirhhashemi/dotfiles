require "custom.autocmds"

-- local map = require("core.utils").map
local map = vim.keymap.set
local g = vim.g
local opt = vim.opt

vim.cmd "colorscheme tokyonight"

_G.luasnip = {}
_G.luasnip.vars = {
   username = "ahhshm",
   email = "ahhdev@gmail.com",
   github = "https://github.com/ahhshm",
   real_name = "Arman Hashemi",
   date_format = "%m-%d-%Y",
}

map("n", "<leader>m", function()
   require("harpoon.mark").add_file()
end)
map("n", "<leader>tm", function()
   require("harpoon.ui").toggle_quick_menu()
end)

map("n", "<leader>mn", function()
   require("harpoon.ui").nav_next()
end)
map("n", "<leader>mp", function()
   require("harpoon.ui").nav_prev()
end)
map("n", "<leader>mt", function()
   require("harpoon.term").sendCommand(1, "ls -La")
end)

map("n", "<C-h>", function()
   require("Navigator").left()
end)
map("n", "<C-k>", function()
   require("Navigator").up()
end)
map("n", "<C-l>", function()
   require("Navigator").right()
end)
map("n", "<C-j>", function()
   require("Navigator").down()
end)

map("n", "<A-j>", function()
   require("neoscroll").scroll(15, true, 250)
end)
map("n", "<A-k>", function()
   require("neoscroll").scroll(-15, true, 250)
end)

map("n", "<leader>on", ":Neorg gtd capture<CR>")
map("n", "<leader>ov", ":Neorg gtd views<CR>")

map("n", "<leader>cc", ":Telescope <CR>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- remove search highlights
map("n", "<leader>l", ":noh<CR>")

-- go to last buffer
map("n", "<leader><leader>", "<C-^>")

map("n", "<leader>bp", ":BufferLinePick<CR>")

-- move selected line up/down with K/J or Alt-k/Alt-j
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- trouble
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
map("n", "gR", "<cmd>Trouble lsp_references<cr>")

opt.whichwrap = ""
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

g.gitblame_enabled = 0

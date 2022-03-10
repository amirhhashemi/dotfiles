-- MAPPINGS
local map = require("core.utils").map
local g = vim.g
local opt = vim.opt

vim.cmd "colorscheme tokyonight"

map("n", "<leader>cc", ":Telescope <CR>")

map("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>")
map("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>")
map("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>")
map("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>l", ":noh<CR>")

map("n", "<leader>bp", ":BufferLinePick<CR>")

map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
map("n", "gR", "<cmd>Trouble lsp_references<cr>")

map("n", "<leader>m", ':lua require("harpoon.mark").add_file()<CR>')
map("n", "<leader>tm", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')
map("n", "<leader>mn", ':lua require("harpoon.ui").nav_next()<CR>')
map("n", "<leader>mp", ':lua require("harpoon.ui").nav_prev()<CR>')
map("n", "<leader>mt", ':lua require("harpoon.term").sendCommand(1, "ls -La")<CR>')

opt.wrap = false
opt.whichwrap = ""
opt.scrolloff = 8
opt.sidescrolloff = 8

g.gitblame_enabled = 0

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = 0,
}

g.nvim_tree_indent_markers = 0

g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
   },
   folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
   },
}

local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-k>", ":m-2<CR>", opts)
keymap("n", "<A-j>", ":m+<CR>", opts)
keymap("v", "<A-k>", ":m .+1<CR>==", opts)
keymap("v", "<A-j>", ":m .-2<CR>==", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>fw", "<CMD>Telescope live_grep<cr>", opts)

-- Tree
keymap("n", "<C-n>", "<CMD>NvimTreeToggle<CR>", opts)

-- Buffer Line
keymap("n", "<S-h>", "<CMD>BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-l>", "<CMD>BufferLineCycleNext<CR>", opts)
keymap("n", "<leader>x", "<CMD>bd<CR>", opts)

keymap("n", "<C-_>", "gcc", { noremap = false })
keymap("v", "<C-_>", "gc", { noremap = false })

keymap("v", "<leader>y", '"+y', { noremap = false, silent = true })
keymap("n", "<leader>y", '"+y', { noremap = false, silent = true })
keymap("n", "<leader>p", '"+p', { noremap = false, silent = true })

keymap("i", ",", ",<C-g>u", opts)
keymap("i", ".", ".<C-g>u", opts)
keymap("i", "!", "!<C-g>u", opts)
keymap("i", "?", "?<C-g>u", opts)

keymap("n", "cn", "*``cgn", opts)
keymap("n", "cN", "*``cgN", opts)

keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

keymap("n", "<leader>sv", "<CMD>vsplit<CR>", opts)
keymap("n", "<leader>sh", "<CMD>split<CR>", opts)

keymap("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
keymap("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
keymap("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
keymap("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)

keymap("n", "<leader>xx", "<CMD>TroubleToggle<CR>", opts)
keymap("n", "<leader>xw", "<CMD>Trouble workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", "<CMD>Trouble document_diagnostics<CR>", opts)
keymap("n", "<leader>xl", "<CMD>Trouble loclist<cr>", opts)
keymap("n", "<leader>xq", "<CMD>Trouble quickfix<cr>", opts)
keymap("n", "gR", "<CMD>Trouble lsp_references<CR>", opts)
keymap("n", "gT", "<CMD>Trouble lsp_type_definitions<CR>", opts)

keymap("n", "<leader>cs", "<CMD>Cheatsheet<CR>", opts)

keymap("n", "<leader>ch", "<CMD>Telescope neoclip<CR>", { silent = true })

keymap("n", "<leader>l", ":noh<CR>", opts)

keymap("n", "bp", ":BufferLinePick<CR>", opts)
-- close all buffers execpt the current one
keymap("n", "<leader>bc", ":%bd|e#|bd#<CR>", opts)

vim.cmd("let g:gitblame_enabled = 0")
keymap("n", "bt", ":GitBlameToggle<CR>", opts)

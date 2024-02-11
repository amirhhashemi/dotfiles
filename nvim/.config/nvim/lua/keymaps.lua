local map = vim.keymap.set

map("n", "'", "`")

map("n", "<leader><leader>", "<C-^>")

map({ "n", "v" }, "X", '"_x')
map({ "n", "v" }, "c", '"_c')

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>l", "<CMD>noh<CR>")

map("n", "J", "mzJ`z")

-- Don't copy the replaced text after pasting in visual mode
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

map({ "n", "v" }, "gy", '"+y')
map("n", "gp", '"+p')
map("v", "gp", '"_d"+P')
map({ "n", "v" }, "gP", '"+P')

map("c", "<C-j>", "<C-n>")
map("c", "<C-k>", "<C-p>")

map("n", "tn", "<Cmd>setlocal number!<CR>")
map("n", "tr", "<Cmd>setlocal relativenumber!<CR>")

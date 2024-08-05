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

map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>')

map({ "n", "v" }, "gy", '"+y')
map("n", "gp", '"+p')
map("v", "gp", '"_d"+P')
map({ "n", "v" }, "gP", '"+P')

map("c", "<C-j>", "<C-n>")
map("c", "<C-k>", "<C-p>")

map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

map("n", "<M-,>", "<C-w>5<")
map("n", "<M-.>", "<C-w>5>")
map("n", "<M-t>", "<C-w>+")
map("n", "<M-s>", "<C-w>-")

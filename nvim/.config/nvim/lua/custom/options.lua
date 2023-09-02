local opt = vim.opt

opt.clipboard = ""
opt.cmdheight = 0
opt.wrap = false
opt.relativenumber = true
opt.whichwrap = ""

vim.o.guifont = "FiraCode Nerd Font:h11"

-- https://github.com/rmagatti/auto-session#recommended-sessionoptions-config
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

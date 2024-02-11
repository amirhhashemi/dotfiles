local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalleader = "\\"
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.skip_ts_context_commentstring_module = true

opt.autowrite = true
opt.clipboard = ""
opt.cmdheight = 0
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2
opt.confirm = true
opt.cursorline = true
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.laststatus = 3
opt.list = true
opt.listchars = {
	extends = "…",
	precedes = "…",
	nbsp = "␣",
	tab = "  ",
}
opt.mouse = "a"
opt.number = true
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 4
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
opt.winminwidth = 5
opt.wrap = false
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.statusline = "%!v:lua.require('utils.statusline').run()"
opt.smoothscroll = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.require'utils'.foldexpr()"
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldtext = "v:lua.require'utils'.foldtext()"
opt.formatexpr = "v:lua.require'utils'.formatexpr()"
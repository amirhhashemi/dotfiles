vim.g.mapleader = " "
vim.g.maplocalleader = "  "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.skip_ts_context_commentstring_module = true

vim.o.guifont = "JetBrainsMono NF:h11"

vim.opt.autowrite = true
vim.opt.clipboard = ""
vim.opt.cmdheight = 0
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 2
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
	extends = "…",
	precedes = "…",
	nbsp = "␣",
	tab = "  ",
}
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.wildmode = "longest:full,full"
vim.opt.winminwidth = 5
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.statusline = "%!v:lua.require('utils.statusline').run()"
vim.opt.smoothscroll = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.require'utils'.foldexpr()"
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.require'utils'.foldtext()"
vim.opt.formatexpr = "v:lua.require'utils'.formatexpr()"

vim.filetype.add({
	filename = {
		[".env.example"] = "sh",
		[".env.local"] = "sh",
		[".env.production.example"] = "sh",
		[".env.production"] = "sh",
		[".env.production.local"] = "sh",
		[".env.development.example"] = "sh",
		[".env.development"] = "sh",
		[".env.development.local"] = "sh",
		[".env.test.example"] = "sh",
		[".env.test"] = "sh",
		[".env.test.local"] = "sh",
	},
})

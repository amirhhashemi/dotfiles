local options = {
	-- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	mouse = "a", -- allow the mouse to be used in neovim
	swapfile = false, -- creates a swapfile
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	backup = false, -- creates a backup file
	termguicolors = true, -- set term gui colors (most terminals support this)
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	wrap = false, -- display lines as one long line
	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	cursorline = true, -- highlight the current line
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	ignorecase = true, -- ignore case in search patterns
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- disable some builtin vim plugins
local disabled_built_ins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

vim.o.background = "dark"
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true

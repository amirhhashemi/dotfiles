local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local packer = require("packer")

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
})

return packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lua/plenary.nvim")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("nvim-lualine/lualine.nvim")
	-- use("feline-nvim/feline.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
	use("numToStr/Navigator.nvim")
	-- use("blackcauldron7/surround.nvim")
	-- use({ "echasnovski/mini.nvim", branch = "stable" })
	use("machakann/vim-sandwich")

	use("mattn/emmet-vim") -- laaaaaaaaaaaaaaaaaaaaaaaaazy

	use("saecki/crates.nvim") -- laaaaaaaaaaaaaaaaaaaaaaaaazy
	use("folke/todo-comments.nvim")
	use("norcalli/nvim-colorizer.lua")

	use("folke/trouble.nvim")
	use("nvim-lua/popup.nvim")

	use("sudormrfbin/cheatsheet.nvim")
	use("tami5/sqlite.lua")
	use("AckslD/nvim-neoclip.lua")
	use("antoinemadec/FixCursorHold.nvim")
	use("petertriho/nvim-scrollbar")
	-- use("kevinhwang91/nvim-hlslens")
	use("haya14busa/vim-asterisk")
	use("mfussenegger/nvim-dap")
	-- use({ "sakhnik/nvim-gdb", run = ":!./install.sh" })

	-- Colorschemes
	use("folke/tokyonight.nvim")
	-- use("lunarvim/darkplus.nvim")
	-- use("ellisonleao/gruvbox.nvim")

	-- cmp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("saadparwaiz1/cmp_luasnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("onsails/lspkind-nvim")
	use("uga-rosa/cmp-dictionary")

	-- snippets
	use("L3MON4D3/LuaSnip")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	use("b0o/schemastore.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("windwp/nvim-ts-autotag")
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-textobjects")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("sindrets/diffview.nvim")
	use("pwntester/octo.nvim")
	use("f-person/git-blame.nvim")
end)

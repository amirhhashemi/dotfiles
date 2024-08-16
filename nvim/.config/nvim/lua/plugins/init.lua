return {
	{ "nvim-lua/plenary.nvim" },
	{
		"rmagatti/auto-session",
		lazy = false,
		opts = {
			log_level = "error",
		},
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = true,
	},
	-- {
	-- 	"numToStr/Navigator.nvim",
	-- 	keys = {
	-- 		{ "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n", "t" } },
	-- 		{ "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n", "t" } },
	-- 		{
	-- 			"<C-j>",
	-- 			"<CMD>NavigatorDown<CR>",
	-- 			mode = { "n", "t" },
	-- 		},
	-- 		{
	-- 			"<C-k>",
	-- 			"<CMD>NavigatorUp<CR>",
	-- 			mode = { "n", "t" },
	-- 		},
	-- 	},
	-- 	opts = {
	-- 		disable_on_zoom = true,
	-- 	},
	-- },
	{
		"swaits/zellij-nav.nvim",
		event = "VeryLazy",
		keys = {
			{ "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left" } },
			{ "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
			{ "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
			{ "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
		},
		opts = {},
	},
	-- {
	-- 	"hiasr/vim-zellij-navigator.nvim",
	-- 	config = true,
	-- },
	{
		"echasnovski/mini.misc",
		lazy = false,
		config = function()
			require("mini.misc").setup_auto_root({ ".git" })
			require("mini.misc").setup_restore_cursor()
		end,
	},
}

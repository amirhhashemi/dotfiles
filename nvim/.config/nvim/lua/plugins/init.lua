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
		opts = {
			default_mappings = false,
			mappings = {
				i = {
					j = {
						k = "<Esc>",
					},
				},
				c = {
					j = {
						k = "<Esc>",
					},
				},
				t = {
					j = {
						k = "<C-\\><C-n>",
					},
				},
				v = {
					j = {
						k = "<Esc>",
					},
				},
				s = {
					j = {
						k = "<Esc>",
					},
				},
			},
		},
	},
	{
		"amirhhashemi/Navigator.nvim",
		keys = {
			{ "<C-h>", "<CMD>NavigatorLeft<CR>", mode = { "n", "t" } },
			{ "<C-l>", "<CMD>NavigatorRight<CR>", mode = { "n", "t" } },
			{
				"<C-j>",
				"<CMD>NavigatorDown<CR>",
				mode = { "n", "t" },
			},
			{
				"<C-k>",
				"<CMD>NavigatorUp<CR>",
				mode = { "n", "t" },
			},
		},
		opts = {
			disable_on_zoom = true,
		},
	},
	{
		"echasnovski/mini.misc",
		lazy = false,
		config = function()
			-- require("mini.misc").setup_auto_root({ ".git" })
			require("mini.misc").setup_restore_cursor()
			require("mini.misc").setup_termbg_sync()
		end,
	},
}

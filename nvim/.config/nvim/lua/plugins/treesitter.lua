return {
	{
		"windwp/nvim-ts-autotag",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			max_lines = 3,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = "all",
				highlight = {
					enable = true,
					use_languagetree = true,
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}

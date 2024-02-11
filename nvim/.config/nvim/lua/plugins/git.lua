return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "󰍵" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "│" },
				},
				current_line_blame_opts = {
					delay = 0,
				},
				on_attach = function(bufnr)
					local map = vim.keymap.set
					map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { buffer = bufnr })
					map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { buffer = bufnr })
					map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", { buffer = bufnr })
					map("n", "<leader>hp", ":Gitsigns preview_hunk<CR>", { buffer = bufnr })
					map("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<CR>", { buffer = bufnr })
					map("n", "<leader>td", ":Gitsigns toggle_deleted<CR>", { buffer = bufnr })
				end,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = true,
	},
}

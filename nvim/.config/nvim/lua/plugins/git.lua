return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
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
					map("n", "<leader>hs", gitsigns.stage_hunk, { buffer = bufnr })
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { buffer = bufnr })
					map("n", "<leader>hr", gitsigns.reset_hunk, { buffer = bufnr })
					map("v", "<leader>hr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { buffer = bufnr })
					map("n", "<leader>hu", gitsigns.undo_stage_hunk, { buffer = bufnr })
					map("n", "<leader>hp", gitsigns.preview_hunk, { buffer = bufnr })
					map("n", "<leader>hb", function()
						gitsigns.blame_line({ full = true })
					end, { buffer = bufnr })
					map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { buffer = bufnr })
					map("n", "<leader>td", gitsigns.toggle_deleted, { buffer = bufnr })
					map("n", "]g", gitsigns.next_hunk, { buffer = bufnr })
					map("n", "[g", gitsigns.prev_hunk, { buffer = bufnr })
				end,
			})
		end,
	},
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewLog" } },
	{ "tpope/vim-fugitive", event = "VeryLazy" },
}

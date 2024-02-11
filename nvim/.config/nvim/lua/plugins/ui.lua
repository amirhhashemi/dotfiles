return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			overrides = function(colors)
				local theme = colors.theme
				return {
					TelescopeTitle = { fg = theme.ui.special, bold = true },
					TelescopePromptNormal = { bg = theme.ui.bg_p1 },
					TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
					TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
					TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
					TelescopePreviewNormal = { bg = theme.ui.bg_dim },
					TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
					MiniSurround = { link = "IncSearch" },
					Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
					PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
					PmenuSbar = { bg = theme.ui.bg_m1 },
					PmenuThumb = { bg = theme.ui.bg_p2 },
					-- update kanagawa to handle new treesitter highlight captures
					["@string.regexp"] = { link = "@string.regex" },
					["@variable.parameter"] = { link = "@parameter" },
					["@exception"] = { link = "@exception" },
					["@string.special.symbol"] = { link = "@symbol" },
					["@markup.strong"] = { link = "@text.strong" },
					["@markup.italic"] = { link = "@text.emphasis" },
					["@markup.heading"] = { link = "@text.title" },
					["@markup.raw"] = { link = "@text.literal" },
					["@markup.quote"] = { link = "@text.quote" },
					["@markup.math"] = { link = "@text.math" },
					["@markup.environment"] = { link = "@text.environment" },
					["@markup.environment.name"] = { link = "@text.environment.name" },
					["@markup.link.url"] = { link = "Special" },
					["@markup.link.label"] = { link = "Identifier" },
					["@comment.note"] = { link = "@text.note" },
					["@comment.warning"] = { link = "@text.warning" },
					["@comment.danger"] = { link = "@text.danger" },
					["@diff.plus"] = { link = "@text.diff.add" },
					["@diff.minus"] = { link = "@text.diff.delete" },
				}
			end,
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = "none",
						},
					},
				},
			},
			commentStyle = { italic = false },
			keywordStyle = { italic = false },
			statementStyle = { bold = false },
			background = { dark = "dragon" },
		},
		config = function(_, opts)
			require("kanagawa").setup(opts)
			vim.cmd([[colorscheme kanagawa]])
		end,
	},
	{ "NvChad/nvim-colorizer.lua", event = { "BufRead", "BufWinEnter", "BufNewFile" }, config = true },
	{ "nvim-tree/nvim-web-devicons" },
	{
		"lewis6991/satellite.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			excluded_filetypes = { "NvimTree" },
			handlers = {
				gitsigns = {
					enable = false,
				},
				marks = {
					enable = false,
				},
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		event = { "VeryLazy" },
	},
	{
		"Bekaboo/dropbar.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			sources = {
				path = {
					modified = function(sym)
						return sym:merge({
							name = sym.name .. "[+]",
							icon = " ",
							name_hl = "DiffAdded",
							icon_hl = "DiffAdded",
						})
					end,
				},
			},
			bar = {
				sources = function()
					local sources = require("dropbar.sources")
					return {
						sources.path,
					}
				end,
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
			},
			scope = {
				show_start = false,
				show_end = false,
			},
		},
		config = function(_, opts)
			require("ibl").setup(opts)
			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
		end,
	},
}

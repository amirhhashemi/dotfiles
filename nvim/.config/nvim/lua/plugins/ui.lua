return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				italic = false,
			},
			highlight_groups = {
				TelescopeBorder = { fg = "overlay", bg = "overlay" },
				TelescopeNormal = { fg = "subtle", bg = "overlay" },
				TelescopeSelection = { fg = "text", bg = "highlight_med" },
				TelescopeSelectionCaret = { fg = "love", bg = "highlight_med" },
				TelescopeMultiSelection = { fg = "text", bg = "highlight_high" },
				TelescopeTitle = { fg = "base", bg = "love" },
				TelescopePromptTitle = { fg = "base", bg = "pine" },
				TelescopePreviewTitle = { fg = "base", bg = "iris" },
				TelescopePromptNormal = { fg = "text", bg = "surface" },
				TelescopePromptBorder = { fg = "surface", bg = "surface" },
			},
		},
		config = function(_, opts)
			require("rose-pine").setup(opts)
			require("utils").sync_theme()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = true,
		priority = 1000,
		enable = false,
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
		end,
	},
	{ "NvChad/nvim-colorizer.lua", event = { "BufRead", "BufWinEnter", "BufNewFile" }, config = true },
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				override_by_extension = {
					[".env.local"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "EnvLocal",
					},
					[".env.example"] = {
						icon = "",
						color = "#d3d3d3",
						name = "EnvExample",
					},
					[".env.production"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "ProductionEnv",
					},
					[".env.production.local"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "ProductionEnvLocal",
					},
					[".env.production.example"] = {
						icon = "",
						color = "#d3d3d3",
						name = "ProductionEnvExample",
					},
					[".env.development"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "DevelopmentEnv",
					},
					[".env.development.local"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "DevelopmentEnvLocal",
					},
					[".env.development.example"] = {
						icon = "",
						color = "#d3d3d3",
						name = "DevelopmentEnvExample",
					},
					[".env.test"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "TestEnv",
					},
					[".env.test.local"] = {
						icon = "",
						color = vim.o.background == "dark" and "#faf743" or "#32310d",
						name = "TestEnvLocal",
					},
					[".env.test.example"] = {
						icon = "",
						color = "#d3d3d3",
						name = "TestEnvExample",
					},
				},
			})
			vim.api.nvim_create_autocmd("OptionSet", {
				pattern = "background",
				callback = function()
					require("nvim-web-devicons").setup({
						override_by_extension = {
							[".env.local"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "EnvLocal",
							},
							[".env.example"] = {
								icon = "",
								color = "#d3d3d3",
								name = "EnvExample",
							},
							[".env.production"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "ProductionEnv",
							},
							[".env.production.local"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "ProductionEnvLocal",
							},
							[".env.production.example"] = {
								icon = "",
								color = "#d3d3d3",
								name = "ProductionEnvExample",
							},
							[".env.development"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "DevelopmentEnv",
							},
							[".env.development.local"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "DevelopmentEnvLocal",
							},
							[".env.development.example"] = {
								icon = "",
								color = "#d3d3d3",
								name = "DevelopmentEnvExample",
							},
							[".env.test"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "TestEnv",
							},
							[".env.test.local"] = {
								icon = "",
								color = vim.o.background == "dark" and "#faf743" or "#32310d",
								name = "TestEnvLocal",
							},
							[".env.test.example"] = {
								icon = "",
								color = "#d3d3d3",
								name = "TestEnvExample",
							},
						},
					})
				end,
			})
		end,
	},
	{
		"lewis6991/satellite.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			excluded_filetypes = { "NvimTree" },
			handlers = {
				cursor = {
					enable = false,
				},
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
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
			},
			cmdline = {
				view = "cmdline",
			},
		},
	},
}

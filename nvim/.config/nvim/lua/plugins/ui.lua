return {
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

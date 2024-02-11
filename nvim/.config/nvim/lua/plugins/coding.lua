return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		init = function()
			vim.api.nvim_create_user_command("Format", function(args)
				local range = nil
				if args.count ~= -1 then
					local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
					range = {
						start = { args.line1, 0 },
						["end"] = { args.line2, end_line:len() },
					}
				end
				require("conform").format({ async = true, lsp_fallback = true, range = range })
			end, { range = true })
		end,
		opts = {
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier", "biome" } },
				javascriptreact = { { "prettierd", "prettier", "biome" } },
				typescript = { { "prettierd", "prettier", "biome" } },
				typescriptreact = { { "prettierd", "prettier", "biome" } },
				html = { { "prettierd", "prettier", "biome" } },
				css = { { "prettierd", "prettier", "biome" } },
				svelte = { { "prettierd", "prettier", "biome" } },
				astro = { { "prettierd", "prettier", "biome" } },
				json = { { "prettierd", "prettier", "biome" } },
				jsonc = { { "prettierd", "prettier", "biome" } },
				markdown = { { "prettierd", "prettier", "biome" } },
				toml = { "taplo" },
				yaml = { "yamlfmt" },
				lua = { "stylua" },
				python = { "black" },
				go = { "gofmt" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			local M = {}
			local lint = require("lint")

			lint.linters_by_ft = {
				javascript = { "eslint" },
				javascriptreact = { "eslint" },
				typescript = { "eslint" },
				typescriptreact = { "eslint" },
				svelte = { "eslint" },
				astro = { "eslint" },
				go = { "golangcilint" },
			}

			function M.debounce(ms, fn)
				local timer = vim.loop.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			function M.lint()
				-- Use nvim-lint's logic first:
				-- * checks if linters exist for the full filetype first
				-- * otherwise will split filetype by "." and add all those linters
				local names = lint._resolve_linter_by_ft(vim.bo.filetype)

				-- Add fallback linters.
				if #names == 0 then
					vim.list_extend(names, lint.linters_by_ft["_"] or {})
				end

				-- Add global linters.
				vim.list_extend(names, lint.linters_by_ft["*"] or {})

				-- Filter out linters that don't exist or don't match the condition.
				local ctx = { filename = vim.api.nvim_buf_get_name(0) }
				ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
				names = vim.tbl_filter(function(name)
					local linter = lint.linters[name]
					if not linter then
						print("Linter not found: " .. name, { title = "nvim-lint" })
					end
					return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
				end, names)

				-- Run linters.
				if #names > 0 then
					lint.try_lint(names)
				end
			end

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = M.debounce(100, M.lint),
			})
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		lazy = false,
		version = "*",
		keys = {
			{
				"<leader>e",
				"<CMD>NvimTreeToggle<CR>",
			},
		},
		opts = {
			actions = {
				open_file = {
					quit_on_open = true,
				},
			},
			view = {
				side = "right",
			},
			git = {
				enable = false,
			},
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"echasnovski/mini.comment",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
				end,
			},
			mappings = {
				comment_line = "<leader>c",
				comment_visual = "<leader>c",
				textobject = "",
			},
		},
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local ls = require("luasnip")
			local fmt = require("luasnip.extras.fmt").fmt
			local rep = require("luasnip.extras").rep
			local s = ls.snippet
			local i = ls.insert_node

			ls.add_snippets("javascript", {
				s("db", fmt('console.log("{}: ", {});', { rep(1), i(1) })),
				s("imp", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
				s("dimp", fmt('import {} from "{}"', { i(2), i(1) })),
				s("cl", fmt("console.log({})", { i(1) })),
				s("ed", fmt("// eslint-disable-next-line {}", { i(1) })),
			})
			ls.add_snippets("javascriptreact", {
				s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
				s("cn", fmt('className="{}"', { i(1) })),
			})
			ls.filetype_extend("javascriptreact", { "javascript" })
			ls.filetype_extend("typescript", { "javascript" })
			ls.filetype_extend("typescriptreact", { "javascriptreact", "typescript", "javascript" })

			local map = vim.keymap.set
			map({ "i" }, "<C-k>", function()
				ls.expand()
			end, { silent = true })
			map({ "i", "s" }, "<C-j>", function()
				ls.jump(1)
			end, { silent = true })
			map({ "i", "s" }, "<C-k>", function()
				ls.jump(-1)
			end, { silent = true })
			map({ "i", "s" }, "<C-e>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, { silent = true })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local lspkind = require("lspkind")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				formatting = {
					format = lspkind.cmp_format(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "buffer" },
				},
				experimental = {
					ghost_text = true,
				},
			}
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
					},
				},
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
						width = 0.90,
						height = 0.80,
					},
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			local map = vim.keymap.set
			map("n", "<leader>ff", builtin.find_files)
			map("n", "<leader>fw", builtin.live_grep)
			map("n", "<leader>fr", builtin.resume)
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup()

			local map = vim.keymap.set
			map("n", "gm", function()
				harpoon:list():append()
			end)
			map("n", "gl", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)
		end,
	},
	{
		"echasnovski/mini.move",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},
	{
		"echasnovski/mini.ai",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},
	{
		"echasnovski/mini.bracketed",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = true,
	},
}

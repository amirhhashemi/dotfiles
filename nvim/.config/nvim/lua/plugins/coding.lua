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
				lua = { "stylua" },
				html = { "prettierd" },
				css = { "prettierd" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				svelte = { "prettierd" },
				astro = { "prettierd" },
				php = { "php-cs-fixer" },
				go = { "gofmt" },
				python = { "black" },
				bash = { "shfmt" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				yaml = { "yamlfmt" },
				toml = { "taplo" },
				markdown = { "prettierd" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			log_level = vim.log.levels.ERROR,
			notify_on_error = true,
			notify_no_formatters = true,
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
				python = { "pyright" },
				bash = { "shellcheck" },
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
			update_focused_file = {
				enable = true,
			},
			view = {
				side = "right",
				adaptive_size = true,
			},
			git = {
				enable = false,
			},
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
			-- vim.keymap.set("n", "<leader>c", "<Plug>(comment_toggle_linewise_current)")
			-- vim.keymap.set("x", "<leader>c", "<Plug>(comment_toggle_linewise_visual)")
		end,
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
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/.git/**",
						},
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
					},
					file_ignore_patterns = { "node_modules" },
					path_display = { filename_first = true },
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
						i = {
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
							["<ESC>"] = require("telescope.actions").close,
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
			vim.keymap.set("n", "<leader>ff", builtin.find_files)
			vim.keymap.set("n", "<leader>fw", builtin.live_grep)
			vim.keymap.set("n", "<leader>fc", builtin.commands)
			vim.keymap.set("n", "<leader>tr", builtin.resume)
			vim.keymap.set("n", "<leader>tt", "<CMD>Telescope<CR>")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		config = function()
			local harpoon = require("harpoon")
			harpoon.setup()

			vim.keymap.set("n", "gm", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "gl", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			for i = 1, 5 do
				vim.keymap.set("n", string.format("<space>%s", i), function()
					harpoon:list():select(i)
				end)
			end
		end,
	},
	{ "LunarVim/bigfile.nvim", event = { "FileReadPre", "BufReadPre", "User FileOpened" } },
	{
		"echasnovski/mini.move",
		version = "*",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {},
	},
	{
		"echasnovski/mini.ai",
		version = "*",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {},
	},
	{
		"echasnovski/mini.bracketed",
		version = "*",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			disable_filetype = { "TelescopePrompt", "spectre_panel", "DressingInput" },
		},
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = { "BufRead", "BufWinEnter", "BufNewFile" },
		opts = {},
	},
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{
		"nvim-pack/nvim-spectre",
		cmd = "Spectre",
		keys = {
			{
				"<leader>s",
				function()
					require("spectre").open()
				end,
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		keys = {
			{ "<leader>or", "<CMD>OverseerRun<CR>" },
			{ "<leader>ot", "<CMD>OverseerToggle<CR>" },
			{ "<leader>oa", "<CMD>OverseerTaskAction<CR>" },
		},
		opts = {
			task_list = {
				["<C-l>"] = false,
				["<C-h>"] = false,
			},
		},
	},
	{
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			local map = vim.keymap.set

			-- Add or skip cursor above/below the main cursor.
			map({ "n", "v" }, "<leader>k", function()
				mc.lineAddCursor(-1)
			end)
			map({ "n", "v" }, "<leader>j", function()
				mc.lineAddCursor(1)
			end)

			-- Add or skip adding a new cursor by matching word/selection
			map({ "n", "v" }, "<leader>n", function()
				mc.matchAddCursor(1)
			end)
			map({ "n", "v" }, "<leader>N", function()
				mc.matchAddCursor(-1)
			end)

			-- Add all matches in the document
			map({ "n", "v" }, "<leader>A", mc.matchAllAddCursors)

			-- Rotate the main cursor.
			map({ "n", "v" }, "<up>", mc.prevCursor)
			map({ "n", "v" }, "<down>", mc.nextCursor)

			-- Easy way to add and remove cursors using the main cursor.
			map({ "n", "v" }, "<c-q>", mc.toggleCursor)

			map("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				end
			end)

			-- bring back cursors if you accidentally clear them
			map("n", "<leader>gv", mc.restoreCursors)

			-- Align cursor columns.
			map("v", "<leader>m", function()
				vim.print("yo")
				mc.alignCursors()
			end)

			-- Append/insert for each line of visual selections.
			map("v", "I", mc.insertVisual)
			map("v", "A", mc.appendVisual)

			-- match new cursors within visual selections by regex.
			map("v", "M", mc.matchCursors)

			-- Jumplist support
			map({ "v", "n" }, "<c-i>", mc.jumpForward)
			map({ "v", "n" }, "<c-o>", mc.jumpBackward)

			-- Customize how cursors look.
			local hl = vim.api.nvim_set_hl
			hl(0, "MultiCursorCursor", { link = "Cursor" })
			hl(0, "MultiCursorVisual", { link = "Visual" })
			hl(0, "MultiCursorSign", { link = "SignColumn" })
			hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
			hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
		end,
	},
}

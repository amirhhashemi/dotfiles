return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"tsserver",
				"tailwindcss",
				"cssls",
				"html",
				"svelte",
				"astro",
				"jsonls",
				"eslint",
				"dockerls",
				"pyright",
				"prismals",
				"yamlls",
				"rust_analyzer",
				"gopls",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = false,
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"prettier",
				"prettierd",
				"stylua",
				"black",
				"yamlfmt",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
		},
		config = function()
			vim.diagnostic.config({
				virtual_text = false,
			})

			local function lspSymbol(name, icon)
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
			end

			lspSymbol("Error", "")
			lspSymbol("Info", "󰋼")
			lspSymbol("Hint", "󰛨")
			lspSymbol("Warn", "")

			local on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				local map = vim.keymap.set
				map("n", "<leader>d", function()
					vim.diagnostic.open_float({ border = "rounded" })
				end, { buffer = bufnr })
				map("n", "gd", function()
					vim.lsp.buf.definition()
				end, { buffer = bufnr })
				map("n", "K", function()
					vim.lsp.buf.hover()
				end, { buffer = bufnr })
				map("n", "<leader>a", function()
					vim.lsp.buf.code_action()
				end, { buffer = bufnr })
				map("n", "<leader>r", function()
					vim.lsp.buf.rename()
				end, { buffer = bufnr })

				if client.supports_method("textDocument/semanticTokens") then
					client.server_capabilities.semanticTokensProvider = nil
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			local servers = {
				"lua_ls",
				-- "tsserver",
				"tailwindcss",
				"cssls",
				"html",
				"svelte",
				"astro",
				"jsonls",
				"eslint",
				"dockerls",
				"pyright",
				"prismals",
				"yamlls",
				"rust_analyzer",
				"gopls",
			}

			for _, server in pairs(servers) do
				local opts = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				if server == "lua_ls" then
					opts = vim.tbl_deep_extend("keep", {
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
										[vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
									},
									maxPreload = 100000,
									preloadFileSize = 10000,
								},
							},
						},
					}, opts)
				end

				if server == "tailwindcss" then
					opts = vim.tbl_deep_extend("keep", {
						filetypes = {
							"astro",
							"astro-markdown",
							"django-html",
							"htmldjango",
							"html",
							"mdx",
							"css",
							"less",
							"postcss",
							"sass",
							"scss",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
						},
						settings = {
							tailwindCSS = {
								experimental = {
									classRegex = {
										{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
										{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
									},
								},
							},
						},
					}, opts)
				end

				if server == "jsonls" then
					opts = vim.tbl_deep_extend("keep", {
						on_attach = function(client)
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
						end,
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
							},
						},
					}, opts)
				end

				require("lspconfig")[server].setup(opts)
			end
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		config = true,
	},
	{
		"folke/trouble.nvim",
		branch = "dev",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},
}

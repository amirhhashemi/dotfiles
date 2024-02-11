---@type NvPluginSpec[]
return {
  {
    "NvChad/nvterm",
    enabled = false,
  },
  { "folke/which-key.nvim", enabled = false },
  { "rafamadriz/friendly-snippets", enabled = false },
  { "NvChad/base46", enabled = false },
  { "windwp/nvim-autopairs", enabled = false },
  { "NvChad/nvim-colorizer.lua", opts = { user_default_options = { tailwind = true } } },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<C-k>"] = require("cmp").mapping.select_prev_item(),
        ["<C-j>"] = require("cmp").mapping.select_next_item(),
        ["<CR>"] = require("cmp").mapping.confirm {
          behavior = require("cmp").ConfirmBehavior.Insert,
          select = true,
        },
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
        },
      },
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {
    current_line_blame_opts = {
      delay = 0,
    },
  } },
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏",
      context_char = "▏",
      show_current_context = false,
      show_current_context_start = false,
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "noice",
        "",
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      load_ft_func = require("luasnip.extras.filetype_functions").extend_load_ft {
        typescript = { "javascript" },
        javascriptreact = { "javascript" },
        typescriptreact = { "typescript" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim" },
    },
    config = function()
      require "plugins.configs.lspconfig"

      vim.diagnostic.config {
        virtual_text = false,
      }

      local core_on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities

      local function on_attach(client, bufnr)
        core_on_attach(client, bufnr)
      end

      local servers = {
        "cssls",
        "html",
        "jsonls",
        "eslint",
        "tailwindcss",
        "prismals",
        "rust_analyzer",
        "svelte",
        "dockerls",
        "pyright",
        "taplo",
        "astro",
        "gopls",
      }

      for _, server in pairs(servers) do
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities,
        }

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
        require("conform").format { async = true, lsp_fallback = true, range = range }
      end, { range = true })
    end,
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          javascript = { { "prettierd", "prettier" } },
          javascriptreact = { { "prettierd", "prettier" } },
          typescript = { { "prettierd", "prettier" } },
          typescriptreact = { { "prettierd", "prettier" } },
          html = { { "prettierd", "prettier" } },
          css = { { "prettierd", "prettier" } },
          svelte = { { "prettierd", "prettier" } },
          astro = { { "prettierd", "prettier" } },
          json = { { "prettierd", "prettier" } },
          markdown = { { "prettierd", "prettier" } },
          toml = { "taplo" },
          yaml = { "yamlfmt" },
          lua = { "stylua" },
          python = { "black" },
          go = { "gofmt" },
          rust = { "rustfmt" },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      local M = {}
      local lint = require "lint"

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
            Util.warn("Linter not found: " .. name, { title = "nvim-lint" })
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
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    config = function()
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities

      require("typescript-tools").setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "eslint-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "prisma-language-server",
        "rust-analyzer",
        "lua-language-server",
        "stylua",
        "svelte-language-server",
        "dockerfile-language-server",
        "pyright",
        "taplo",
        "astro-language-server",
        "gopls",
        "yamlfmt",
        "yaml-language-server",
        "golangcilint",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-ts-autotag").setup {
          filetypes = {
            "html",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "svelte",
            "astro",
            "vue",
            "tsx",
            "jsx",
            "rescript",
            "xml",
            "php",
            "markdown",
            "glimmer",
            "handlebars",
            "hbs",
          },
        }
      end,
    },
    opts = {
      ensure_installed = "all",
      ignore_install = { "jsonc", "fusion", "blueprint" },
      autotag = {
        enable = true,
      },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>",
          node_incremental = "<Enter>",
          node_decremental = "<BS>",
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("treesitter-context").setup()
    end,
  },
  {
    "numToStr/Comment.nvim",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup {
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

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
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
      }
      vim.cmd [[colorscheme kanagawa]]
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "numToStr/Navigator.nvim",
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
    config = function()
      require("Navigator").setup {
        disable_on_zoom = true,
      }
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    config = function()
      require("auto-session").setup {
        log_level = "error",
      }
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("dropbar").setup {
        sources = {
          path = {
            modified = function(sym)
              return sym:merge {
                name = sym.name .. "[+]",
                icon = " ",
                name_hl = "DiffAdded",
                icon_hl = "DiffAdded",
              }
            end,
          },
        },
        bar = {
          sources = function()
            local sources = require "dropbar.sources"
            return {
              sources.path,
            }
          end,
        },
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "gm",
        function()
          require("harpoon.mark").add_file()
        end,
      },
      {
        "<leader>m",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
      },
    },
    config = function()
      require("harpoon").setup {
        global_settings = {
          save_on_toggle = true,
          save_on_change = true,
          enter_on_sendcmd = true,
          tmux_autoclose_windows = false,
          excluded_filetypes = { "harpoon" },
          mark_branch = false,
        },
      }
    end,
  },
  {
    "lewis6991/satellite.nvim",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("satellite").setup {
        excluded_filetypes = { "NvimTree" },
        handlers = {
          gitsigns = {
            enable = false,
          },
          marks = {
            enable = false,
          },
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    lazy = false,
    config = function()
      require("noice").setup {
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },
        routes = {
          {
            filter = {
              event = "msg_show",
              kind = "",
              find = "written",
            },
            opts = { skip = true },
          },
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "stevearc/dressing.nvim",
    event = { "VeryLazy" },
  },
  {
    "echasnovski/mini.move",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("mini.move").setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "echasnovski/mini.bracketed",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("mini.bracketed").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "InsertEnter",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    event = { "BufRead", "BufWinEnter", "BufNewFile" },
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.misc",
    lazy = false,
    config = function()
      require("mini.misc").setup_auto_root { ".git", "Makefile", "LICENSE" }
      require("mini.misc").setup_restore_cursor()
    end,
  },
}

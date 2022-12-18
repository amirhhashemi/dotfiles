return {
  ["NvChad/nvterm"] = false,

  ["folke/which-key.nvim"] = false,

  ["goolord/alpha-nvim"] = false,

  ["rafamadriz/friendly-snippets"] = false,

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = {
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    },
  },

  ["mbbill/undotree"] = {
    opt = true,
    cmd = { "UndotreeToggle" },
  },

  ["echasnovski/mini.ai"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "mini.ai"
    end,
    config = function()
      require("mini.ai").setup()
    end,
  },

  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "astro-language-server",
        "lua-language-server",
        "stylua",
        "rust-analyzer",
        "svelte-language-server",
        "tailwindcss-language-server",
        "dockerfile-language-server",
        "prettierd",
        "prisma-language-server",
        "taplo",
        "yaml-language-server",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "json-lsp",
        "eslint-lsp",
      },
    },
  },

  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      local telescope_actions = require "telescope.actions"

      return {
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = telescope_actions.move_selection_next,
              ["<C-k>"] = telescope_actions.move_selection_previous,
            },
          },
        },
      }
    end,
  },

  ["hrsh7th/nvim-cmp"] = {
    after = false,
    override_options = function()
      local cmp = require "cmp"

      return {
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
      }
    end,
  },

  ["NvChad/ui"] = {
    override_options = {
      tabufline = {
        enabled = false,
      },

      statusline = {
        overriden_modules = function()
          return {
            LSP_progress = function()
              return ""
            end,
          }
        end,
      },
    },
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    override_options = {
      char = "▏",
      context_char = "▏",
      show_current_context = false,
      show_current_context_start = false,
      filetype_exclude = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "noice",
      },
    },
  },

  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = {
      ensure_installed = "all",
      sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
      ignore_install = { "jsonc", "fusion" }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      highlight = {
        enable = true, -- false will disable the whole extension
        disable = {}, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
        use_languagetree = true,
      },
      indent = { enable = true, disable = { "yaml" } },
      context_commentstring = {
        enable = true,
        enable_autocmd = false,
      },
      rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      },
      autotag = {
        enable = true,
      },
      textobjects = {
        swap = {
          enable = true,
          swap_next = {
            ["<leader>s"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>S"] = "@parameter.inner",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@call.outer",
            ["ic"] = "@comment.outer",
            ["ib"] = "@block.inner",
            ["ab"] = "@block.outer",
            ["as"] = "@statement.outer",
          },
        },
      },
    },
  },

  ["nvim-treesitter/nvim-treesitter-context"] = {
    setup = function()
      require("core.lazy_load").on_file_open "nvim-treesitter-context"
    end,
    config = function()
      require("treesitter-context").setup()
    end,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    config = function()
      require "custom.plugins.configs.luasnip"
      require("core.utils").load_mappings "luasnip"
    end,
  },

  ["smjonas/inc-rename.nvim"] = {
    setup = function()
      require("core.lazy_load").on_file_open "inc-rename.nvim"
    end,
    config = function()
      require("inc_rename").setup()
    end,
  },

  ["numToStr/Comment.nvim"] = {
    branch = "jsx",
    override_options = {
      pre_hook = function(ctx)
        return require("Comment.jsx").calculate(ctx)
      end,
    },
  },

  ["lewis6991/gitsigns.nvim"] = {
    setup = function()
      require("core.lazy_load").gitsigns()
      require("core.utils").load_mappings "gitsigns"
    end,
    override_options = {
      current_line_blame_opts = {
        delay = 0,
      },
    },
  },

  ["folke/tokyonight.nvim"] = {
    config = function()
      require("tokyonight").setup {
        style = "storm",
      }
      vim.cmd "colorscheme tokyonight"
    end,
  },

  ["folke/noice.nvim"] = {
    config = function()
      require "custom.plugins.configs.noice"
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    },
  },

  ["lewis6991/satellite.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "satellite.nvim"
    end,
    config = function()
      require("custom.plugins.configs.others").satellite()
    end,
  },

  ["numToStr/Navigator.nvim"] = {
    opt = true,
    setup = function()
      require("core.utils").load_mappings "navigator"
      require("core.lazy_load").on_file_open "Navigator.nvim"
    end,
    config = function()
      require("Navigator").setup {
        disable_on_zoom = true,
      }
    end,
  },

  ["ahmedkhalf/project.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "project.nvim"
    end,
    config = function()
      require("custom.plugins.configs.others").project()
    end,
  },

  ["Darazaki/indent-o-matic"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "indent-o-matic"
    end,
    config = function()
      require("custom.plugins.configs.others").indent_o_matic()
    end,
  },

  ["ThePrimeagen/harpoon"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "harpoon"
    end,
    config = function()
      require("custom.plugins.configs.others").harpoon()
    end,
  },

  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    before = "telescope.nvim",
    run = "make",
    cond = vim.fn.executable "make" == 1,
  },

  ["rmagatti/auto-session"] = {
    config = function()
      require("custom.plugins.configs.others").auto_session()
    end,
  },

  ["antoinemadec/FixCursorHold.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "FixCursorHold.nvim"
    end,
  },

  ["max397574/better-escape.nvim"] = {
    opt = true,
    event = "InsertCharPre",
    config = function()
      require("custom.plugins.configs.others").better_escape()
    end,
  },

  ["kylechui/nvim-surround"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-surround"
    end,
    config = function()
      require("custom.plugins.configs.others").surround()
    end,
  },

  ["saecki/crates.nvim"] = {
    opt = true,
    event = "BufRead Cargo.toml",
    config = function()
      require("crates").setup()
    end,
  },

  ["luukvbaal/stabilize.nvim"] = {
    config = function()
      require("stabilize").setup()
    end,
  },

  -- LSP

  -- ["j-hui/fidget.nvim"] = {
  --   config = function()
  --     require("fidget").setup {}
  --   end,
  -- },

  ["glepnir/lspsaga.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.configs.lspsaga"
    end,
  },

  ["jose-elias-alvarez/typescript.nvim"] = {
    before = "nvim-lspconfig",
  },

  ["b0o/schemastore.nvim"] = {
    before = "nvim-lspconfig",
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.configs.null-ls"
    end,
  },

  -- Git

  ["sindrets/diffview.nvim"] = {
    opt = true,
    cmd = { "DiffviewOpen" },
    config = function()
      require("diffview").setup()
    end,
  },

  ["TimUntersberger/neogit"] = {
    opt = true,
    cmd = { "Neogit" },
    config = function()
      require("plugins.configs.others").neogit()
    end,
  },

  -- Treesitter

  ["p00f/nvim-ts-rainbow"] = {
    after = "nvim-treesitter",
  },

  ["nvim-treesitter/nvim-treesitter-textobjects"] = {
    after = "nvim-treesitter",
  },

  ["windwp/nvim-ts-autotag"] = {
    after = "nvim-treesitter",
  },

  ["nvim-treesitter/playground"] = {
    opt = true,
    cmd = { "TSPlaygroundToggle" },
  },
}

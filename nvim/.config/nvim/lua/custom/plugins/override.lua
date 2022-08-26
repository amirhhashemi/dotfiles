return {
  ["kyazdani42/nvim-tree.lua"] = {
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
  ["williamboman/mason.nvim"] = {
    ensure_installed = {
      "lua-language-server",
      "stylua",
      "rust-analyzer",
      "svelte-language-server",
      "tailwindcss-language-server",
      "dockerfile-language-server",
      "gopls",
      "black",
      "prettierd",
      "prisma-language-server",
      "pyright",
      "taplo",
      "yaml-language-server",
      "css-lsp",
      "html-lsp",
      "typescript-language-server",
      "json-lsp",
      "node-debug2-adapter",
    },
  },
  ["nvim-telescope/telescope.nvim"] = function()
    return {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
    }
  end,
  ["hrsh7th/nvim-cmp"] = function()
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
  ["NvChad/ui"] = {
    tabufline = {
      enabled = false,
    },
  },
  ["numToStr/Comment.nvim"] = {
    pre_hook = function(ctx)
      return require("Comment.jsx").calculate(ctx)
    end,
  },
  ["lukas-reineke/indent-blankline.nvim"] = {
    char = "▏",
    context_char = "▏",
    show_current_context = false,
    show_current_context_start = false,
  },
  ["nvim-treesitter/nvim-treesitter"] = {
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
  ["lewis6991/gitsigns.nvim"] = {
    current_line_blame_opts = {
      delay = 0,
    },
  },
}

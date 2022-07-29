vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
  -- use({ "~/Documents/code/test-oxi" })

  use({ "nvim-lua/plenary.nvim" })

  use({ "lewis6991/impatient.nvim" })

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  -- colorschemes

  use({
    -- "folke/tokyonight.nvim", -- original
    "ahhshm/tokyonight.nvim", -- my fork
    -- "~/Documents/code/tokyonight.nvim",
  })

  -- misc plugins

  use({ "antoinemadec/FixCursorHold.nvim", event = { "BufRead", "BufNewFile" } })

  use({ "vimpostor/vim-tpipeline" })

  -- use({
  --   "chentoast/marks.nvim",
  --   event = { "BufRead", "BufNewFile" },
  --   config = function()
  --     require("plugins.configs.others").marks()
  --   end,
  -- })

  -- use({
  --   "kevinhwang91/nvim-ufo",
  --   requires = "kevinhwang91/promise-async",
  --   event = { "BufRead", "BufNewFile" },
  --   config = function()
  --     require("plugins.configs.others").ufo()
  --   end,
  -- })

  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup()
    end,
  })

  use({
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").hydra()
    end,
  })

  use({
    "ziontee113/color-picker.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("color-picker").setup()
    end,
    setup = function()
      require("core.mappings").color_picker()
    end,
  })

  use({ "stevearc/dressing.nvim", event = "VimEnter" })

  use({
    "kylechui/nvim-surround",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").surround()
    end,
  })

  use({
    "windwp/nvim-autopairs",
    after = { "nvim-cmp", "nvim-treesitter" },
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  })

  use({
    "numToStr/Comment.nvim",
    module = "Comment",
    branch = "jsx",
    config = function()
      require("plugins.configs.others").comment()
    end,
    setup = function()
      require("core.mappings").comment()
    end,
  })

  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.configs.nvimtree")
    end,
    setup = function()
      require("core.mappings").nvimtree()
    end,
  })

  use({
    "declancm/cinnamon.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").cinnamon()
      require("core.mappings").cinnamon()
    end,
  })

  use({
    "nvim-neorg/neorg",
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require("plugins.configs.others").neorg()
    end,
    setup = function()
      packer_lazy_load("neorg")
    end,
  })

  use({
    "petertriho/nvim-scrollbar",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").scrollbar()
    end,
  })

  use({
    "luukvbaal/stabilize.nvim",
    config = function()
      require("stabilize").setup()
    end,
  })

  use({
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    config = function()
      require("crates").setup()
    end,
  })

  use({
    "numToStr/Navigator.nvim",
    config = function()
      require("Navigator").setup()
    end,
    setup = function()
      require("core.mappings").navigator()
    end,
  })

  use({
    "Darazaki/indent-o-matic",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").indent_o_matic()
    end,
  })

  use({
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    setup = function()
      require("core.mappings").trouble()
    end,
  })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.configs.others").project()
    end,
  })

  use({
    "ThePrimeagen/harpoon",
    config = function()
      require("plugins.configs.others").harpoon()
    end,
    setup = function()
      require("core.mappings").harpoon()
    end,
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").indent_blankline()
    end,
  })

  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.configs.icons")
    end,
    setup = function()
      packer_lazy_load("nvim-web-devicons")
    end,
  })

  use({
    "feline-nvim/feline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.feline")
    end,
  })

  use({
    "kevinhwang91/nvim-bqf",
    event = "BufEnter",
    config = function()
      require("plugins.configs.others").bqf()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  })

  use({ "mattn/emmet-vim", event = { "BufRead", "BufEnter" } })

  use({
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.configs.others").better_escape()
    end,
  })

  use({
    "L3MON4D3/LuaSnip",
    after = "nvim-cmp",
    event = "BufEnter",
    config = function()
      require("plugins.configs.luasnip")
    end,
    setup = function()
      packer_lazy_load("LuaSnip")
    end,
  })

  -- Treesitter

  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
  })

  use({ "nvim-treesitter/playground", after = "nvim-treesitter" })

  use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })

  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })

  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

  -- git integration

  use({
    "TimUntersberger/neogit",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").neogit()
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      packer_lazy_load("gitsigns.nvim")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("diffview").setup()
    end,
    setup = function()
      packer_lazy_load("diffview.nvim")
    end,
  })

  -- LSP

  use({
    "neovim/nvim-lspconfig",
    module = "lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
      require("plugins.configs.lspconfig")
    end,
    setup = function()
      packer_lazy_load("nvim-lspconfig")
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
  })

  use({
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "ﮊ",
          },
        },
      })
    end,
  })

  use({
    "williamboman/mason-lspconfig.nvim",
  })

  use({
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "black",
          "prettierd",
          "node-debug2-adapter",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  })

  use({ "b0o/schemastore.nvim" })

  use({
    "SmiteshP/nvim-navic",
    config = function()
      require("plugins.configs.others").navic()
    end,
  })

  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", before = "nvim-lspconfig" })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").null_ls()
    end,
  })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  -- cmp

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp")
    end,
  })

  use({
    "saadparwaiz1/cmp_luasnip",
    after = "LuaSnip",
  })

  use({
    "hrsh7th/cmp-nvim-lua",
    after = "cmp_luasnip",
  })

  use({
    "hrsh7th/cmp-nvim-lsp",
    after = "cmp-nvim-lua",
  })

  use({
    "hrsh7th/cmp-buffer",
    after = "cmp-nvim-lsp",
  })

  use({
    "hrsh7th/cmp-path",
    after = "cmp-buffer",
  })

  -- Telescope

  use({
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("plugins.configs.telescope")
    end,
    setup = function()
      require("core.mappings").telescope()
    end,
  })

  use({
    "nvim-telescope/telescope-fzf-native.nvim",
    before = "telescope.nvim",
    run = "make",
    cond = vim.fn.executable("make") == 1,
  })

  -- DAP

  use({
    "mfussenegger/nvim-dap",
    config = function()
      require("plugins.configs.dap")
    end,
    setup = function()
      require("core.mappings").dap()
    end,
  })
end)

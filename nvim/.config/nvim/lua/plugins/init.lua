local packer = prequire("plugins.packerInit")

local use = packer.use

return require("packer").startup(function()
  use({ "nvim-lua/plenary.nvim" })

  use({ "lewis6991/impatient.nvim" })

  use({
    "wbthomason/packer.nvim",
    event = "VimEnter",
  })

  -- use({
  --   "rose-pine/neovim",
  --   as = "rose-pine",
  --   tag = "v1.*",
  --   config = function()
  --     require("rose-pine").setup({
  --       dark_variant = "moon",
  --     })
  --
  --     vim.cmd("colorscheme rose-pine")
  --   end,
  -- })

  use("rktjmp/lush.nvim")

  use({ "antoinemadec/FixCursorHold.nvim", event = { "BufRead", "BufNewFile" } })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").indent_blankline()
    end,
  })

  use({
    "NvChad/nvterm",
    config = function()
      require("plugins.configs.others").nvterm()
    end,
    setup = function()
      require("core.mappings").nvterm()
    end,
  })

  use("MunifTanjim/nui.nvim")

  use({
    "bennypowers/nvim-regexplainer",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "MunifTanjim/nui.nvim",
    },
    event = "BufRead",
    config = function()
      require("plugins.configs.others").regexplainer()
    end,
    setup = function()
      packer_lazy_load("nvim-regexplainer")
    end,
  })

  use({ "nvim-treesitter/playground", after = "nvim-treesitter" })

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

  -- use({
  --   "akinsho/bufferline.nvim",
  --   after = "nvim-web-devicons",
  --   config = function()
  --     require("plugins.configs.bufferline")
  --   end,
  --   setup = function()
  --     require("core.mappings").bufferline()
  --   end,
  -- })

  use({
    "~/Documents/code/JABS.nvim",
    -- "matbme/JABS.nvim",
    -- event = "BufEnter",
    config = function()
      require("plugins.configs.others").jabs()
    end,
    setup = function()
      require("core.mappings").jabs()
    end,
  })

  use({
    "kevinhwang91/nvim-bqf",
    event = "BufEnter",
    config = function()
      require("plugins.configs.others").bqf()
    end,

    setup = function()
      -- require("core.mappings").jabs()
    end,
  })

  use({
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  })

  use({ "b0o/schemastore.nvim" })

  use({ "mattn/emmet-vim" })

  use({
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter")
    end,
  })

  use({
    "SmiteshP/nvim-gps",
    config = function()
      require("plugins.configs.others").gps()
    end,
  })

  use({ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" })
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" })
  use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })
  use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

  -- git stuff
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      packer_lazy_load("gitsigns.nvim")
    end,
  })

  use({
    "pwntester/octo.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "kyazdani42/nvim-web-devicons",
    },
    config = function()
      require("octo").setup()
    end,
    setup = function()
      packer_lazy_load("octo.nvim")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    after = "nvim-web-devicons",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup()
    end,
    setup = function()
      packer_lazy_load("diffview.nvim")
    end,
  })

  -- lsp stuff

  use({
    "neovim/nvim-lspconfig",
    module = "lspconfig",
    after = "nvim-lsp-installer",
    config = function()
      require("plugins.configs.others").lsp_installer()
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
    "stevearc/aerial.nvim",
    config = function()
      require("plugins.configs.others").aerial()
    end,
    setup = function()
      require("core.mappings").aerial()
    end,
  })

  use({ "williamboman/nvim-lsp-installer", requires = "nvim-lspconfig" })

  use({ "jose-elias-alvarez/nvim-lsp-ts-utils", requires = "nvim-lspconfig" })

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

  -- use({
  --   "Mofiqul/trld.nvim",
  --   config = function()
  --     require("trld").setup()
  --   end,
  -- })

  use({
    "max397574/better-escape.nvim",
    event = "InsertCharPre",
    config = function()
      require("plugins.configs.others").better_escape()
    end,
  })

  -- load luasnips + cmp related in insert mode only

  use({
    "hrsh7th/nvim-cmp",
    config = function()
      require("plugins.configs.cmp")
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

  -- misc plugins
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
    setup = function()
      require("core.mappings").comment()
    end,

    config = function()
      require("plugins.configs.others").comment()
    end,
  })

  -- file managing , picker etc
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

  use({ "nvim-telescope/telescope-ui-select.nvim", before = "telescope.nvim" })

  use({ "nvim-telescope/telescope-file-browser.nvim", before = "telescope.nvim" })

  use({ "nvim-telescope/telescope-cheat.nvim", before = "telescope.nvim" })

  use({ "nvim-telescope/telescope-fzf-native.nvim", before = "telescope.nvim", run = "make" })

  use({
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup({ mappings_style = "sandwich" })
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
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    setup = function()
      packer_lazy_load("todo-comments.nvim")
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
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("crates").setup()
    end,
  })

  use({
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require("notify")
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
    -- "folke/tokyonight.nvim", -- original
    "ahhshm/tokyonight.nvim", -- my fork
    -- "~/Documents/code/tokyonight.nvim",
  })

  use({ "tami5/sqlite.lua" })

  use({
    "ahmedkhalf/project.nvim",
    config = function()
      require("plugins.configs.others").project()
    end,
  })

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

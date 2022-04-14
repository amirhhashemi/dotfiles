local map = vim.keymap.set

return {
   { "folke/tokyonight.nvim" },
   { "tami5/sqlite.lua" },
   {
      "ahmedkhalf/project.nvim",
      config = function()
         require("custom.plugins.configs.project").config()
      end,
   },
   {
      "phaazon/hop.nvim",
      branch = "v1", -- optional but strongly recommended
      config = function()
         require("custom.plugins.configs.hop").config()
      end,
   },
   {
      "rcarriga/nvim-notify",
   },
   {
      "numToStr/Navigator.nvim",
      config = function()
         require("Navigator").setup()
      end,
   },
   {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
   },
   {
      "saecki/crates.nvim",
      event = "BufRead Cargo.toml",
      requires = "nvim-lua/plenary.nvim",
      config = function()
         require("crates").setup()
      end,
   },
   {
      "folke/todo-comments.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
      config = function()
         require("todo-comments").setup()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "todo-comments.nvim"
      end,
   },
   {
      "luukvbaal/stabilize.nvim",
      config = function()
         require("stabilize").setup()
      end,
   },
   {
      "ur4ltz/surround.nvim",
      config = function()
         require("surround").setup { mappings_style = "sandwich" }
      end,
   },
   {
      "karb94/neoscroll.nvim",
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },
   {
      "nvim-neorg/neorg",
      ft = "norg",
      after = "nvim-treesitter",
      config = function()
         require("custom.plugins.configs.neorg").config()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neorg"
      end,
   },
   { "mattn/emmet-vim" },
   { "williamboman/nvim-lsp-installer" },
   { "jose-elias-alvarez/nvim-lsp-ts-utils" },
   { "b0o/schemastore.nvim" },
   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.configs.null-ls").setup()
      end,
   },
   { "JoosepAlviste/nvim-ts-context-commentstring" },
   { "windwp/nvim-ts-autotag" },
   { "p00f/nvim-ts-rainbow" },
   { "nvim-treesitter/nvim-treesitter-textobjects" },
   {
      "sindrets/diffview.nvim",
      opt = true,
      after = "nvim-web-devicons",
      requires = "nvim-lua/plenary.nvim",
      config = function()
         require("diffview").setup()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "diffview.nvim"
      end,
   },
   {
      "pwntester/octo.nvim",
      opt = true,
      requires = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope.nvim",
         "kyazdani42/nvim-web-devicons",
      },
      config = function()
         require("octo").setup()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "octo.nvim"
      end,
   },
   { "nvim-telescope/telescope-smart-history.nvim" },
   { "nvim-telescope/telescope-ui-select.nvim" },
   { "nvim-telescope/telescope-file-browser.nvim" },
   { "mfussenegger/nvim-dap" },
}

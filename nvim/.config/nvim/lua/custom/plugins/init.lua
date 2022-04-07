local map = vim.keymap.set

return {
   { "folke/tokyonight.nvim" },
   { "tami5/sqlite.lua" },
   {
      "ahmedkhalf/project.nvim",
      config = function()
         require("custom.plugins.configs.project").setup()
      end,
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
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
   },
   { "mattn/emmet-vim" },
   {
      "saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      requires = { { "nvim-lua/plenary.nvim" } },
      config = function()
         require("crates").setup()
      end,
   },
   {
      "folke/todo-comments.nvim",
      -- opt = true,
      -- requires = "nvim-lua/plenary.nvim",
      config = function()
         require("todo-comments").setup()
      end,
      -- setup = function()
      --    require("core.utils").packer_lazy_load "todo-comments.nvim"
      -- end,
   },
   { "mfussenegger/nvim-dap" },
   {
      "luukvbaal/stabilize.nvim",
      config = function()
         require("stabilize").setup()
      end,
   },
   { "machakann/vim-sandwich" },
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
         require("neorg").setup {
            load = {
               ["core.defaults"] = {},
               ["core.gtd.base"] = {
                  config = {
                     workspace = "personal",
                     inbox = "todos.norg",
                  },
               },
               ["core.norg.dirman"] = {
                  config = {
                     workspaces = {
                        work = "~/Documents/notes/work",
                        personal = "~/Documents/notes/personal",
                     },
                  },
               },
               ["core.norg.concealer"] = {},
               ["core.norg.completion"] = {
                  config = {
                     engine = "nvim-cmp",
                  },
               },
               ["core.norg.qol.toc"] = {},
            },
         }
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neorg"
      end,
   },

   -- lsp stuff
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

   -- treesitter
   { "JoosepAlviste/nvim-ts-context-commentstring" },
   { "windwp/nvim-ts-autotag" },
   { "p00f/nvim-ts-rainbow" },
   { "nvim-treesitter/nvim-treesitter-textobjects" },

   -- Git
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
}

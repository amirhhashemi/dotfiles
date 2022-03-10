return {
   { "folke/tokyonight.nvim" },
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
   { "ThePrimeagen/harpoon" },
   -- {
   --    "akinsho/toggleterm.nvim",
   --    config = function()
   --       require("custom.plugins.configs.toggleterm").setup()
   --    end,
   -- },
   { "williamboman/nvim-lsp-installer" },
   { "jose-elias-alvarez/nvim-lsp-ts-utils" },
   { "b0o/schemastore.nvim" },
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
      config = function()
         require("todo-comments").setup()
      end,
   },
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

      -- lazy loading
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   },
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

   -- Git
   { "sindrets/diffview.nvim" },
   { "pwntester/octo.nvim" },
}

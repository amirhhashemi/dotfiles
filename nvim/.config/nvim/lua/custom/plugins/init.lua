return {
  -- Overrides

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.configs.lspconfig"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    config = function()
      require("plugins.configs.others").luasnip()
      require "custom.plugins.configs.luasnip"
      require("core.utils").load_mappings "luasnip"
    end,
  },

  ["numToStr/Comment.nvim"] = {
    branch = "jsx",
  },

  ["lewis6991/gitsigns.nvim"] = {
    setup = function()
      require("core.lazy_load").gitsigns()
      require("core.utils").load_mappings "gitsigns"
    end,
  },

  -- Misc

  ["rebelot/kanagawa.nvim"] = {
    config = function()
      vim.cmd "colorscheme kanagawa"
    end,
  },

  ["numToStr/Navigator.nvim"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "Navigator.nvim"
      require("core.utils").load_mappings "navigator"
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
      require("auto-session").setup()
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

  ["petertriho/nvim-scrollbar"] = {
    opt = true,
    setup = function()
      require("core.lazy_load").on_file_open "nvim-scrollbar"
    end,
    config = function()
      require("custom.plugins.configs.others").scrollbar()
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

  ["j-hui/fidget.nvim"] = {
    config = function()
      require("fidget").setup {}
    end,
  },

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
}

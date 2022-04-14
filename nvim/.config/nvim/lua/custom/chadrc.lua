local userPlugins = require "custom.plugins"
local map = require("core.utils").map
local cmp = require "cmp"

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,

M.options = {
   tabstop = 2,
   whichwrap = "",
   relativenumber = true,
   numberwidth = 3,
   hl_override = "custom.highlights",
   nvChad = {
      copy_cut = true, -- copy cut text ( x key ), visual and normal mode
   },
}

M.ui = {
   theme = "tokyonight",
   italic_comments = true,
}

M.plugins = {
   install = userPlugins,
   default_plugin_config_replace = {
      nvim_treesitter = "custom.plugins.configs.treesitter",
      nvim_tree = "custom.plugins.configs.nvim-tree",
      nvim_comment = "custom.plugins.configs.comment",
      luasnip = "custom.plugins.configs.luasnip",
      telescope = "custom.plugins.configs.telescope",
      nvim_colorizer = {
         user_default_options = {
            css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         },
      },
      signature = {
         floating_window = false,
      },
      gitsigns = {
         current_line_blame_opts = {
            delay = 0,
         },
         on_attach = function()
            -- Actions
            map("n", "<leader>cs", ":Gitsigns stage_hunk<CR>")
            map("v", "<leader>cs", ":Gitsigns stage_hunk<CR>")
            map("n", "<leader>cr", ":Gitsigns reset_hunk<CR>")
            map("v", "<leader>cr", ":Gitsigns reset_hunk<CR>")
            map("n", "<leader>cS", "<cmd>Gitsigns stage_buffer<CR>")
            map("n", "<leader>cu", "<cmd>Gitsigns undo_stage_hunk<CR>")
            map("n", "<leader>cR", "<cmd>Gitsigns reset_buffer<CR>")
            map("n", "<leader>cp", "<cmd>Gitsigns preview_hunk<CR>")
            map("n", "<leader>cb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
            map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
            map("n", "<leader>dt", "<cmd>Gitsigns diffthis<CR>")
            map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

            -- Text object
            map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
            map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
         end,
      },
      bufferline = {
         options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
            diagnostics_indicator = function(count, level)
               local icon = level:match "error" and " " or "f"
               return " " .. icon
            end,
         },
         highlights = false,
      },
      nvim_cmp = {
         sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "path" },
            { name = "neorg" },
         },
      },
   },
   default_plugin_remove = {
      "lukas-reineke/indent-blankline.nvim",
      "goolord/alpha-nvim",
   },
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.configs.lsp-installer",
      },
   },
   status = {
      colorizer = true,
   },
}

M.mappings = {}

M.mappings.plugins = {
   bufferline = {
      next_buffer = "<S-l>",
      prev_buffer = "<S-h>",
   },
   comment = {
      toggle = "<C-_>", -- ctrl + /
   },
}

return M

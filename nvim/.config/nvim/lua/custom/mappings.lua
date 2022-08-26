local M = {}

M.disabled = {
  i = {
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
  n = {
    ["<leader>ra"] = "",
  },
}

M.general = {
  n = {
    ["'"] = { "`" },

    ["<leader><leader>"] = { "<C-^>" },

    ["<leader>Y"] = { '"+y$', opts = { silent = true } },
    ["<leader>p"] = { '"+p', opts = { silent = true } },
    ["<leader>y"] = { '"+y', opts = { silent = true } },
    ["<leader>P"] = { '"+P', opts = { silent = true } },

    ["X"] = { '"_x' },

    ["<leader>l"] = { "<cmd> noh <CR>" },
  },

  v = {
    ["<leader>y"] = { '"+y', opts = { silent = true } },
    ["<leader>P"] = { '"+P', opts = { silent = true } },
    ["<leader>p"] = { '"_d"+P', opts = { silent = true } },

    ["X"] = { '"_x' },
  },

  c = {
    ["<C-j>"] = { "<C-n>" },
    ["<C-k>"] = { "<C-p>" },
  },
}

M.comment = {
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
    },
  },

  v = {
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    },
  },
}

M.lspconfig = {
  n = {
    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float()
      end,
    },
    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
    },
    ["<leader>tr"] = { "<cmd> set rnu! <CR>" },
  },
}

M.navigator = {
  -- plugin = true,

  n = {
    ["<C-h>"] = {
      "<cmd> NavigatorLeft <CR>",
    },
    ["<C-l>"] = {
      "<cmd> NavigatorRight <CR>",
    },
    ["<C-j>"] = {
      "<cmd> NavigatorDown <CR>",
    },
    ["<C-k>"] = {
      "<cmd> NavigatorUp <CR>",
    },
  },
}

M.harpoon = {
  -- plugin = true,

  n = {
    ["<leader>m"] = {
      function()
        require("harpoon.mark").add_file()
      end,
    },
    ["<leader>h"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
    },
    ["<leader>hs"] = { ":Gitsigns stage_hunk<CR>" },
    ["<leader>hr"] = { ":Gitsigns reset_hunk<CR>" },
    ["<leader>hS"] = { "<cmd> Gitsigns stage_buffer <CR>" },
    ["<leader>hu"] = { "<cmd> Gitsigns undo_stage_hunk <CR>" },
    ["<leader>hR"] = { "<cmd> Gitsigns reset_buffer <CR>" },
    ["<leader>hp"] = { "<cmd> Gitsigns preview_hunk <CR>" },
    ["<leader>hb"] = { '<cmd> lua require"gitsigns".blame_line{full=true} <CR>' },
    ["<leader>tb"] = { "<cmd> Gitsigns toggle_current_line_blame <CR>" },
    ["<leader>dt"] = { "<cmd> Gitsigns diffthis <CR>" },
    ["<leader>td"] = { "<cmd> Gitsigns toggle_deleted <CR>" },
  },

  o = {
    ["ih"] = { ":<C-U>Gitsigns select_hunk <CR>" },
  },

  x = {
    ["ih"] = { ":<C-U>Gitsigns select_hunk <CR>" },
  },

  v = {
    ["<leader>hr"] = { ":Gitsigns reset_hunk<CR>" },
  },
}

M.luasnip = {
  plugin = true,

  i = {
    ["<C-l>"] = {
      function()
        local ls = require "luasnip"

        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
    },
    ["<C-h>"] = {
      function()
        local ls = require "luasnip"

        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
    },
  },
  s = {
    ["<leader>l"] = {
      function()
        local ls = require "luasnip"

        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
    },
    ["<leader>h"] = {
      function()
        local ls = require "luasnip"

        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
    },
  },
}

M.lspsaga = {}

return M

---@type MappingsTable
local M = {}

M.disabled = {
  i = {
    ["<C-j>"] = "",
    ["<C-k>"] = "",
  },
  n = {
    -- lspconfig
    ["<leader>ra"] = "",
    -- nvimtree
    ["<leader>e"] = "",
    -- gitsigns
    ["<leader>rh"] = "",
    ["<leader>ph"] = "",
    ["<leader>gb"] = "",
    -- comment
    ["<leader>/"] = "",
    -- line number
    ["<leader>n"] = "",
  },
  v = {
    -- comment
    ["<leader>/"] = "",
  },
}

M.general = {
  n = {
    ["'"] = { "`" },

    ["<leader><leader>"] = { "<C-^>" },

    ["gy"] = { '"+y', opts = { silent = true } },
    ["gp"] = { '"+p', opts = { silent = true } },
    ["gP"] = { '"+P', opts = { silent = true } },

    ["X"] = { '"_x' },

    ["J"] = { "mzJ`z" },

    ["<leader>l"] = { "<cmd> noh <CR>" },

    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },

    -- Add empty lines before and after cursor line
    ["gO"] = { "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>" },
    ["go"] = { "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>" },
  },

  v = {
    ["gy"] = { '"+y', opts = { silent = true } },
    ["gp"] = { '"_d"+P', opts = { silent = true } },
    ["gP"] = { '"+P', opts = { silent = true } },

    ["X"] = { '"_x' },
  },

  c = {
    ["<C-j>"] = { "<C-n>" },
    ["<C-k>"] = { "<C-p>" },
  },

  x = {
    ["g/"] = { "<esc>/\\%V", opts = { silent = false } },
  },
}

M.lspconfig = {
  n = {
    ["<leader>e"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
    },

    ["<leader>rn"] = {
      function()
        require("nvchad_ui.renamer").open()
      end,
      "lsp rename",
    },
  },
}

M.gitsigns = {
  n = {
    ["<leader>tD"] = {
      function()
        require("gitsigns").diffthis "~"
      end,
      "Blame line",
    },
    ["<leader>tb"] = {
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      "Blame line",
    },
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>hu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>hp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
  },

  v = {
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>hu"] = {
      function()
        require("gitsigns").undo_stage_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
  },
}

M.comment = {
  n = {
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },
  v = {
    ["<C-_>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

return M

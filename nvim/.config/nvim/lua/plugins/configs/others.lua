local M = {}

M.autopairs = function()
  local present1, autopairs = pcall(require, "nvim-autopairs")
  local present2, cmp = pcall(require, "cmp")

  if not present1 and present2 then
    return
  end

  autopairs.setup({
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  })

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.better_escape = function()
  local present, escape = pcall(require, "better_escape")

  if not present then
    return
  end

  escape.setup({
    mapping = { "jk" }, -- a table with mappings to use
    timeout = vim.o.timeoutlen,
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>",
  })
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")

  if not present then
    return
  end

  local options = {
    indentLine_enabled = 1,
    char = "▏",
    filetype_exclude = {
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "nvchad_cheatsheet",
      "lsp-installer",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
  }

  blankline.setup(options)
end

M.colorizer = function()
  local present, colorizer = pcall(require, "colorizer")

  if not present then
    return
  end

  local options = {
    filetypes = {
      "*",
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      rgb_fn = false, -- CSS rgb() and rgba() functions
      hsl_fn = false, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

      -- Available modes: foreground, background
      mode = "background", -- Set the display mode.
    },
  }

  colorizer.setup(options["filetypes"], options["user_default_options"])
  vim.cmd("ColorizerReloadAllBuffers")
end

M.comment = function()
  local present, comment = pcall(require, "Comment")

  if not present then
    return
  end

  comment.setup({
    pre_hook = function(ctx)
      local U = require("Comment.utils")

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      })
    end,
  })
end

M.signature = function()
  local present, lsp_signature = pcall(require, "lsp_signature")

  if not present then
    return
  end

  lsp_signature.setup({
    bind = true,
    doc_lines = 0,
    floating_window = false,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  })
end

M.lsp_handlers = function()
  local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end

  lspSymbol("Error", "")
  lspSymbol("Info", "")
  lspSymbol("Hint", "")
  lspSymbol("Warn", "")

  vim.diagnostic.config({
    virtual_text = {
      prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = false,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })

  local default_publish_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
  vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, method, result, client_id, bufnr, config)
    default_publish_handler(err, method, result, client_id, bufnr, config)
    vim.diagnostic.setqflist({
      open = false,
      severity = { min = vim.diagnostic.severity.WARN },
    })
    -- vim.diagnostic.setloclist({
    --   open = false,
    --   severity = { min = vim.diagnostic.severity.WARN },
    -- })
  end

  -- suppress error messages from lang servers
  vim.notify = function(msg, log_level)
    if msg:match("exit code") then
      return
    end
    if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
    else
      vim.api.nvim_echo({ { msg } }, true, {})
    end
  end
end

M.gitsigns = function()
  local present, gitsigns = pcall(require, "gitsigns")

  if not present then
    return
  end

  gitsigns.setup({
    current_line_blame_opts = {
      delay = 0,
    },
    signs = {
      add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
    },
    on_attach = function()
      require("core.mappings").gitsigns()
    end,
  })
end

M.project = function()
  local present, project = pcall(require, "project_nvim")

  if not present then
    return
  end

  local options = {
    {
      manual_mode = false,
      detection_methods = { "lsp", "pattern" },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
      ignore_lsp = {},
      exclude_dirs = {},
      show_hidden = true,
      silent_chdir = true,
      datapath = vim.fn.stdpath("data"),
    },
  }
  project.setup(options)
end

M.null_ls = function()
  local present, null_ls = pcall(require, "null-ls")

  if not present then
    return
  end

  local b = null_ls.builtins

  local sources = {
    b.formatting.prettierd,
    b.formatting.stylua,
    b.formatting.gofmt,
    b.formatting.rustfmt.with({
      args = { "--edition=2018" },
    }),
    -- null_ls.builtins.code_actions.gitsigns,
  }

  null_ls.setup({
    debug = true,
    sources = sources,
    -- on_attach = function(client)
    --    if client.resolved_capabilities.document_formatting then
    --       vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    --    end
    -- end,
  })
end

M.hop = function()
  local present, hop = pcall(require, "hop")

  if not present then
    return
  end

  hop.setup({
    keys = "etovxqpdygfblzhckisuran",
  })
end

M.neorg = function()
  local present, neorg = pcall(require, "neorg")

  if not present then
    return
  end

  local options = {
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

  neorg.setup(options)
end

M.regexplainer = function()
  local present, regexplainer = pcall(require, "regexplainer")
  if not present then
    return
  end

  regexplainer.setup({
    auto = true,
    filetypes = {},
    mappings = {
      toggle = "gR",
      -- examples, not defaults:
      -- show = 'gS',
      hide = "gH",
      -- show_split = 'gP',
      -- show_popup = 'gU',
    },
    popup = {
      border = {
        padding = { 1, 1 },
        style = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
    },
  })
end

return M

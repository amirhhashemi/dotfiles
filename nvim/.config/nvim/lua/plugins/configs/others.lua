local M = {}

M.autopairs = function()
  local autopairs = prequire("nvim-autopairs")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local ts_utils = prequire("nvim-treesitter.ts_utils")
  local cmp = prequire("cmp")

  autopairs.setup({
    check_ts = true,
    ts_config = {
      all = { "string", "comment" },
    },
    fast_wrap = {},
    disable_filetype = { "TelescopePrompt", "vim" },
  })

  cmp.event:on("confirm_done", function(evt)
    local filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" }
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    local node_type = ts_utils.get_node_at_cursor():type()

    if vim.tbl_contains(filetypes, filetype) then
      if node_type ~= "named_imports" then
        cmp_autopairs.on_confirm_done()(evt)
      end
    elseif filetype == "rust" then
      if node_type ~= "use_list" then
        cmp_autopairs.on_confirm_done()(evt)
      end
    else
      cmp_autopairs.on_confirm_done()(evt)
    end
  end)
end

M.better_escape = function()
  local escape = prequire("better_escape")

  escape.setup({
    mapping = { "jk" }, -- a table with mappings to use
    timeout = vim.o.timeoutlen,
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>",
  })
end

M.colorizer = function()
  local colorizer = prequire("colorizer")

  local default = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = false, -- #RRGGBBAA hex codes
    rgb_fn = false, -- CSS rgb() and rgba() functions
    hsl_fn = false, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background
    mode = "background", -- Set the display mode.
  }

  colorizer.setup({ "*", css = { css = true, css_fn = true } }, default)
end

M.comment = function()
  local comment = prequire("Comment")

  comment.setup({
    pre_hook = function(ctx)
      -- Only calculate commentstring for tsx filetypes
      if vim.bo.filetype == "typescriptreact" then
        local U = require("Comment.utils")

        -- Determine whether to use linewise or blockwise commentstring
        local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"

        -- Determine the location where to calculate commentstring from
        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require("ts_context_commentstring.utils").get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require("ts_context_commentstring.utils").get_visual_start_location()
        end

        return require("ts_context_commentstring.internal").calculate_commentstring({
          key = type,
          location = location,
        })
      end
    end,
  })
end

M.signature = function()
  local lsp_signature = prequire("lsp_signature")

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
    -- vim.diagnostic.setqflist({
    --   open = false,
    --   severity = { min = vim.diagnostic.severity.WARN },
    -- })
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
  local gitsigns = prequire("gitsigns")

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
  local project = prequire("project_nvim")

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
  local null_ls = prequire("null-ls")

  local b = null_ls.builtins

  local sources = {
    b.formatting.prettierd,
    b.formatting.stylua,
    b.formatting.gofmt,
    b.formatting.black,
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
  local hop = prequire(require, "hop")

  hop.setup({
    keys = "etovxqpdygfblzhckisuran",
  })
end

M.neorg = function()
  local neorg = prequire("neorg")

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
      ["core.export"] = {},
      ["core.export.markdown"] = {},
    },
  }

  neorg.setup(options)
end

M.regexplainer = function()
  local regexplainer = prequire("regexplainer")

  regexplainer.setup({
    auto = false,
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

M.lsp_installer = function()
  local lsp_installer = prequire("nvim-lsp-installer")

  lsp_installer.setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
      icons = {
        server_installed = "",
        server_pending = "",
        server_uninstalled = "ﮊ",
      },
      keymaps = {
        toggle_server_expand = "<CR>",
        install_server = "i",
        update_server = "u",
        check_server_version = "c",
        update_all_servers = "U",
        check_outdated_servers = "C",
        uninstall_server = "X",
      },
    },
  })
end

M.indent_blankline = function()
  local indent_blankline = prequire("indent_blankline")

  indent_blankline.setup({
    indentLine_enabled = 1,
    char = "▏",
    context_char = "▏",
    -- filetype = { "python" },
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
    -- show_current_context = true,
    -- show_current_context_start = false,
  })
end

M.nvterm = function()
  local nvterm = prequire("nvterm")

  nvterm.setup({
    horizontal = { location = "rightbelow", split_ratio = 0.3 },
    vertical = { location = "rightbelow", split_ratio = 0.3 },
    mappings = {
      toggle = {
        horizontal = "<leader>h",
        vertical = "<leader>v",
      },
    },
  })
end

M.cinnamon = function()
  local cinnamon = prequire("cinnamon")

  cinnamon.setup({
    default_delay = 4,
    always_scroll = true,
    extra_keymaps = false,
    extended_keymaps = false,
  })
end

M.indent_o_matic = function()
  local indent_o_matic = prequire("indent-o-matic")
  indent_o_matic.setup({
    max_lines = 2048,
    standard_widths = { 2, 4, 8 },

    -- Only detect 4 spaces and tabs for Rust files
    filetype_rust = {
      standard_widths = { 4 },
    },

    filetype_python = {
      standard_widths = { 4 },
    },

    -- Don't detect 8 spaces indentations inside files without a filetype
    filetype_ = {
      standard_widths = { 2, 4 },
    },
  })
end

M.aerial = function()
  local aerial = prequire("aerial")
  aerial.setup({
    max_width = { 40 },
    on_attach = function(bufnr) end,
  })
end

M.gps = function()
  local gps = prequire("nvim-gps")

  gps.setup({
    icons = {

      ["class-name"] = "%#CmpItemKindClass#  %*",
      ["function-name"] = "%#CmpItemKindFunction# %*",
      ["method-name"] = "%#CmpItemKindMethod# %*",
      ["container-name"] = "%#CmpItemKindProperty#ﮅ %*",
      ["tag-name"] = "%#CmpItemKindKeyword#炙%*",
    },
  })
end

M.jabs = function()
  local jabs = prequire("jabs")

  jabs.setup({
    position = "center",
    width = 60,
    height = 15,
    border = "single",
    preview = {
      position = "top",
    },
    hl = {
      current = "ErrorMsg",
      split = "StatusLine",
      alternate = "WarningMsg",
      hidden = "ModeMsg",
      -- locked = c.hl and c.hl.locked,
      -- read_only = c.hl and c.hl.read_only,
      -- changed = c.hl and c.hl.changed,
      -- terminal = c.hl and c.hl.terminal,
    },
  })
end

M.bqf = function()
  local bqf = prequire("bqf")

  bqf.setup({})
end

return M

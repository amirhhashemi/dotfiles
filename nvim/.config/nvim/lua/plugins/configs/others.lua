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
      return require("Comment.jsx").calculate(ctx)
      -- Only calculate commentstring for tsx filetypes
      -- if vim.bo.filetype == "typescriptreact" then
      --   local U = require("Comment.utils")
      --
      --   -- Determine whether to use linewise or blockwise commentstring
      --   local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
      --
      --   -- Determine the location where to calculate commentstring from
      --   local location = nil
      --   if ctx.ctype == U.ctype.block then
      --     location = require("ts_context_commentstring.utils").get_cursor_location()
      --   elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      --     location = require("ts_context_commentstring.utils").get_visual_start_location()
      --   end
      --
      --   return require("ts_context_commentstring.internal").calculate_commentstring({
      --     key = type,
      --     location = location,
      --   })
      -- end
    end,
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
    on_attach = function(bufnr)
      local buf_map = function(mode, lhs, rhs)
        map(mode, lhs, rhs, { buffer = bufnr })
      end
      -- Toggle the aerial window with <leader>a
      buf_map("n", "<leader>a", "<cmd>AerialToggle!<CR>")
      -- Jump forwards/backwards with '{' and '}'
      buf_map("n", "{", "<cmd>AerialPrev<CR>")
      buf_map("n", "}", "<cmd>AerialNext<CR>")
      -- Jump up the tree with '[[' or ']]'
      buf_map("n", "[[", "<cmd>AerialPrevUp<CR>")
      buf_map("n", "]]", "<cmd>AerialNextUp<CR>")
    end,
  })
end

M.bqf = function()
  local bqf = prequire("bqf")

  bqf.setup()
end

M.harpoon = function()
  require("harpoon").setup({
    global_settings = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = true,
      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,
      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = true,
      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,
      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { "harpoon" },
      -- set marks specific to each git branch inside git repository
      mark_branch = false,
    },
  })
end

M.navic = function()
  local navic = prequire("nvim-navic")

  hl("NavicIconsFile", { link = "CmpItemKindFile" })
  hl("NavicIconsModule", { link = "CmpItemKindModule" })
  hl("NavicIconsNamespace", { link = "CmpItemKindNamespace" })
  hl("NavicIconsPackage", { link = "CmpItemKindPackage" })
  hl("NavicIconsClass", { link = "CmpItemKindClass" })
  hl("NavicIconsMethod", { link = "CmpItemKindMethod" })
  hl("NavicIconsProperty", { link = "CmpItemKindProperty" })
  hl("NavicIconsField", { link = "CmpItemKindField" })
  hl("NavicIconsConstructor", { link = "CmpItemKindConstructor" })
  hl("NavicIconsEnum", { link = "CmpItemKindEnum" })
  hl("NavicIconsInterface", { link = "CmpItemKindInterface" })
  hl("NavicIconsFunction", { link = "CmpItemKindFunction" })
  hl("NavicIconsVariable", { link = "CmpItemKindVariable" })
  hl("NavicIconsConstant", { link = "CmpItemKindConstant" })
  hl("NavicIconsString", { link = "CmpItemKindString" })
  hl("NavicIconsNumber", { link = "CmpItemKindNumber" })
  hl("NavicIconsBoolean", { link = "CmpItemKindBoolean" })
  hl("NavicIconsArray", { link = "CmpItemKindArray" })
  hl("NavicIconsObject", { link = "CmpItemKindObject" })
  hl("NavicIconsKey", { link = "CmpItemKindKey" })
  hl("NavicIconsNull", { link = "CmpItemKindNull" })
  hl("NavicIconsEnumMember", { link = "CmpItemKindEnumMember" })
  hl("NavicIconsStruct", { link = "CmpItemKindStruct" })
  hl("NavicIconsEvent", { link = "CmpItemKindEvent" })
  hl("NavicIconsOperator", { link = "CmpItemKindOperator" })
  hl("NavicIconsTypeParameter", { link = "CmpItemKindTypeParameter" })

  navic.setup({
    icons = {
      Text = " ",
      Method = " ",
      Function = " ",
      Constructor = " ",
      Field = "ﰠ ",
      Variable = " ",
      Class = "ﴯ ",
      Interface = " ",
      Module = " ",
      Property = "ﰠ ",
      Unit = "塞 ",
      Value = " ",
      Enum = " ",
      Keyword = " ",
      Snippet = " ",
      Color = " ",
      File = " ",
      Reference = " ",
      Folder = " ",
      EnumMember = " ",
      Constant = " ",
      Struct = "פּ ",
      Event = " ",
      Operator = " ",
      TypeParameter = " ",
    },
    highlight = true,
  })
end

M.scrollbar = function()
  local scrollbar = require("scrollbar")

  scrollbar.setup({
    handle = {
      highlight = "CursorLine",
    },
    marks = {
      Error = {
        highlight = "DiagnosticError",
      },
      Warn = {
        highlight = "DiagnosticWarn",
      },
      Info = {
        highlight = "DiagnosticInfo",
      },
      Hint = {
        highlight = "DiagnosticHint",
      },
    },
    excluded_buftypes = {
      "terminal",
    },
    excluded_filetypes = {
      "packer",
      "prompt",
      "TelescopePrompt",
      "NvimTree",
    },
  })
end

M.marks = function()
  require("marks").setup({
    default_mappings = true,
    -- which builtin marks to show. default {}
    -- builtin_marks = { ".", "<", ">", "^" },
    -- whether movements cycle back to the beginning/end of buffer. default true
    cyclic = true,
    -- whether the shada file is updated after modifying uppercase marks. default false
    force_write_shada = false,
    -- how often (in ms) to redraw signs/recompute mark positions.
    -- higher values will have better performance but may cause visual lag,
    -- while lower values may cause performance penalties. default 150.
    refresh_interval = 250,
    -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
    -- marks, and bookmarks.
    -- can be either a table with all/none of the keys, or a single number, in which case
    -- the priority applies to all marks.
    -- default 10.
    sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
    -- disables mark tracking for specific filetypes. default {}
    excluded_filetypes = {},
    -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
    -- sign/virttext. Bookmarks can be used to group together positions and quickly move
    -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
    -- default virt_text is "".
    bookmark_0 = {
      sign = "⚑",
      virt_text = "hello world",
    },
    mappings = {},
  })
end

M.ufo = function()
  vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  vim.wo.foldcolumn = "1"
  vim.wo.foldlevel = 99 -- feel free to decrease the value
  vim.wo.foldenable = true
  require("ufo").setup()
end

M.hydra = function()
  local Hydra = require("hydra")

  Hydra({
    name = "Side scroll",
    mode = "n",
    body = "z",
    heads = {
      { "h", "5zh" },
      { "l", "5zl", { desc = "←/→" } },
      { "H", "zH" },
      { "L", "zL", { desc = "half screen ←/→" } },
    },
  })

  --   Hydra({
  --     name = "Move through diagnostics",
  --     mode = "n",
  --     body = "<leader>d",
  --     heads = {
  --       { "j", ":lua vim.diagnostic.goto_next()" },
  --       { "k", ":lua vim.diagnostic.goto_prev()" },
  --       { "q", nil, { exit = true } },
  --     },
  --   })
end

M.neogit = function()
  local neogit = require("neogit")
end

return M

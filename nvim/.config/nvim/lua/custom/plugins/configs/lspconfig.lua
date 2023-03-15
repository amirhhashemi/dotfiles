local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

vim.diagnostic.config {
  virtual_text = false,--[[ , severity_sort = true ]]
}

-- local ns = vim.api.nvim_create_namespace "my_namespace"
-- local orig_signs_handler = vim.diagnostic.handlers.signs
--
-- vim.diagnostic.handlers.signs = {
--   show = function(_, bufnr, _, opts)
--     local diagnostics = vim.diagnostic.get(bufnr)
--
--     local max_severity_per_line = {}
--     for _, d in pairs(diagnostics) do
--       local m = max_severity_per_line[d.lnum]
--       if not m or d.severity < m.severity then
--         max_severity_per_line[d.lnum] = d
--       end
--     end
--
--     local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
--     orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
--   end,
--   hide = function(_, bufnr)
--     orig_signs_handler.hide(ns, bufnr)
--   end,
-- }

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

local servers = {
  "tsserver",
  "cssls",
  "html",
  "jsonls",
  "eslint",
  "tailwindcss",
  "prismals",
  "rust_analyzer",
  "sumneko_lua",
  "svelte",
  "gopls",
  "dockerls",
  "pyright",
  "taplo",
  "astro",
}

local present, typescript = pcall(require, "typescript")

if present then
  typescript.setup {
    disable_commands = false,
    debug = false,
    server = {
      on_attach = on_attach,
      capabilities = capabilities,
    },
  }
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "custom.plugins.configs.lsp.jsonls"
    opts = vim.tbl_deep_extend("keep", jsonls_opts, opts)
  end

  if server == "tailwindcss" then
    local tailwindcss_opts = require "custom.plugins.configs.lsp.tailwindcss"
    opts = vim.tbl_deep_extend("keep", tailwindcss_opts, opts)
  end

  require("lspconfig")[server].setup(opts)
end

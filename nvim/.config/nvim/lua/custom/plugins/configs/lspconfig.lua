local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

vim.diagnostic.config { virtual_text = false }

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
  "prismals",
  "tailwindcss",
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

  require("lspconfig")[server].setup(opts)
end

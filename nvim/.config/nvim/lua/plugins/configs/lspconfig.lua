local lspconfig = require("lspconfig")

require("plugins.configs.others").lsp_handlers()

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local on_attach = function(client, bufnr)
  -- As we use null-ls formatter by default so we disable the inbult lsp formatter
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  -- Mappings
  require("core.mappings").lspconfig(bufnr)
end

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
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server == "tsserver" then
    local tsserver_opts = require("plugins.configs.lsp.tsserver")
    opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
  end

  if server == "jsonls" then
    local tsserver_opts = require("plugins.configs.lsp.jsonls")
    opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
  end

  if server == "sumneko_lua" then
    local sumneko_opts = require("plugins.configs.lsp.sumneko")
    opts = vim.tbl_deep_extend("keep", sumneko_opts, opts)
  end

  lspconfig[server].setup(opts)
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

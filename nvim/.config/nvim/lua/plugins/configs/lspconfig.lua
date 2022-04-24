require("plugins.configs.others").lsp_handlers()

local buf_opts = { noremap = true, silent = true }

local map = require("core.utils").map

map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- as we use null-ls formatter by default so we disable the inbult lsp formatter
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions

  local buf_map = vim.api.nvim_buf_set_keymap

  buf_map(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", buf_opts)
  buf_map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", buf_opts)
  buf_map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", buf_opts)
  buf_map(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", buf_opts)
  buf_map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", buf_opts)
  buf_map(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", buf_opts)
  buf_map(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", buf_opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

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

local lsp_installer = require("nvim-lsp-installer")

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
}

lsp_installer.settings({
  ui = {},
})

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
    settings = {},
  }

  if server.name == "tsserver" then
    local tsserver_opts = require("plugins.configs.lsp.tsserver")
    opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
  end

  if server.name == "jsonls" then
    local tsserver_opts = require("plugins.configs.lsp.jsonls")
    opts = vim.tbl_deep_extend("force", opts, tsserver_opts)
  end

  if server.name == "sumneko_lua" then
    local sumneko_opts = require("plugins.configs.lsp.sumneko")
    opts = vim.tbl_deep_extend("keep", sumneko_opts, opts)
  end

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

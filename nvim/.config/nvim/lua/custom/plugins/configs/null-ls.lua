local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local b = null_ls.builtins

local sources = {
  b.formatting.prettierd.with {
    extra_filetypes = { "astro", "svelte" },
  },
  b.formatting.stylua,
  b.formatting.gofmt,
  b.formatting.black,
  b.formatting.rustfmt,
}

null_ls.setup {
  debug = false,
  sources = sources,
  filter = function(client)
    return client.name == "null-ls"
  end,
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

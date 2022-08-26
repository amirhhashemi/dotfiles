local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.prettierd.with {
    extra_filetypes = { "astro" },
  },
  b.formatting.stylua,
  b.formatting.gofmt,
  b.formatting.black,
  b.formatting.rustfmt.with {
    args = { "--edition=2021" },
  },
}

null_ls.setup {
  debug = true,
  sources = sources,
}

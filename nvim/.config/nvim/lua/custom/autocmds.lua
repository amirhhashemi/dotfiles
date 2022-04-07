local group_lsp = vim.api.nvim_create_augroup("_lsp", { clear = true })
local group_git = vim.api.nvim_create_augroup("_git", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
   callback = function()
      vim.lsp.buf.formatting_sync()
   end,
   group = group_lsp,
})

vim.api.nvim_create_autocmd("FileType", {
   callback = function()
      vim.cmd "setlocal spell"
      vim.cmd "hi clear SpellCap"
      vim.cmd "hi SpellBad gui=undercurl guifg=red"
   end,
   pattern = "gitcommit",
   group = group_git,
})

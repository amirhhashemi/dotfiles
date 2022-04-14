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
      vim.opt_local.spell = true
      vim.api.nvim_set_hl(0, "SpellCap", {})
      vim.api.nvim_set_hl(0, "SpellBad", {
         fg = "red",
         undercurl = true,
      })
   end,
   pattern = "gitcommit",
   group = group_git,
})

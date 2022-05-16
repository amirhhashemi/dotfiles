local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

local group_lsp = vim.api.nvim_create_augroup("_lsp", { clear = true })
local group_spellcheck = vim.api.nvim_create_augroup("_spellcheck", { clear = true })

-- Format before save
autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.formatting_sync()
  end,
  group = group_lsp,
})

-- Enable spellcheck in markdown and gitcommit files
autocmd("FileType", {
  callback = function()
    vim.opt_local.spell = true
    hl("SpellCap", {})
  end,
  pattern = { "gitcommit", "markdown" },
  group = group_spellcheck,
})

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Don't show any numbers inside terminals
autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd([[ setfiletype terminal ]])
  end,
})

-- Open a file from its last left off position
autocmd("BufReadPost", {
  callback = function()
    if not fn.expand("%:p"):match("m/.git/") and fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") then
      vim.cmd("normal! g'\"")
      vim.cmd("normal zz")
    end
  end,
})

-- File extension specific tabbing
-- autocmd("Filetype", {
--   pattern = "python",
--   callback = function()
--     vim.opt_local.expandtab = true
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.softtabstop = 4
--   end,
-- })

-- uncomment this if you want to open nvim with a dir
autocmd("BufEnter", {
  callback = function()
    if vim.api.nvim_buf_get_option(0, "buftype") ~= "terminal" then
      vim.cmd("lcd %:p:h")
    end
  end,
})

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})
autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- -- underline the word under cursor
-- autocmd("VimEnter", {
--   callback = function()
--     hl("CursorWord", { underline = true })
--     match_cursorword()
--   end,
-- })
-- autocmd({ "CursorMoved", "CursorMovedI" }, {
--   callback = function()
--     match_cursorword()
--   end,
-- })

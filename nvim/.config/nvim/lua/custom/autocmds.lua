local autocmd = vim.api.nvim_create_autocmd

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Close some filetypes with <q>
autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "PlenaryTestPopup",
  },
  callback = function(event)
    vim.pretty_print(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Enable spellcheck in markdown and gitcommit files
-- Remove SpellCap highlight in markdown and gitcommit files because it's annoying
autocmd("FileType", {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.spell = true
    vim.api.nvim_set_hl(0, "SpellCap", {})
  end,
})

-- Highlight yanked text
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't show any numbers inside terminals
-- Start builtin terminal in Insert mode
autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.cmd [[ setfiletype terminal ]]

    vim.cmd [[ startinsert ]]
  end,
})

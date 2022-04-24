local map = require("core.utils").map
local terminal = require("nvterm.terminal")

local cmd = vim.cmd

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", "p:let @+=@0<CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

map("n", "'", "`")

-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh <CR>")

-- remove search highlights
map("n", "<leader>l", ":noh<CR>")

-- go to the last buffer
map("n", "<leader><leader>", "<C-^>")

-- don't yank text on cut ( X )
map({ "n", "v" }, "X", '"_x')

-- center cursor when moving through serach results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- don't yank text on delete ( dd )
-- map_wrapper({ "n", "v" }, "d", '"_d')

-- move cursor within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-e>", "<End>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-a>", "<ESC>^i")

-- navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

map("n", "<leader>x", function()
  -- Force delete current buffer
  require("bufdelete").bufdelete(0, false)
end)
map("n", "<C-c>", ":%y+ <CR>") -- copy whole file content
map("n", "<S-t>", ":enew <CR>") -- new buffer
map("n", "<C-t>b", ":tabnew <CR>") -- new tabs
map("n", "<leader>n", ":set nu! <CR>")
map("n", "<leader>tn", ":set rnu! <CR>") -- relative line numbers
map("n", "<C-s>", ":w <CR>") -- ctrl + s to save file

-- move selected line up/down with K/J or Alt-k/Alt-j
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

map("t", "JK", function()
  terminal.hide()
end)

-- terminal mappings
map("n", "<Leader>s", function()
  terminal.new_or_toggle("horizontal")
end)
map("n", "<Leader>v", function()
  terminal.new_or_toggle("vertical")
end)

-- get out of terminal mode
map("t", "jk", "<C-\\><C-n>")

-- pick a hidden term
map("n", "<leader>W", ":Telescope terms <CR>")

-- spawns terminals
map("n", "<A-h>", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
map("n", "<A-v>", ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
map("n", "<leader>w", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")

-- Add Packer commands because we are not loading it at startup
cmd("silent! command PackerClean lua require 'plugins' require('packer').clean()")
cmd("silent! command PackerCompile lua require 'plugins' require('packer').compile()")
cmd("silent! command PackerInstall lua require 'plugins' require('packer').install()")
cmd("silent! command PackerStatus lua require 'plugins' require('packer').status()")
cmd("silent! command PackerSync lua require 'plugins' require('packer').sync()")
cmd("silent! command PackerUpdate lua require 'plugins' require('packer').update()")

-- add NvChadUpdate command and mapping
cmd("silent! command! NvChadUpdate lua require('nvchad').update_nvchad()")
map("n", "<leader>uu", ":NvChadUpdate <CR>")

-- plugin related mappings

local M = {}

M.bufferline = function()
  map("n", "<S-l>", ":BufferLineCycleNext <CR>")
  map("n", "<S-h>", ":BufferLineCyclePrev <CR>")
end

M.comment = function()
  map("n", "<C-_>", ":lua require('Comment.api').toggle_current_linewise()<CR>")
  map("v", "<C-_>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

M.nvimtree = function()
  map("n", "<C-n>", ":NvimTreeToggle <CR>")
  map("n", "<leader>e", ":NvimTreeFocus <CR>")
end

M.telescope = function()
  map("n", "<leader>fb", ":Telescope buffers <CR>")
  map("n", "<leader>ff", ":Telescope find_files <CR>")
  map("n", "<leader>fa", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
  map("n", "<leader>cm", ":Telescope git_commits <CR>")
  map("n", "<leader>gt", ":Telescope git_status <CR>")
  map("n", "<leader>fh", ":Telescope help_tags <CR>")
  map("n", "<leader>fw", ":Telescope live_grep <CR>")
  map("n", "<leader>fo", ":Telescope oldfiles <CR>")
  map("n", "<leader>th", ":Telescope themes <CR>")
  map("n", "<leader>cc", ":Telescope<CR>")
end

M.gitsigns = function()
  map({ "n", "v" }, "<leader>cs", ":Gitsigns stage_hunk<CR>")
  map({ "n", "v" }, "<leader>cr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>cS", "<cmd>Gitsigns stage_buffer<CR>")
  map("n", "<leader>cu", "<cmd>Gitsigns undo_stage_hunk<CR>")
  map("n", "<leader>cR", "<cmd>Gitsigns reset_buffer<CR>")
  map("n", "<leader>cp", "<cmd>Gitsigns preview_hunk<CR>")
  map("n", "<leader>cb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
  map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
  map("n", "<leader>dt", "<cmd>Gitsigns diffthis<CR>")
  map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

  -- Text object
  map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

M.trouble = function()
  map("n", "<leader>dw", "<cmd>Trouble workspace_diagnostics<cr>")
  map("n", "<leader>dd", "<cmd>Trouble document_diagnostics<cr>")
  map("n", "<leader>dl", "<cmd>Trouble loclist<cr>")
  map("n", "<leader>dq", "<cmd>Trouble quickfix<cr>")
  map("n", "gR", "<cmd>Trouble lsp_references<cr>")
end

M.navigator = function()
  map("n", "<C-h>", function()
    require("Navigator").left()
  end)

  map("n", "<C-k>", function()
    require("Navigator").up()
  end)

  map("n", "<C-l>", function()
    require("Navigator").right()
  end)

  map("n", "<C-j>", function()
    require("Navigator").down()
  end)
end

M.dap = function()
  local dap = require("dap")

  map("n", "<leader>tt", function()
    dap.toggle_breakpoint()
  end)

  map("n", "<leader>dc", function()
    dap.continue()
  end)

  map("n", "<leader>db", function()
    dap.step_back()
  end)

  map("n", "<leader>dr", function()
    dap.repl.toggle()
  end)

  map("n", "<leader>dq", function()
    dap.close()
  end)
end

M.hop = function()
  local hop = require("hop")

  map("n", "f", function()
    hop.hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })
  end)
  map("n", "F", function()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    })
  end)
  map("o", "f", function()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.AFTER_CURSOR,
      current_line_only = true,
      inclusive_jump = true,
    })
  end)
  map("o", "F", function()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      current_line_only = true,
      inclusive_jump = true,
    })
  end)
  map("", "t", function()
    hop.hint_char1({ direction = require("hop.hint").HintDirection.AFTER_CURSOR, current_line_only = true })
  end)
  map("", "T", function()
    hop.hint_char1({
      direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
      current_line_only = true,
    })
  end)
  map("n", "<leader>gl", ":HopLineStart<CR>")
  map("n", "<leader>gw", ":HopWord<CR>")
end

M.neoscroll = function()
  local neoscroll = require("neoscroll")

  map("n", "<A-j>", function()
    neoscroll.scroll(15, true, 250)
  end)
  map("n", "<A-k>", function()
    neoscroll.scroll(-15, true, 250)
  end)
end

return M

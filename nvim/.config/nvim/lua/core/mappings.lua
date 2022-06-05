-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP')
map("v", "<leader>p", '"_d"+P')

-- control system cilpboard
map({ "n", "v" }, "<leader>y", '"+y')
map({ "n" }, "<leader>Y", '"+y$')
map({ "n" }, "<leader>p", '"+p')
map({ "n", "v" }, "<leader>P", '"+P')

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

-- navigation between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-j>", "<C-w>j")

-- quickfix list
map("n", "<leader>j", ":cnext<CR>")
map("n", "<leader>k", ":cprev<CR>")

map("n", "<leader>x", function()
  close_buffer()
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

map("c", "<C-j>", "<C-n>")
map("c", "<C-k>", "<C-p>")

-- plugin related mappings

local M = {}

M.comment = function()
  map("n", "<C-_>", '<CMD>lua require("Comment.api").toggle_current_linewise()<CR>')
  map("v", "<C-_>", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')
end

M.nvimtree = function()
  map("n", "<C-n>", ":NvimTreeToggle <CR>")
end

M.telescope = function()
  map("n", "<leader>fb", ":Telescope buffers <CR>")
  map("n", "<leader>ff", ":Telescope find_files hidden=true no_ignore=true <CR>")
  map("n", "<leader>gt", ":Telescope git_status <CR>")
  map("n", "<leader>fw", ":Telescope live_grep <CR>")
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
  map("n", "<leader>tl", "<cmd>Trouble loclist<cr>")
  map("n", "<leader>tq", "<cmd>Trouble quickfix<cr>")
  -- map("n", "gR", "<cmd>Trouble lsp_references<cr>")
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
  local dap = prequire("dap")

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

M.lspconfig = function(bufnr)
  local buf = vim.lsp.buf
  local d = vim.diagnostic

  local buf_map = function(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = bufnr })
  end

  buf_map("n", "<leader>e", function()
    d.open_float()
  end)

  buf_map("n", "[d", function()
    d.goto_prev()
  end)

  buf_map("n", "]d", function()
    d.goto_next()
  end)

  buf_map("n", "<leader>q", function()
    d.setloclist({
      open = false,
      severity = { min = vim.diagnostic.severity.WARN },
    })
  end)

  buf_map("n", "gD", function()
    buf.declaration()
  end)

  buf_map("n", "gd", function()
    buf.definition()
  end)

  buf_map("n", "K", function()
    buf.hover()
  end)

  buf_map("n", "gi", function()
    buf.implementation()
  end)

  buf_map("n", "<C-k>", function()
    buf.signature_help()
  end)

  buf_map("n", "<leader>wa", function()
    buf.add_workspace_folder()
  end)

  buf_map("n", "<leader>wr", function()
    buf.remove_workspace_folder()
  end)

  buf_map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)

  buf_map("n", "<leader>D", function()
    buf.type_definition()
  end)

  buf_map("n", "<leader>rn", function()
    buf.rename()
  end)

  buf_map("n", "<leader>ca", function()
    buf.code_action()
  end)

  buf_map("n", "gr", function()
    buf.references()
  end)

  buf_map("n", "<leader>f", function()
    buf.formatting()
  end)
end

M.cinnamon = function()
  -- Paragraph movements:
  map({ "n", "x" }, "{", "<cmd>lua Scroll('{')<CR>")
  map({ "n", "x" }, "}", "<cmd>lua Scroll('}')<CR>")

  -- Previous/next search result:
  map("n", "n", "<cmd>lua Scroll('n', 1)<CR>")
  map("n", "N", "<cmd>lua Scroll('N', 1)<CR>")
  map("n", "*", "<cmd>lua Scroll('*', 1)<CR>")
  map("n", "#", "<cmd>lua Scroll('#', 1)<CR>")
  map("n", "g*", "<cmd>lua Scroll('g*', 1)<CR>")
  map("n", "g#", "<cmd>lua Scroll('g#', 1)<CR>")

  -- Previous/next cursor location:
  map("n", "<C-o>", "<cmd>lua Scroll('<C-o>', 1)<CR>")
  map("n", "<C-i>", "<cmd>lua Scroll('1<C-i>', 1)<CR>")

  -- Screen scrolling:
  map("n", "zz", "<cmd>lua Scroll('zz', 0, 1)<CR>")
  map("n", "zt", "<cmd>lua Scroll('zt', 0, 1)<CR>")
  map("n", "zb", "<cmd>lua Scroll('zb', 0, 1)<CR>")
  map("n", "z.", "<cmd>lua Scroll('z.', 0, 1)<CR>")
  map("n", "z<cR>", "<cmd>lua Scroll('zt^', 0, 1)<CR>")
  map("n", "z-", "<cmd>lua Scroll('z-', 0, 1)<CR>")
  map("n", "z^", "<cmd>lua Scroll('z^', 0, 1)<CR>")
  map("n", "z+", "<cmd>lua Scroll('z+', 0, 1)<CR>")
  map("n", "<c-y>", "<cmd>lua Scroll('<C-y>', 0, 1)<CR>")
  map("n", "<c-e>", "<cmd>lua Scroll('<C-e>', 0, 1)<CR>")

  -- Horizontal screen scrolling:
  map("n", "zH", "<cmd>lua Scroll('zH')<CR>")
  map("n", "zL", "<cmd>lua Scroll('zL')<CR>")
  map("n", "zs", "<cmd>lua Scroll('zs')<CR>")
  map("n", "ze", "<cmd>lua Scroll('ze')<CR>")
  map("n", "zh", "<cmd>lua Scroll('zh', 0, 1)<CR>")
  map("n", "zl", "<cmd>lua Scroll('zl', 0, 1)<CR>")
end

M.harpoon = function()
  map("n", "<leader>m", function()
    require("harpoon.mark").add_file()
  end)
  map("n", "<leader>b", function()
    require("harpoon.ui").toggle_quick_menu()
  end)
  map("n", "<leader>tm", function()
    require("harpoon.tmux").gotoTerminal(1)
  end)
  map("n", "<C-f>", function()
    require("harpoon.tmux").sendCommand(1, "tmux-sessionizer")
  end)
end

return M

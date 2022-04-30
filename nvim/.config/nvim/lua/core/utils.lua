local M = {}

M.map = function(mode, lhs, rhs, opt)
  local options = { noremap = true, silent = true }
  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  if not lhs or lhs == "" then
    return
  end

  vim.keymap.set(mode, lhs, rhs, opt)
end

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

M.hl = function(name, val)
  vim.api.nvim_set_hl(0, name, val)
end

M.match_cursorword = function()
  local column = vim.api.nvim_win_get_cursor(0)[2]
  local line = vim.api.nvim_get_current_line()
  local cursorword = vim.fn.matchstr(line:sub(1, column + 1), [[\k*$]])
    .. vim.fn.matchstr(line:sub(column + 1), [[^\k*]]):sub(2)

  if cursorword == vim.w.cursorword then
    return
  end
  vim.w.cursorword = cursorword
  if vim.w.cursorword_id then
    vim.call("matchdelete", vim.w.cursorword_id)
    vim.w.cursorword_id = nil
  end
  if cursorword == "" or #cursorword > 100 or #cursorword < 3 or string.find(cursorword, "[\192-\255]+") ~= nil then
    return
  end
  local pattern = [[\<]] .. cursorword .. [[\>]]
  vim.w.cursorword_id = vim.fn.matchadd("CursorWord", pattern, -1)
end

return M

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

return M

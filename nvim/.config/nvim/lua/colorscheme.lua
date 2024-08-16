local M = {}

function M.setup(opts)
	opts = { colorscheme = opts.colorscheme or "rose-pine" }

	vim.cmd("colorscheme" .. " " .. opts.colorscheme)
end

return M

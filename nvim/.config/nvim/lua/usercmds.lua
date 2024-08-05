vim.api.nvim_create_user_command("ToggleTheme", function()
	vim.fn.jobstart("toggle_theme", {
		on_exit = function()
			require("utils").sync_theme()
		end,
	})
end, {})

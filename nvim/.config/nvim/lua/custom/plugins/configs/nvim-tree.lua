local present, nvim_tree = pcall(require, "nvim-tree")

if not present then
   return
end

local g = vim.g

g.nvim_tree_show_icons = {
   folders = 1,
   files = 1,
   git = 0,
}

g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_indent_markers = 0

-- each of these are documented in `:help nvim-tree.OPTION_NAME`
g.nvim_tree_icons = {
   default = "",
   symlink = "",
   git = {
      unstaged = "",
      staged = "S",
      unmerged = "",
      renamed = "➜",
      deleted = "",
      untracked = "U",
      ignored = "◌",
   },
   folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
   },
}

local options = {
   disable_netrw = true,
   hijack_netrw = true,
   open_on_setup = true,
   ignore_ft_on_setup = {},
   auto_close = false,
   auto_reload_on_write = true,
   open_on_tab = false,
   hijack_cursor = false,
   update_cwd = true,
   hijack_unnamed_buffer_when_opening = true,
   hijack_directories = {
      enable = true,
      auto_open = true,
   },
   diagnostics = {
      enable = true,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      },
   },
   update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
   },
   system_open = {
      cmd = nil,
      args = {},
   },
   filters = {
      dotfiles = false,
      custom = {},
      exclude = { ".env" },
   },
   git = {
      enable = true,
      ignore = true,
      timeout = 500,
   },
   view = {
      width = 35,
      height = 30,
      hide_root_folder = false,
      side = "left",
      auto_resize = true,
      mappings = {
         custom_only = false,
         list = {},
      },
      number = false,
      relativenumber = false,
      signcolumn = "yes",
   },
   trash = {
      cmd = "trash",
      require_confirm = true,
   },
   actions = {
      change_dir = {
         global = false,
      },
      open_file = {
         quit_on_open = true,
      },
   },
}

nvim_tree.setup(options)

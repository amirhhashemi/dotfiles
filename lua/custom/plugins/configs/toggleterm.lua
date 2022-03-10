local toggleterm = require "toggleterm"

local M = {}

local options = {
   -- size can be a number or function which is passed the current terminal
   size = 20,
   open_mapping = [[<leader>tt]],
   hide_numbers = true, -- hide the number column in toggleterm buffers
   shade_filetypes = {},
   shade_terminals = true,
   shading_factor = "<number>", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
   start_in_insert = true,
   insert_mappings = true, -- whether or not the open mapping applies in insert mode
   terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
   persist_size = true,
   direction = "float",
   close_on_exit = true, -- close the terminal window when the process exits
   shell = vim.o.shell, -- change the default shell
   -- This field is only relevant if direction is set to 'float'
   float_opts = {
      border = "single", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      winblend = 3,
      highlights = {
         border = "Normal",
         background = "Normal",
      },
   },
}

M.options = options

M.setup = function()
   toggleterm.setup(options)
end

return M

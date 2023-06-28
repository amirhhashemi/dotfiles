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

local function get_file_name(include_path)
  local file_name = string.gsub(vim.fn.expand "%:t", "%%", "")

  local ok, devicons = pcall(require, "nvim-web-devicons")
  local f_icon = ""
  local f_hl = ""
  if ok then
    f_icon, f_hl = devicons.get_icon_by_filetype(vim.bo.filetype)
  end

  f_icon = f_icon == nil and "" or (f_icon .. " ")
  f_hl = f_hl == nil and "" or f_hl
  local file_name_with_icon = "%#" .. f_hl .. "#" .. f_icon .. "%*%#File#" .. file_name .. "%*"

  if vim.fn.bufname "%" == "" then
    return ""
  end

  if include_path == false then
    return file_name_with_icon
  end

  local sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"
  local path_list = vim.split(string.gsub(vim.fn.expand "%:~:.:h", "%%", ""), sep)
  local file_path = ""
  for _, cur in ipairs(path_list) do
    file_path = (cur == "." or cur == "~") and "" or file_path .. cur .. " > "
  end

  return file_path .. file_name_with_icon
end

local function get_file_modified_symbol()
  return vim.bo.modified and "● " or ""
end

local function config_winbar()
  local exclude = {
    ["teminal"] = true,
    ["toggleterm"] = true,
    ["prompt"] = true,
    ["NvimTree"] = true,
    ["help"] = true,
    ["noice"] = true,
  } -- Ignore float windows and exclude filetype
  if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
    vim.wo.winbar = ""
  else
    local win_val = get_file_modified_symbol() .. get_file_name(true)
    vim.wo.winbar = win_val
  end
end

-- autocmd({ "BufEnter", "BufWinEnter", "CursorMoved" }, {
--   pattern = "*",
--   callback = function()
--     config_winbar()
--   end,
-- })

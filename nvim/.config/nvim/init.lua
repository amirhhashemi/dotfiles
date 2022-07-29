local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

local core_modules = {
  "core.utils",
  "core.commands",
  "core.options",
  "core.autocmds",
  "core.mappings",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end

_G.luasnip = {}
_G.luasnip.vars = {
  username = "ahhshm",
  email = "ahhdev@gmail.com",
  github = "https://github.com/ahhshm",
  real_name = "Arman Hashemi",
  date_format = "%m-%d-%Y",
}

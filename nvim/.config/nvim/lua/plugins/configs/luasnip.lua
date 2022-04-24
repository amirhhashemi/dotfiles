local present, ls = pcall(require, "luasnip")

if not present then
  return
end

local types = require("luasnip.util.types")
local map = require("core.utils").map

ls.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "<- Choose", "Comment" } },
      },
    },
  },
})

ls.add_snippets("all", require("plugins.configs.snips.all"))
ls.add_snippets("javascript", require("plugins.configs.snips.javascript"))
ls.add_snippets("javascriptreact", require("plugins.configs.snips.javascriptreact"))
ls.add_snippets("typescriptreact", require("plugins.configs.snips.typescriptreact"))
ls.add_snippets("rust", require("plugins.configs.snips.rust"))

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascriptreact", "typescript", "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })

map({ "i", "s" }, "<C-l>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { noremap = false })

map({ "i", "s" }, "<C-h>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { noremap = false })

map("i", "<C-k>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { noremap = false })

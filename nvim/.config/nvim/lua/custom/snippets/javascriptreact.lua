local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = luasnip.snippet
local i = luasnip.insert_node

luasnip.filetype_extend("javascriptreact", { "javascript" })

return {
  s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
  s("cn", fmt('className="{}"', { i(1) })),
}

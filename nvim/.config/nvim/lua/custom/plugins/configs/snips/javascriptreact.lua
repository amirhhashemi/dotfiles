local ls = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node

local M = {
   s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
   s("cn", fmt('className="{}"', { i(1) })),
}

return M

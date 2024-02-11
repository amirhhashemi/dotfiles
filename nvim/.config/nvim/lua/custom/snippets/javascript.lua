local luasnip = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = luasnip.snippet
local i = luasnip.insert_node

return {
	s("db", fmt('console.log("{}: ", {});', { rep(1), i(1) })),
	s("imp", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
	s("dimp", fmt('import {} from "{}"', { i(2), i(1) })),
	s("cl", fmt("console.log({})", { i(1) })),
	s("ed", fmt("// eslint-disable-next-line {}", { i(1) })),
}

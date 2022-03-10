local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascriptreact", "typescript", "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })

ls.snippets = {
	javascript = {
		s("db", fmt('console.log("{}: ", {});', { rep(1), i(1) })),
		s("exe", fmt('export * from "{}"', { i(1) })),
		ls.parser.parse_snippet("imp", 'import { $2 } from "$1"'),
		ls.parser.parse_snippet("cl", "console.log($1);"),
	},
	javascriptreact = {
		s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
		ls.parser.parse_snippet("div", '<div className="$1">$2</div>'),
		ls.parser.parse_snippet("cn", 'className="$1"'),
	},
	rust = {
		s("db", fmt('println!("{}: {}", {});', { rep(1), t("{}"), i(1) })),
	},
}

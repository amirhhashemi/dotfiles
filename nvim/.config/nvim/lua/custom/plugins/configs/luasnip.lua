local present, luasnip = pcall(require, "luasnip")

if not present then
  return
end

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node

luasnip.add_snippets("javascript", {
  s("db", fmt('console.log("{}: ", {});', { rep(1), i(1) })),
  s("exe", fmt('export * from "./{}"', { i(1) })),
  s("imp", fmt('import {{ {} }} from "{}"', { i(2), i(1) })),
  s("dimp", fmt('import {} from "{}"', { i(2), i(1) })),
  s("cl", fmt("console.log({})", { i(1) })),
})

luasnip.add_snippets("javascriptreact", {
  s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
  s("cn", fmt('className="{}"', { i(1) })),
})

luasnip.add_snippets("typescriptreact", {
  s(
    "us",
    fmt("const [{}, {}] = useState<{}>({});", {
      i(1),
      f(function(args)
        local name = args[1][1]
        return "set" .. name:sub(1, 1):upper() .. name:sub(2)
      end, { 1 }),
      i(2),
      i(3),
    })
  ),
  s(
    "ue",
    fmt(
      [[
useEffect(() => {{
  {}
}}, [{}]);
]],
      {
        i(1),
        i(2),
      }
    )
  ),
})

luasnip.filetype_extend("typescript", { "javascript" })
luasnip.filetype_extend("typescriptreact", { "javascriptreact", "typescript", "javascript" })
luasnip.filetype_extend("javascriptreact", { "javascript" })

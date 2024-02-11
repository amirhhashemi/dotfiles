local luasnip = require "luasnip"
local fmt = require("luasnip.extras.fmt").fmt
local s = luasnip.snippet
local i = luasnip.insert_node

return {
  s("div", fmt('<div className="{}">{}</div>', { i(1), i(2) })),
  s("cn", fmt('className="{}"', { i(1) })),
  s("us", fmt("const [${1:state}, set${1/(.*)/${1:/capitalize}/}] = useState(${2:initValue})$0", { i(1) })),
}

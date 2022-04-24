local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local M = {
   s("db", fmt("dbg!({});", { i(1) })),
   s("snew", { t { "fn new() -> Self {", "    Self {", "        " }, i(1), t { "", "    }", "}" } }),
   s(
      "test",
      fmt(
         [[
      #[test]
      fn {}() {{
          {}
      }}
    ]],
         {
            i(1),
            i(0),
         }
      )
   ),
   s(
      "modtest",
      fmt(
         [[
      #[cfg(test)]
      mod test {{
          use super::*;
          {}
      }}
    ]],
         i(0)
      )
   ),
}

return M

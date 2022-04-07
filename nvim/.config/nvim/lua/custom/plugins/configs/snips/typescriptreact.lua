local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local M = {
   s(
      "rfc",
      fmt(
         [[
            import {{ FC }} from "react";
            
            interface {}Props {{
              {} 
            }}
            
            export const {}: FC<{}Props> = (props) => {{
              return <div className="{}">{}</div>;
            }};
            ]],
         { i(1), i(2), rep(1), rep(1), i(4), i(3) }
      )
   ),
   s(
      "gssp",
      fmt(
         [[
            export const getServerSideProps: GetServerSideProps = async ({}) => {{
              {}
              return {{
                {} 
              }}
            }};
            ]],
         {
            i(1, "context"),
            i(2),
            d(3, function()
               return sn(
                  nil,
                  c(1, {
                     fmt(
                        [[
                           props: {{
                             {}
                           }}
                           ]],
                        { i(1) }
                     ),
                     fmt(
                        [[
                           redirect: {{
                             destination: "/{}",
                             permanent: false,
                           }}
                           ]],
                        { i(1) }
                     ),
                  })
               )
            end),
         }
      )
   ),
   s(
      "gsp",
      fmt(
         [[
            export const getStaticProps: GetStaticProps = async ({}) => {{
              {}
              return {{
                props: {{
                  {} 
                }}
              }}
            }};
            ]],
         { i(1, "context"), i(2), i(3) }
      )
   ),
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
}

return M

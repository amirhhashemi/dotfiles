local ls = require "luasnip"

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

local M = {}

-- local calculate_commentstring = require("ts_context_commentstring.internal").calculate_commentstring
-- local get_cursor_location = require("ts_context_commentstring.utils").get_cursor_location
local calculate_comment_string = require("Comment.ft").calculate
local region = require("Comment.utils").get_region

local get_cstring = function(ctype)
   -- NOTE: `:gmatch` does not work for `tex` comment string since it includes `%` itself <kunzaatko>
   local cstring = calculate_comment_string { ctype = ctype, range = region() } or ""
   local cstring_table = vim.split(cstring, "%s", { plain = true, trimempty = true })
   if #cstring_table == 0 then
      return { "", "" }
   end
   return #cstring_table == 1 and { cstring_table[1], "" } or { cstring_table[1], cstring_table[2] }
end

local todo_snippet_nodes = function(aliases, opts)
   local aliases_nodes = vim.tbl_map(function(alias)
      return t(alias)
   end, aliases)
   -- TODO: logic for allowed signature-marks for a given comment... should be in the paramlist
   -- somewhere <15-03-22, kunzaatko> --
   local sigmark_nodes = {
      t "",
      t("<" .. _G.luasnip.vars.username .. ">"),
      t("<" .. os.date(_G.luasnip.vars.date_format) .. ">"),
      t("<" .. os.date(_G.luasnip.vars.date_format) .. ", " .. _G.luasnip.vars.username .. ">"),
      t("<" .. _G.luasnip.vars.username .. ", " .. _G.luasnip.vars.email .. ">"),
      t(
         "<"
            .. os.date(_G.luasnip.vars.date_format)
            .. ", "
            .. _G.luasnip.vars.username
            .. ", "
            .. _G.luasnip.vars.email
            .. ">"
      ),
   }

   local comment_node = fmta("<> <>: <>   <> <><>", {
      f(function()
         return get_cstring(opts.ctype)[1]
      end),
      c(1, aliases_nodes),
      i(3),
      c(2, sigmark_nodes),
      f(function()
         return get_cstring(opts.ctype)[2]
      end),
      i(0),
   })
   return comment_node
end

--- Generate a TODO comment snippet with an automatic description and docstring
---@param context table merged with the generated context table `trig` must be specified
---@param aliases string[]|string of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
---@param opts table merged with the snippet opts table
local todo_snippet = function(context, aliases, opts)
   opts = opts or {}
   aliases = type(aliases) == "string" and { aliases } or aliases -- if we do not have aliases, be smart about the function parameters
   context = context or {}
   if not context.trig then
      return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
   end
   opts.ctype = opts.ctype or 1 -- comment type can be passed in the `opts` table, but if it is not, we have to ensure, it is defined
   local alias_string = table.concat(aliases, "|") -- `choice_node` documentation
   context.name = context.name or (alias_string .. " comment") -- generate the `name` of the snippet if not defined
   context.dscr = context.dscr or (alias_string .. " comment with a signature-mark") -- generate the `dscr` if not defined
   context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {3} <{2:mark}>{0} ") -- generate the `docstring` if not defined
   local comment_node = todo_snippet_nodes(aliases, opts) -- nodes from the previously defined function for their generation
   return s(context, comment_node, opts) -- the final todo-snippet constructed from our parameters
end

local todo_snippet_specs = {
   { { trig = "todo" }, "TODO" },
   { { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
   { { trig = "hack" }, "HACK" },
   { { trig = "warn" }, { "WARN", "WARNING", "XXX" } },
   { { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
   { { trig = "note" }, { "NOTE", "INFO" } },
   -- NOTE: Block commented todo-comments <kunzaatko>
   { { trig = "todob" }, "TODO", { ctype = 2 } },
   { { trig = "fixb" }, { "FIX", "BUG", "ISSUE", "FIXIT" }, { ctype = 2 } },
   { { trig = "hackb" }, "HACK", { ctype = 2 } },
   { { trig = "warnb" }, { "WARN", "WARNING", "XXX" }, { ctype = 2 } },
   { { trig = "perfb" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" }, { ctype = 2 } },
   { { trig = "noteb" }, { "NOTE", "INFO" }, { ctype = 2 } },
}

for _, v in ipairs(todo_snippet_specs) do
   -- NOTE: 3rd argument accepts nil
   table.insert(M, todo_snippet(v[1], v[2], v[3]))
end

return M

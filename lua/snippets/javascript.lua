local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node

local fmt = require("luasnip.extras.fmt").fmt

local same_as = function(idx)
    return f(function(args)
        return args[1]
    end, { idx })
end

local js = {
    s(
        "logvar",
        fmt([[console.log("{}:", {})]], {
            i(1),
            same_as(1),
        })
    ),
}

ls.add_snippets("javascript", js)
ls.add_snippets("typescript", js)
ls.add_snippets("svelte", js)

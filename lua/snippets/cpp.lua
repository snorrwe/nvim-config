local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt

local same_as = function(idx)
    return f(function(args)
        return args[1]
    end, { idx })
end

local c_for = fmt(
    [[for(int {} = 0; {} < {}; ++{}) {{
    {}
}}]],
    {
        i(1),
        same_as(1),
        i(2),
        same_as(1),
        i(3),
    }
)

local range_for = fmt(
    [[for(auto&& {} : {}) {{
    {}
}}]],
    {
        i(1),
        i(2),
        i(3),
    }
)

ls.add_snippets("cpp", {
    s("for", c(1, { c_for, range_for })),
    s(
        "forim",
        fmt(
            [[for(int {} = 0; {} < {}.height{}; ++{}) {{
        for(int {} = 0; {} < {}.width{}; ++{}) {{
            {}
        }}
    }}]],
            {
                i(1),
                same_as(1),
                i(2),
                c(3, { t(""), t("()") }),
                same_as(1),
                i(4),
                same_as(4),
                same_as(2),
                same_as(3),
                same_as(4),
                i(0),
            }
        )
    ),
})

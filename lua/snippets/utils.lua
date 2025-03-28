local M = {}

M.same_as = function(idx)
    local ls = require("luasnip")
    local f = ls.function_node
    return f(function(args)
        return args[1]
    end, { idx })
end

return M

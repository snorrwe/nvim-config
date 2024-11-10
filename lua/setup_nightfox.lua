local M = {}

M.options = {
    transparent = false,
    dim_inactive = true,
    colorblind = {
        enable = true,
        severity = {
            protan = 0.72,
        },
    },
}

M.config = function()
    require("nightfox").setup { M.options }
    vim.cmd([[colorscheme terafox]])
end

M.build = function()
    require("nightfox").setup { M.options }
    require("nightfox").compile()
end

return M

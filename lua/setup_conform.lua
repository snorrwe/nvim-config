return function()
    local conform = require("conform")
    -- Use a sub-list to run only the first available formatter
    local prettier = { { "prettierd", "prettier" } }
    conform.setup({
        formatters_by_ft = {
            -- Specify a list of formatters to run
            lua = { "stylua" },
            python = { "black" },
            rust = { "rustfmt" },
            go = { "gofmt" },
            javascript = prettier,
            typescript = prettier,
            json = prettier,
            html = prettier,
            css = prettier,
            markdown = { "mdformat" },
            proto = { "buf" }
        },
    })
    local formatcmd = function()
        conform.format({ lsp_fallback = "always", timeout_ms = 500 })
    end
    vim.keymap.set({ "n", "v" }, "<leader>a", formatcmd)
end

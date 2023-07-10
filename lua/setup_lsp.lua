local function filterOneInplace(t, func)
    local i = 1
    while (i <= #t) do
        if func(t[i]) then
            i = i + 1
        else
            table.remove(t, i)
            return
        end
    end
end

return function()
    require("mason").setup {}
    local mason_lsp = require("mason-lspconfig")
    mason_lsp.setup {}

    vim.g.coq_settings = {
        auto_start = true,
        ['display.pum.source_context'] = { '[', ']' }
    }

    local nvim_lsp = require 'lspconfig'
    local coq = require 'coq'

    local servers = mason_lsp.get_installed_servers()

    local skip = { 'rust_analyzer', 'clangd' }
    for _, server in ipairs(skip) do
        filterOneInplace(servers, function(s)
            return server == s;
        end)
    end

    for _, lsp in ipairs(servers) do
        local status, retval = pcall(nvim_lsp[lsp].setup, coq.lsp_ensure_capabilities())
        if not status then
            print("lsp setup failed: ", lsp, retval)
        end
    end

    -- manual server setups go here
    --
    require("clangd_extensions").setup {
        server = {
            -- options to pass to nvim-lspconfig
            -- i.e. the arguments to require("lspconfig").clangd.setup({})
            capabilities = coq.lsp_ensure_capabilities()
        },
        -- use the defaults
        extensions = {}
    }
    vim.keymap.set('n', 'gh', "<cmd>ClangdSwitchSourceHeader<cr>")

    local has_native_hints = vim.fn.has("nvim-0.10") == 1;
    local rust_rools = require('rust-tools')
    rust_rools.setup {
        server = {
            capabilities = coq.lsp_ensure_capabilities()
        },
        tools = {
            inlay_hints = {
                auto = not has_native_hints
            }
        }
    }

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = true,
        }
    )

    vim.cmd [[set shortmess-=F]]
    vim.cmd [[set shortmess+=c]]
end

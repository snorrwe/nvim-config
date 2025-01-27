return function()
    local lsp = require("lspconfig")
    local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
    local mason = require("mason")
    local mason_lsp = require("mason-lspconfig")
    local mason_reg = require("mason-registry")
    local clangd_extensions = require("clangd_extensions")

    local function setup_clangd()
        lsp.clangd.setup({
            capabilities = lsp_capabilities,
            filetypes = { "cpp", "c", "h", "hpp", "cuda" },
            cmd = { "clangd", "--background-index", "--log=verbose", "--clang-tidy" },
        })
    end

    mason.setup({})
    mason_lsp.setup({
        ensure_installed = {
            "rust_analyzer",
        },
        handlers = {
            -- default server setup
            function(server_name)
                lsp[server_name].setup({
                    capabilities = lsp_capabilities,
                })
            end,
            -- manually setup these servers
            clangd = function()
                setup_clangd()
            end,
            basedpyright = function()
                lsp.basedpyright.setup({
                    capabilities = lsp_capabilities,
                    settings = {
                        basedpyright = {
                            analysis = {
                                autoSearchPaths = true,
                                diagnosticMode = "openFilesOnly",
                                useLibraryCodeForTypes = true,
                                typeCheckingMode = "standard",
                            },
                        },
                    },
                })
            end,
        },
    })

    -- mason_lsp does not support these servers
    if vim.fn.executable("nginx-language-server") == 1 then
        -- mason_lsp does not support nginx_language_server
        lsp.nginx_language_server.setup({ capabilities = lsp_capabilities })
    end
    lsp.gdscript.setup({
        capabilities = lsp_capabilities,
    })
    if not mason_reg.is_installed("clangd") and vim.fn.executable("clangd") == 1 then
        -- on nixos mason provided clangd does not work as expected with system headers, use the system clangd instead
        setup_clangd()
    end

    local has_native_hints = vim.fn.has("nvim-0.10") == 1
    clangd_extensions.setup({
        extensions = {
            autoSetHints = not has_native_hints,
        },
    })

    local group = vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        pattern = { "*.c", "*.h", "*.hpp", "*.cpp", "*.cu", "*.cuh" },
        group = group,
        callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gh", "<cmd>ClangdSwitchSourceHeader<cr>", opts)
        end,
    })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = group,
        callback = function(ev)
            local telescope = require("telescope.builtin")
            local opts = { buffer = ev.buf }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
            vim.keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<space>s", telescope.lsp_document_symbols, opts)
            vim.keymap.set("n", "<space>S", telescope.lsp_workspace_symbols, opts)
            vim.keymap.set("n", "gr", telescope.lsp_references, opts)
        end,
    })
end

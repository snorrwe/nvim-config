return function()
    local lsp = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
    local mason = require('mason')
    local mason_lsp = require('mason-lspconfig')
    local clangd_extensions = require('clangd_extensions')
    local cmp = require('cmp')

    mason.setup {}
    mason_lsp.setup {
        ensure_installed = {
            'rust_analyzer',
            'clangd',
        },
        handlers = {
            -- default server setup
            function(server_name)
                lsp[server_name].setup {
                    capabilities = lsp_capabilities,
                }
            end
            -- manually setup these servers
            -- rust_analyzer = lsp_zero.noop,
        },
    }

    cmp.setup {
        mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        },
        preselect = cmp.PreselectMode.Item,
        formatting = {
            format = function(_, vim_item)
                vim_item.menu = nil;
                local label = vim_item.abbr
                local truncated_label = vim.fn.strcharpart(label, 0, 100)
                if truncated_label ~= label then
                    vim_item.abbr = truncated_label .. '..'
                end
                return vim_item
            end,
        },
        snippet = {
            expand = function(args)
                require 'luasnip'.lsp_expand(args.body)
            end
        },
        sources = {
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'buffer' },
            { name = 'luasnip' },
        },
    }
    local has_native_hints = vim.fn.has("nvim-0.10") == 1;
    clangd_extensions.setup {
        extensions = {
            autoSetHints = not has_native_hints,
        },
    }

    local group = vim.api.nvim_create_augroup('UserLspConfig', {});
    vim.api.nvim_create_autocmd('LspAttach', {
        pattern = { "*.c", "*.h", "*.hpp", "*.cpp" },
        group = group,
        callback = function(ev)
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gh', "<cmd>ClangdSwitchSourceHeader<cr>", opts)
        end
    })
    vim.api.nvim_create_autocmd('LspAttach', {
        group = group,
        callback = function(ev)
            local telescope = require('telescope.builtin');
            local opts = { buffer = ev.buf }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set({ 'n', 'v' }, 'ga', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>a', function()
                vim.lsp.buf.format { async = true }
            end, opts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
            vim.keymap.set('n', '<space>s', telescope.lsp_document_symbols, opts)
            vim.keymap.set('n', '<space>S', telescope.lsp_workspace_symbols, opts)
            vim.keymap.set('n', 'gr', telescope.lsp_references, opts)
        end
    })
end

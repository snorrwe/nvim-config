return function()
    local lsp = require('lsp-zero')
    local mason = require('mason')
    local mason_lsp = require('mason-lspconfig')
    local clangd_extensions = require('clangd_extensions')
    local rust_rools = require('rust-tools')
    local cmp = require('cmp')

    lsp.preset('recommended')
    mason.setup {}
    mason_lsp.setup {
        ensure_installed = {
            'rust_analyzer',
            'clangd',
        },
        handlers = {
            lsp.default_setup,
            -- manually setup these servers
            rust_analyzer = lsp.noop,
            clangd = lsp.noop,
        },
    }
    lsp.set_preferences({
        suggest_lsp_servers = true,
        set_lsp_keymaps = {
            omit = { '<C-k>', 'gr' },
        }
    })

    local cmp_mappings = lsp.defaults.cmp_mappings {
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
    }
    cmp.setup {
        mapping = cmp_mappings,
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
    }
    lsp.setup()
    local clangd_lsp = lsp.build_options('clangd', {})
    local has_native_hints = vim.fn.has("nvim-0.10") == 1;
    clangd_extensions.setup {
        extensions = {
            autoSetHints = not has_native_hints,
        },
        server = clangd_lsp,
    }
    vim.keymap.set('n', 'gh', "<cmd>ClangdSwitchSourceHeader<cr>")

    local rust_lsp = lsp.build_options('rust_analyzer', {})
    rust_rools.setup {
        server = rust_lsp,
        tools = {
            inlay_hints = {
                auto = not has_native_hints
            }
        }
    }
end

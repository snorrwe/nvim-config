local M = {}

function M.setupLsp()
    require("mason").setup {}
    require("mason-lspconfig").setup {}
    vim.g.coq_settings = {
        auto_start = true
        , ['display.pum.source_context'] = { '[', ']' }
    }

    local nvim_lsp = require 'lspconfig'
    local coq = require 'coq'

    local servers = { 'rust_analyzer', 'gopls', 'zls', 'pyright', 'tsserver', 'svelte' }
    for _, lsp in ipairs(servers) do
        local status, retval = pcall(nvim_lsp[lsp].setup, coq.lsp_ensure_capabilities())
        if not status then
            print("lsp setup failed: ", lsp, retval)
        end
    end

    -- this will registed `clangd` language server
    require("clangd_extensions").setup {
        server = {
            -- options to pass to nvim-lspconfig
            -- i.e. the arguments to require("lspconfig").clangd.setup({})
            capabilities = coq.lsp_ensure_capabilities()
        },
        -- use the defaults
        extensions = {}
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

function M.setupLspSaga()
    local saga = require 'lspsaga'
    saga.init_lsp_saga()

    -- Code navigation shortcuts
    vim.cmd [[nnoremap <c-]> <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>]]
    vim.cmd [[nnoremap go <cmd>Lspsaga show_line_diagnostics<cr>]]
    vim.cmd [[nnoremap g[ <cmd>Lspsaga diagnostic_jump_prev<cr>]]
    vim.cmd [[nnoremap g] <cmd>Lspsaga diagnostic_jump_next<cr>]]
    vim.cmd [[nnoremap K <cmd>Lspsaga hover_doc<cr>]]
    vim.cmd [[nnoremap gD <cmd>lua vim.lsp.buf.implementation()<cr>]]
    vim.cmd [[nnoremap gR <cmd>lua require('lspsaga.rename').rename()<cr>]]
    vim.cmd [[nnoremap gd <cmd>lua require'lspsaga.provider'.preview_definition()<cr>]]
end

function M.setupAutoformat()
    local null_ls = require "null-ls"
    -- check supported formatters
    local formatting = null_ls.builtins.formatting

    null_ls.setup {
        debug = false,
        sources = {
            formatting.rufo,
            formatting.black,
            formatting.prettier,
        }
    }

    vim.cmd [[nnoremap <leader>a <cmd>lua vim.lsp.buf.format()<CR>]]
    vim.cmd [[vnoremap <leader>a <cmd>lua vim.lsp.buf.format()<CR>]]
end

function M.setupTelescope()
    require('telescope').setup {
        defaults = {
            vimgrep_arguments = {
                'rg',
                '--color=never',
                '--no-heading',
                '--with-filename',
                '--line-number',
                '--column',
                '--smart-case'
            }
            , file_ignore_patterns = {}
            , mappings = {
                n = {
                    ["K"] = false,
                    ["<C-k>"] = false,
                    ["ga"] = false,
                }
            }
        }
    }
    vim.cmd [[nnoremap <space>f <cmd>lua require('telescope.builtin').find_files()<cr>]]
    vim.cmd [[nnoremap <space>g <cmd>lua require('telescope.builtin').live_grep()<cr>]]
    vim.cmd [[nnoremap <space>b <cmd>lua require('telescope.builtin').buffers()<cr>]]
    vim.cmd [[nnoremap <space>t <cmd>lua require('telescope.builtin').help_tags()<cr>]]
    vim.cmd [[nnoremap <space>l <cmd>lua require('telescope.builtin').diagnostics()<cr>]]
    vim.cmd [[nnoremap <space>s <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]]
    vim.cmd [[nnoremap <space>S <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]]
    vim.cmd [[nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>]]
    vim.cmd [[nnoremap ga <cmd>lua vim.lsp.buf.code_action()<cr>]]
end

function M.setupTS()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua", "rust", "c", "cpp", "javascript", "typescript", "html", "css" },
        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        autopairs = {
            enable = true
        },
        indent = {
            enable = true
        },
        rainbow = {
            enable = true
        },
        autotag = {
            enable = true
        },
    }
end

function M.setupTree()
    require 'nvim-tree'.setup {
        update_cwd = true,
    }

    vim.cmd [[nnoremap <silent> <leader>n <cmd>NvimTreeToggle<CR>]]
    vim.cmd [[nnoremap <silent> <leader>f <cmd>NvimTreeFindFile<CR>]]
end

function M.setupBufferline()
    require("bufferline").setup {}

    vim.cmd [[nnoremap <silent> <leader>wd <cmd>BufferLineCycleNext<cr>]]
    vim.cmd [[nnoremap <silent> <leader>wa <cmd>BufferLineCyclePrev<cr>]]
end

function M.setupFloaterm()
    vim.cmd [[nnoremap <silent> <leader>tn <cmd>FloatermNew<cr>]]
    vim.cmd [[nnoremap <silent> <leader>tt <cmd>FloatermToggle<cr>]]
    vim.cmd [[command! Vifm FloatermNew vifm]]
    vim.cmd [[command! LazyGit FloatermNew lazygit]]
    vim.cmd [[nnoremap <silent> <F12> <cmd>FloatermToggle<CR>]]
    vim.cmd [[tnoremap <silent> <F12> <C-\><C-n><cmd>FloatermToggle<CR>]]

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>LazyGit<cr>", { silent = true, noremap = true })

    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_keymap_toggle = "<F12>"
end

function M.initialize()
    vim.o.completeopt = "menuone,noselect"
    -- gui
    vim.cmd [[set guifont=CaskaydiaCove\ NF:h12]]
    -- neovide
    vim.g.neovide_cursor_vfx_mode = "railgun"

    -- vim.cmd[[set background=dark]]
    vim.cmd [[syntax on]]

    vim.cmd [[set nocompatible]]
    vim.cmd [[filetype plugin indent on]]
    -- show existing tab with 4 spaces width
    vim.cmd [[set tabstop=4]]
    -- when indenting with '>', use 4 spaces width
    vim.cmd [[set shiftwidth=4]]
    -- On pressing tab, insert 4 spaces
    vim.cmd [[set expandtab]]
    vim.cmd [[set autoread]]
    vim.cmd [[set number]]
    vim.cmd [[set relativenumber]]
    vim.cmd [[set ignorecase]]
    vim.cmd [[set smartcase]]
    vim.cmd [[set list]]

    vim.cmd [[vnoremap // y/<C-R>"<cr>]]
    vim.cmd [[noremap <leader>o <cmd>only<cr>]]

    -- show the next match in the middle of the screen
    vim.cmd [[noremap n nzz]]
    vim.cmd [[noremap N Nzz]]
    vim.cmd [[noremap <leader>] :BufferLineCycleNext<cr>]]
    vim.cmd [[noremap <leader>[ :BufferLineCyclePrev<cr>]]

    vim.cmd [[autocmd User LspProgressUpdate redrawstatus]]
end

return M

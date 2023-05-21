local M = {}

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

    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.format()<CR>')
    vim.keymap.set('v', '<leader>a', '<cmd>lua vim.lsp.buf.format()<CR>')
end

function M.setupTS()
    require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "help", "lua", "rust", "c", "cpp", "javascript", "typescript", "html", "css" },
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
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<leader><space>',
                node_incremental = '=',
                node_decremental = '-',
            },
        },
        textobjects = {
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer'
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer'
                },
                goto_next_end = {
                    [']M'] = '@function.outer'
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer'
                },
            },
        },
    }
end

function M.setupTree()
    local oil = require 'oil'
    oil.setup {}
    vim.keymap.set('n', '<leader>n', oil.open)
end

function M.setupBufferline()
    require("bufferline").setup {}

    vim.keymap.set('n', '<leader>wd', '<cmd>BufferLineCycleNext<cr>')
    vim.keymap.set('n', '<leader>wa', '<cmd>BufferLineCyclePrev<cr>')
end

function M.setupFloaterm()
    vim.keymap.set('n', '<leader>tn', '<cmd>FloatermNew<cr>')
    vim.keymap.set('n', '<leader>tt', '<cmd>FloatermToggle<cr>')
    vim.cmd [[command! Vifm FloatermNew vifm]]
    vim.cmd [[command! LazyGit FloatermNew lazygit]]
    vim.keymap.set('n', '<F12>', '<cmd>FloatermToggle<CR>')
    vim.keymap.set('t', '<F12>', '<C-\\><C-n><cmd>FloatermToggle<CR>')

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>LazyGit<cr>", { silent = true, noremap = true })

    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_keymap_toggle = "<F12>"
end

function M.initialize()
    vim.opt.incsearch = true
    vim.opt.smartindent = true
    vim.o.completeopt = "menuone,noselect"
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

    vim.keymap.set('v', '//', 'y/<C-R>"<cr>')
    vim.cmd [[noremap <leader>o <cmd>only<cr>]]

    -- show the next match in the middle of the screen
    vim.cmd [[noremap n nzz]]
    vim.cmd [[noremap N Nzz]]
    vim.cmd [[noremap <leader>] :BufferLineCycleNext<cr>]]
    vim.cmd [[noremap <leader>[ :BufferLineCyclePrev<cr>]]
    vim.keymap.set('n', 'ga', "<cmd>lua vim.lsp.buf.code_action()<cr>")
    vim.keymap.set('n', '[d', "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    vim.keymap.set('n', ']d', "<cmd>lua vim.diagnostic.goto_next()<cr>")

    vim.cmd [[autocmd User LspProgressUpdate redrawstatus]]

    vim.opt.scrolloff = 8 -- always have at least 8 lines in the bottom when scrolling
    vim.opt.signcolumn = "yes"

    -- move highlightes stuff
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
end

return M

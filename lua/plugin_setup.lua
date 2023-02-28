local M = {}

function M.setupDebugging()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    vim.keymap.set('n', '<F5>', '<cmd>lua require"dap".continue()<CR>');
    vim.keymap.set('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>');
    vim.keymap.set('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>');
    vim.keymap.set('n', '<F9>', '<cmd>lua require"dap".step_out()<CR>');
    vim.keymap.set('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>');
    vim.keymap.set('n', '<leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>');

    dap.adapters.cppdbg = {
        type = 'server',
        port = '${port}',
        executable = {
            command = 'codelldb',
            args = { '--port', '${port}' },
        },
    }

    dap.configurations.cpp = {
        {
            name = 'Launch file',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        {
            name = 'Launch file with args',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            args = function()
                local args = vim.fn.input('Args: ')
                local result = {}
                for arg in string.gmatch(args, "[^%s]+") do
                    table.insert(result, arg)
                end
                return result
            end
        },
        {
            name = 'Launch lpc',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.getcwd() .. '/build/looq_pc'
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            args =
            function()
                local result = {
                    "-p",
                    "~/Downloads/sample_db/sample_db_processed-001/sample_db_processed",
                    "-r",
                    "~/raw",
                }
                return result
            end
        },
    }
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

    vim.keymap.set('n', '<leader>a', '<cmd>lua vim.lsp.buf.format()<CR>')
    vim.keymap.set('v', '<leader>a', '<cmd>lua vim.lsp.buf.format()<CR>')
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
    vim.keymap.set('n', '<space>f', "<cmd>lua require('telescope.builtin').find_files()<cr>")
    vim.keymap.set('n', '<space>g', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
    vim.keymap.set('n', '<space>b', "<cmd>lua require('telescope.builtin').buffers()<cr>")
    vim.keymap.set('n', '<space>t', "<cmd>lua require('telescope.builtin').help_tags()<cr>")
    vim.keymap.set('n', '<space>l', "<cmd>lua require('telescope.builtin').diagnostics()<cr>")
    vim.keymap.set('n', '<space>s', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>")
    vim.keymap.set('n', '<space>S', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>")
    vim.keymap.set('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<cr>")
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
    require 'nvim-tree'.setup {
        update_cwd = true,
    }

    vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
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

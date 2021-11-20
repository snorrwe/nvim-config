local M = {}

function M.setupLsp()
    vim.g.coq_settings = {
        auto_start=true
        , ['display.pum.source_context'] = {'[', ']'}
    }

    local nvim_lsp = require 'lspconfig'
    local coq = require 'coq'


    local servers = { 'rust_analyzer', 'clangd', 'gopls', 'zls', 'pyright', 'tsserver' }
    for _, lsp in ipairs(servers) do
        local status, retval = pcall( nvim_lsp[lsp].setup, coq.lsp_ensure_capabilities() )
        if not status then
            print("lsp setup failed: ", lsp, retval)
        end
    end

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
      }
    )

    -- Enable type inlay hints
    vim.cmd [[ autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * :lua require'lsp_extensions'.inlay_hints{ prefix = '» ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]

    vim.cmd[[set shortmess-=F]]
    vim.cmd[[set shortmess+=c]]
end

function M.setupLspSaga() 
    local saga = require 'lspsaga'
    saga.init_lsp_saga({})

    -- Code navigation shortcuts
    vim.cmd[[nnoremap <c-]> <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>]]
    vim.cmd[[nnoremap g[ <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>]]
    vim.cmd[[nnoremap g] <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>]]
    vim.cmd[[nnoremap K <cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]]
    vim.cmd[[nnoremap gD <cmd>lua vim.lsp.buf.implementation()<cr>]]
    vim.cmd[[nnoremap <C-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]]
    vim.cmd[[nnoremap gR <cmd>lua require('lspsaga.rename').rename()<cr>]]
    vim.cmd[[nnoremap gd <cmd>lua require'lspsaga.provider'.preview_definition()<cr>]]
    vim.cmd[[nnoremap ga <cmd>Telescope lsp_code_actions<cr>]]
end

function M.setupLspKind()
    require('lspkind').init({
        -- enables text annotations
        --
        -- default: true
        with_text = true,

        -- default symbol map
        -- can be either 'default' or
        -- 'codicons' for codicon preset (requires vscode-codicons font installed)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = '',
          Method = 'ƒ',
          Function = '',
          Constructor = '',
          Variable = '',
          Class = '',
          Interface = 'ﰮ',
          Module = '',
          Property = '',
          Unit = '',
          Value = '',
          Enum = '了',
          Keyword = '',
          Snippet = '﬌',
          Color = '',
          File = '',
          Folder = '',
          EnumMember = '',
          Constant = '',
          Struct = ''
        },
    })
end

function setupAutoformat()
    vim.g.formatter_path = {"c:/tools"}
    vim.g.autoformat_autoindent = 0
    vim.g.autoformat_retab = 0
    vim.g.formatters_js = {'prettier'}
    vim.g.formatters_jsx = {'prettier'}
    vim.g.formatters_ts = {'prettier'}
    vim.g.formatters_javascript = {'prettier'}
    vim.g.formatters_typescript = {'prettier'}
    vim.g.formatters_javascriptreact = {'prettier'}
    vim.g.formatters_typescriptreact = {'prettier'}
    vim.g.formatters_html = {'prettier'}
    vim.g.formatters_css = {'prettier'}
    vim.g.formatters_json = {'prettier'}
    vim.g.formatters_toml = {'prettier'}
    vim.g.formatters_md = {'prettier'}
    vim.g.formatters_yaml = {'prettier'}
    vim.g.formatters_svelte = {'prettier'}
    vim.g.formatters_sql = {}
    vim.g.formatters_python = {'black'}
end

function M.setupTelescope()
    require('telescope').setup{
        defaults ={
            vimgrep_arguments= {
              'rg',
              '--color=never',
              '--no-heading',
              '--with-filename',
              '--line-number',
              '--column',
              '--smart-case'
            }
            , file_ignore_patterns = {}
            , layout_strategy = "vertical"
            , mappings = {
                n = {
                    ["K"] = false,
                    ["<C-k>"] = false,
                    ["ga"] = false,
                }
            }
        }
    }
    vim.cmd[[nnoremap <space>f <cmd>lua require('telescope.builtin').find_files()<cr>]]
    vim.cmd[[nnoremap <space>g <cmd>lua require('telescope.builtin').live_grep()<cr>]]
    vim.cmd[[nnoremap <space>b <cmd>lua require('telescope.builtin').buffers()<cr>]]
    vim.cmd[[nnoremap <space>t <cmd>lua require('telescope.builtin').help_tags()<cr>]]
    vim.cmd[[nnoremap <space>l <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]]
    vim.cmd[[nnoremap <space>s <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]]
    vim.cmd[[nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>]]
end

function M.setupDap()
    local dap = require('dap')
    dap.configurations.cpp = {
--      {
--        type = 'lldb',
--        request = 'launch',
--        name = "Launch Air Sample",
--      program = "",
--      runInTerminal = true,
--      },
    }
    dap.adapters.lldb = {
      type = 'executable',
      command = 'lldb-vscode.exe',
      name = "lldb"
    }

    vim.cmd[[nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>]]
    vim.cmd[[nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>]]
    vim.cmd[[nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>]]
    vim.cmd[[nnoremap <silent> <leader>dr :lua require'dap'.continue()<CR>]]
    vim.cmd[[nnoremap <silent> <leader>db :lua require'dap'.toggle_breakpoint()<CR>]]
    vim.cmd[[nnoremap <silent> <leader>dB :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]]
    vim.cmd[[nnoremap <silent> <leader>dp :lua require'dap'.repl.open()<CR>]]
    vim.cmd[[nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>]]
end

function M.setupTS()
    require'nvim-treesitter.configs'.setup {
        -- ensure_installed = "all",
        highlight = {
            enable=true
        }
    }
end

function M.setupBufferline()
    require("bufferline").setup{}

    vim.cmd[[nnoremap <silent> <leader>wd <cmd>BufferLineCycleNext<cr>]]
    vim.cmd[[nnoremap <silent> <leader>wa <cmd>BufferLineCyclePrev<cr>]]
end

function M.initialize()
    local setupFunctions = { setupAutoformat }
    for i, setup in ipairs(setupFunctions) do
        local status, retval = pcall( setup )
        if not status then
            print("Failed to setup:", i, retval)
        end
    end

    vim.o.completeopt = "menuone,noselect"
    -- gui
    vim.cmd[[set guifont=CaskaydiaCove\ NF:h12]]
    -- neovide
    vim.g.neovide_cursor_vfx_mode = "railgun"

    vim.cmd[[set background=dark]]
    vim.cmd[[syntax on]]

    vim.cmd[[set nocompatible]]
    vim.cmd[[filetype plugin indent on]]
    -- show existing tab with 4 spaces width
    vim.cmd[[set tabstop=4]]
    -- when indenting with '>', use 4 spaces width
    vim.cmd[[set shiftwidth=4]]
    -- On pressing tab, insert 4 spaces
    vim.cmd[[set expandtab]]
    vim.cmd[[set autoread]]
    vim.cmd[[set number]]
    vim.cmd[[set relativenumber]]
    vim.cmd[[set ignorecase]]
    vim.cmd[[set smartcase]]
    vim.cmd[[set list]]


    vim.cmd[[vnoremap // y/<C-R>"<cr>]]
    vim.cmd[[noremap <Space> <cmd>noh<cr>]]
    vim.cmd[[noremap <leader>o <cmd>only<cr>]]
    vim.cmd[[noremap <leader>n <cmd>Fern . -drawer -toggle<cr>]]
    vim.cmd[[noremap <leader>f <cmd>FernFindCurrentFile<cr>]]
    vim.cmd[[noremap <leader>a :Autoformat]]

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>LazyGit<cr>", {silent=true, noremap=true})

    -- show the next match in the middle of the screen
    vim.cmd[[noremap n nzz]]
    vim.cmd[[noremap N Nzz]]
    vim.cmd[[noremap <leader>] :BufferLineCycleNext<cr>]]
    vim.cmd[[noremap <leader>[ :BufferLineCyclePrev<cr>]]

end

return M

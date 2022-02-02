local M = {}

function M.setupLsp()
    vim.g.coq_settings = {
        auto_start=true
        , ['display.pum.source_context'] = {'[', ']'}
    }

    local nvim_lsp = require 'lspconfig'
    local cmp = require 'cmp'

require'cmp'.setup {
    sources = {
    }
}
    cmp.setup({
        snippet = {
          expand = function(args)
            require('snippy').expand_snippet(args.body)
          end,
        }
        , sources = cmp.config.sources({
            { name = 'nvim_lsp' }
            , { name = 'snippy' }
            , { name = 'rg' }
        }, {
            { name = 'buffer' },
        })
        , mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }
    })

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = { 'rust_analyzer', 'clangd', 'gopls', 'zls', 'pyright', 'tsserver' }
    for _, lsp in ipairs(servers) do
        local status, retval = pcall( nvim_lsp[lsp].setup, { capabilities = capabilities } )
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
    vim.cmd [[autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost * silent! :lua require'lsp_extensions'.inlay_hints{ prefix = '» ', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} } ]]

    vim.cmd[[set shortmess-=F]]
    vim.cmd[[set shortmess+=c]]
end

function M.setupLspSaga() 
    local saga = require 'lspsaga'
    saga.init_lsp_saga()

    -- Code navigation shortcuts
    vim.cmd[[nnoremap <c-]> <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>]]
    vim.cmd[[nnoremap go <cmd>Lspsaga show_line_diagnostics<cr>]]
    vim.cmd[[nnoremap g[ <cmd>Lspsaga diagnostic_jump_prev<cr>]]
    vim.cmd[[nnoremap g] <cmd>Lspsaga diagnostic_jump_next<cr>]]
    vim.cmd[[nnoremap K <cmd>Lspsaga hover_doc<cr>]]
    vim.cmd[[nnoremap gD <cmd>lua vim.lsp.buf.implementation()<cr>]]
    vim.cmd[[nnoremap gR <cmd>lua require('lspsaga.rename').rename()<cr>]]
    vim.cmd[[nnoremap gd <cmd>lua require'lspsaga.provider'.preview_definition()<cr>]]
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

function M.setupAutoformat()
    vim.cmd[[noremap <leader>a :Neoformat]]

    -- Enable alignment
    vim.g.neoformat_basic_format_align = 1

    -- Enable tab to spaces conversion
    vim.g.neoformat_basic_format_retab = 1

    -- Enable trimmming of trailing whitespace
    vim.g.neoformat_basic_format_trim = 1
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
    vim.cmd[[nnoremap <space>S <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]]
    vim.cmd[[nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>]]
    vim.cmd[[nnoremap ga <cmd>Telescope lsp_code_actions<cr>]]
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

function M.setupTree()
    require'nvim-tree'.setup {
          update_cwd          = true,
          update_to_buf_dir   = {
            enable = true,
            auto_open = true,
          },
    }

    vim.cmd[[nnoremap <silent> <leader>n <cmd>NvimTreeToggle<CR>]]
    vim.cmd[[nnoremap <silent> <leader>f <cmd>NvimTreeFindFile<CR>]]
end

function M.setupBufferline()
    require("bufferline").setup{}

    vim.cmd[[nnoremap <silent> <leader>wd <cmd>BufferLineCycleNext<cr>]]
    vim.cmd[[nnoremap <silent> <leader>wa <cmd>BufferLineCyclePrev<cr>]]
end

function M.setupFloaterm()
    vim.cmd[[nnoremap <silent> <leader>tn <cmd>FloatermNew<cr>]]
    vim.cmd[[nnoremap <silent> <leader>tt <cmd>FloatermToggle<cr>]]
    vim.cmd[[command! Vifm FloatermNew vifm]]
    vim.cmd[[command! LazyGit FloatermNew lazygit]]
    vim.cmd[[nnoremap <silent> <F12> <cmd>FloatermToggle<CR>]]
    vim.cmd[[tnoremap <silent> <F12> <C-\><C-n><cmd>FloatermToggle<CR>]]

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>LazyGit<cr>", {silent=true, noremap=true})

    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_keymap_toggle="<F12>"
end

function M.initialize()
    vim.o.completeopt = "menuone,noselect"
    -- gui
    vim.cmd[[set guifont=CaskaydiaCove\ NF:h12]]
    -- neovide
    vim.g.neovide_cursor_vfx_mode = "railgun"

    -- vim.cmd[[set background=dark]]
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

    -- show the next match in the middle of the screen
    vim.cmd[[noremap n nzz]]
    vim.cmd[[noremap N Nzz]]
    vim.cmd[[noremap <leader>] :BufferLineCycleNext<cr>]]
    vim.cmd[[noremap <leader>[ :BufferLineCyclePrev<cr>]]

    vim.cmd[[autocmd User LspProgressUpdate redrawstatus]]
end

return M

local api = vim.api


local M = {}

function setupLsp()
    local lsp = require 'lspconfig'
    local saga = require 'lspsaga'

    saga.init_lsp_saga({})

    local status, retval = pcall( lsp.rust_analyzer.setup, {} )
    if not status then
        print("lsp.rust_analyzer.setup failed: ", retval)
    end
    local status, retval = pcall( lsp.clangd.setup, {} )
    if not status then 
        print("lsp.clangd.setup failed: ", retval)
    end
    local status, retval = pcall( lsp.gopls.setup, {} )
    if not status then 
        print("lsp.gopls.setup  failed: ", retval)
    end
    local status, retval = pcall( lsp.zls.setup, {} )
    if not status then 
        print("lsp.zls.setup  failed: ", retval)
    end
    local status, retval = pcall( lsp.pyright.setup, {} )
    if not status then 
        print("lsp.pyright.setup  failed: ", retval)
    end

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
      }
    )

    -- Code navigation shortcuts
    vim.cmd[[nnoremap <c-]> <cmd>lua require'lspsaga.provider'.lsp_finder()<cr>]]
    vim.cmd[[nnoremap g[ <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<cr>]]
    vim.cmd[[nnoremap g] <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<cr>]]
    vim.cmd[[nnoremap K <cmd>lua require('lspsaga.hover').render_hover_doc()<cr>]]
    vim.cmd[[nnoremap gD <cmd>lua vim.lsp.buf.implementation()<cr>]]
    vim.cmd[[nnoremap <C-k> <cmd>lua require('lspsaga.signaturehelp').signature_help()<cr>]]
    vim.cmd[[nnoremap gR <cmd>lua require('lspsaga.rename').rename()<cr>]]
    vim.cmd[[nnoremap gd <cmd>lua require'lspsaga.provider'.preview_definition()<cr>]]
    vim.cmd[[nnoremap ga <cmd>lua require('lspsaga.codeaction').code_action()<cr>]]

    vim.cmd[[set updatetime=300]]

    -- Show diagnostic popup on cursor hold
    vim.cmd[[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]

    -- Enable type inlay hints
    vim.cmd[[
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
    \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }]]

    vim.cmd[[set shortmess-=F]]
    vim.cmd[[set shortmess+=c]]

    -- lsp-trouble
    require("trouble").setup { }
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>LspTroubleToggle<cr>", {silent=true, noremap=true})

    -- lsp-kind
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

function setupCompe()
    vim.o.completeopt = "menuone,noselect"

    require'compe'.setup {
      enabled = true;
      autocomplete = true;
      debug = false;
      min_length = 1;
      preselect = 'enable';
      throttle_time = 120;
      source_timeout = 200;
      resolve_timeout = 800;
      incomplete_delay = 400;
      max_abbr_width = 150;
      max_kind_width = 150;
      max_menu_width = 150;
      documentation = {
        border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
      };

      source = {
        path = true;
        buffer = true;
        calc = true;
        omni = false,
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
        ultisnips = false;
        luasnip = false;
      };
    }

    vim.cmd[[inoremap <silent><expr> <C-Space> compe#complete()]]
    vim.cmd[[inoremap <silent><expr> <cr> compe#confirm('<cr>')]]
    vim.cmd[[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
end

function setupTelescope()
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
            , mappings = {
                n = {
                    ["K"] = false,
                    ["<C-k>"] = false,
                    ["ga"] = false,
                }
            }
        }
    }

    vim.cmd[[nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>]]
    vim.cmd[[nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>]]
    vim.cmd[[nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>]]
    vim.cmd[[nnoremap <leader>ft <cmd>lua require('telescope.builtin').help_tags()<cr>]]
    vim.cmd[[nnoremap <leader>fl <cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>]]
    vim.cmd[[nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>]]
end

function M.initialize()

    local status,retval = pcall( setupLsp )
    if not status then
        print("Failed to setup LSP", retval)
    end
    local status,retval = pcall( setupAutoformat )
    if not status then
        print("Failed to init Autoformat", retval)
    end
    local status,retval = pcall( setupCompe )
    if not status then
        print("Failed to init compe", retval)
    end
    local status,retval = pcall( setupTelescope )
    if not status then
        print("Failed to init telescope", retval)
    end
    vim.cmd[[colorscheme neon]]
    vim.g.neon_style = 'doom'
    vim.g.neon_bold = true

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

    vim.cmd[[vnoremap // y/<C-R>"<cr>]]
    vim.cmd[[noremap <Space> <cmd>noh<cr>]]
    vim.cmd[[noremap <leader>o <cmd>only<cr>]]
    vim.cmd[[noremap <leader>n <cmd>Fern . -drawer -toggle<cr>]]
    vim.cmd[[noremap <leader>f <cmd>FernFindCurrentFile<cr>]]
    vim.cmd[[noremap <leader>a :Autoformat]]

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Git<cr>", {silent=true, noremap=true})

    -- show the next match in the middle of the screen
    vim.cmd[[noremap n nzz]]
    vim.cmd[[noremap N Nzz]]
    vim.cmd[[noremap <leader>] :BufferLineCycleNext<cr>]]
    vim.cmd[[noremap <leader>[ :BufferLineCyclePrev<cr>]]

end

return M

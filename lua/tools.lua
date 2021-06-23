local api = vim.api


local M = {}

function setupBufferLine()
    require('bufferline').setup({})
end

function setupLsp()
    local lsp = require 'lspconfig'
    local saga = require 'lspsaga'

    saga.init_lsp_saga({})
    lsp.rust_analyzer.setup({})
    lsp.clangd.setup({})
    lsp.pyls.setup({})
    lsp.gopls.setup({})
    -- lsp.tsserver.setup({})
    lsp.zls.setup({})

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
      }
    )

    -- Code navigation shortcuts
    vim.api.nvim_set_keymap("n", "<c-]>", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "g[", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "g]", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "<C-k>", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "gR", "<cmd>lua require('lspsaga.rename').rename()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "gd", "<cmd>lua require'lspsaga.provider'.preview_definition()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("n", "ga", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>",{silent=true,noremap=true})
    vim.api.nvim_set_keymap("v", "ga", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>",{silent=true,noremap=true})

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
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>LspTroubleToggle<CR>", {silent=true, noremap=true})

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

function initAutoformat()
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

function initCompe()
    vim.o.completeopt="menuone,noselect"
    require'compe'.setup {
      enabled = true;
      autocomplete = true;
      debug = false;
      min_length = 1;
      preselect = 'enable';
      throttle_time = 80;
      source_timeout = 200;
      incomplete_delay = 400;
      max_abbr_width = 100;
      max_kind_width = 100;
      max_menu_width = 100;
      documentation = true;

      source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
      };
    }

    vim.cmd[[inoremap <silent><expr> <C-Space> compe#complete()]]
    vim.cmd[[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
    vim.cmd[[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
end

function M.initialize()

    if not pcall( setupLsp ) then
        print("Failed to setup LSP")
    end
    if not pcall( initAutoformat ) then
        print("Failed to init Autoformat")
    end
    if not pcall( initCompe ) then
        print("Failed to init compe")
    end
    if not pcall( setupBufferLine ) then
        print("Failed to init bufferline")
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

    vim.cmd[[vnoremap // y/<C-R>"<CR>]]
    vim.cmd[[noremap <Space> <cmd>noh<CR>]]
    vim.cmd[[noremap <leader>o <cmd>only<CR>]]
    vim.cmd[[noremap <leader>n <cmd>Fern . -drawer -toggle<CR>]]
    vim.cmd[[noremap <leader>f <cmd>FernFindCurrentFile<CR>]]
    vim.cmd[[noremap <leader>a :Autoformat]]
    -- fzf
    --
    vim.cmd[[nnoremap <C-p> :Files<Cr>]]

    vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>Git<CR>", {silent=true, noremap=true})

    -- show the next match in the middle of the screen
    vim.cmd[[noremap n nzz]]
    vim.cmd[[noremap N Nzz]]

end

return M

local api = vim.api


local M = {}

function setupLsp()
    local lsp = require'lspconfig'

    -- function to attach completion when setting up lsp
    local on_attach = function(client)
        require'completion'.on_attach(client)
    end

    lsp.rust_analyzer.setup({on_attach=on_attach})
    lsp.clangd.setup({on_attach=on_attach})
    lsp.pyls.setup({on_attach=on_attach})
    lsp.gopls.setup({on_attach=on_attach})
    lsp.tsserver.setup({on_attach=on_attach})

    -- Enable diagnostics
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        update_in_insert = true,
      }
    )

    -- Code navigation shortcuts
    vim.cmd[[nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>]]
    vim.cmd[[nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>]]
    vim.cmd[[nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>]]
    vim.cmd[[nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>]]
    vim.cmd[[nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>]]
    vim.cmd[[nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>]]
    vim.cmd[[nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>]]
    vim.cmd[[nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>]]
    vim.cmd[[nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>]]
    vim.cmd[[nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>]]
    vim.cmd[[nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>]]

    vim.cmd[[set updatetime=800]]

    -- Show diagnostic popup on cursor hold
    vim.cmd[[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]

    -- Goto previous/next diagnostic warning/error
    vim.cmd[[nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>]]
    vim.cmd[[nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>]]

    -- Enable type inlay hints
    vim.cmd[[
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
    \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }]]

    vim.cmd[[set shortmess-=F]]
    vim.cmd[[set shortmess+=c]]

    vim.cmd[[set completeopt=menuone,noinsert,noselect]]

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

function initTokyonight()
    vim.g.tokyonight_style="night"
    vim.g.tokyonight_sidebars = { "quickfix", "__vista__", "terminal" }
end

function M.initialize()
    vim.cmd[[set background=dark]]
    vim.cmd[[colorscheme tokyonight]]
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
    vim.cmd[[noremap <Space> :noh<CR>]]
    vim.cmd[[noremap <A-o> :only<CR>]]
    vim.cmd[[noremap <A-n> :Fern . -drawer -toggle<CR>]]
    vim.cmd[[noremap <A-f> :FernFindCurrentFile<CR>]]
    vim.cmd[[noremap <leader>a :Autoformat]]
    vim.cmd[[noremap <leader>r :LSClient]]

    -- show the next match in the middle of the screen
    vim.cmd[[noremap n nzz]]
    vim.cmd[[noremap N Nzz]]

    setupLsp()
    initAutoformat()
    initTokyonight()
end

return M

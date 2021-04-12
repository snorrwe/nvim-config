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

end

function M.initialize()
    api.nvim_command('set background=dark')
    api.nvim_command('colorscheme frenetiq')
    api.nvim_command('syntax on')

    api.nvim_command('set nocompatible')
    api.nvim_command('filetype plugin indent on')
    -- show existing tab with 4 spaces width
    api.nvim_command('set tabstop=4')
    -- when indenting with '>', use 4 spaces width
    api.nvim_command('set shiftwidth=4')
    -- On pressing tab, insert 4 spaces
    api.nvim_command('set expandtab')
    api.nvim_command('set autoread')
    api.nvim_command('set number')
    api.nvim_command('set relativenumber')
    api.nvim_command('set ignorecase')
    api.nvim_command('set smartcase')

    api.nvim_command('vnoremap // y/<C-R>"<CR>')
    api.nvim_command('noremap <Space> :noh<CR>')
    api.nvim_command('noremap <A-o> :only<CR>')
    api.nvim_command('noremap <A-n> :Fern . -drawer -toggle<CR>')
    api.nvim_command('noremap <A-f> :FernFindCurrentFile<CR>')
    api.nvim_command('noremap <leader>a :Autoformat')
    api.nvim_command('noremap <leader>r :LSClient')

    -- show the next match in the middle of the screen
    api.nvim_command('noremap n nzz')
    api.nvim_command('noremap N Nzz')

    setupLsp()
end

return M

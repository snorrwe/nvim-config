local M = {}

function M.setupTree()
    require 'nvim-tree'.setup {
        update_cwd = true,
    }

    vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')
    vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
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

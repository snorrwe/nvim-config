local HOME = vim.env.HOME .. "/.config/nvim"

vim.o.termguicolors = true
vim.g.mapleader = ","
vim.g.python3_host_prog = HOME .. "/python3/bin/python"

-- bootstrap lazy
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.opt.incsearch = true
vim.opt.smartindent = true
vim.o.completeopt = "menuone,noselect"

vim.cmd([[set nocompatible]])
vim.cmd([[filetype plugin indent on]])
-- show existing tab with 4 spaces width
vim.cmd([[set tabstop=4]])
-- when indenting with '>', use 4 spaces width
vim.cmd([[set shiftwidth=4]])
-- On pressing tab, insert 4 spaces
vim.cmd([[set expandtab]])
vim.opt.autoread = true

vim.cmd([[set number]])
vim.cmd([[set relativenumber]])
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])
vim.cmd([[set list]])

vim.keymap.set("v", "//", 'y/<C-R>"<cr>')
vim.cmd([[noremap <leader>o <cmd>only<cr>]])

-- show the next match in the middle of the screen
vim.cmd([[noremap n nzz]])
vim.cmd([[noremap N Nzz]])
vim.cmd([[noremap <leader>] :BufferLineCycleNext<cr>]])
vim.cmd([[noremap <leader>[ :BufferLineCyclePrev<cr>]])
vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")

vim.cmd([[autocmd User LspProgressUpdate redrawstatus]])

vim.opt.scrolloff = 8 -- always have at least 8 lines in the bottom when scrolling
vim.opt.signcolumn = "yes"

-- move highlightes stuff
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- wgsl
local wgsl_group = vim.api.nvim_create_augroup("wgsl", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.wgsl" },
    group = wgsl_group,
    command = "set ft=wgsl",
})
-- templ
local templ_group = vim.api.nvim_create_augroup("templ", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.templ" },
    group = templ_group,
    command = "set ft=templ",
})

if vim.fn.has("nvim-0.10") == 1 then
    -- enable inlay hints on lsp attach
    vim.api.nvim_create_augroup("LspAttach_inlayhints", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint(bufnr, true)
            end
        end,
    })
end

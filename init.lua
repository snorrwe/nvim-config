local HOME = vim.env.HOME .. '/.config/nvim'

vim.o.termguicolors = true
vim.g.mapleader = ','
vim.g.python3_host_prog = HOME .. '/python3/bin/python'

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
-- FIXME: split plugin_setup to different modules
require 'plugin_setup'.initialize()

-- NERDcommenter
vim.g.NERDSpaceDelims = 1

-- Use compact syntax for prettified multi-line comments
vim.g.NERDCompactSexyComs = 1

-- Align line-wise comment delimiters flush left instead of following code indentation
vim.g.NERDDefaultAlign = 'left'

-- Allow commenting and inverting empty lines (useful when commenting a region)
vim.g.NERDCommentEmptyLines = 1

-- Enable trimming of trailing whitespace when uncommenting
vim.g.NERDTrimTrailingWhitespace = 1


-- wgsl
local wgsl_group = vim.api.nvim_create_augroup("wgsl", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.wgsl" },
    group = wgsl_group,
    command = "set ft=wgsl"
})

local HOME = vim.env.HOME .. '/.config/nvim'
local fn = vim.fn

vim.o.termguicolors = true
vim.g.mapleader = ','
vim.g.python3_host_prog = HOME .. '/python3/bin/python'

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth=1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('plugins')
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

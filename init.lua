local HOME = vim.env.HOME .. '/AppData/Local/nvim'
local fn = vim.fn

vim.o.termguicolors = true;
vim.g.mapleader = ','
vim.g.python3_host_prog = HOME .. '/python3/Scripts/python.exe'

local install_path = fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path})
end

vim.cmd 'packadd paq-nvim'
local paq = require('paq-nvim').paq
paq{'savq/paq-nvim', opt=true}

function packages()
    paq { 'luochen1990/rainbow' }
    paq { 'ryanoasis/vim-devicons' }
    paq { 'sheerun/vim-polyglot' }
    paq { 'Shougo/vimproc.vim' }
    paq { 'tpope/vim-fugitive' }
    paq { 'scrooloose/nerdcommenter' }
    paq { 'psliwka/vim-smoothie' }
    paq { 'vifm/vifm.vim' }
    paq { 'gko/vim-coloresque' }
    paq { 'lambdalisue/fern.vim' }
    paq { 'Chiel92/vim-autoformat' }
    paq { 'neovim/nvim-lspconfig' }
    paq { 'glepnir/lspsaga.nvim' }
    paq { 'tjdevries/lsp_extensions.nvim' }
    paq { 'kyazdani42/nvim-web-devicons' }
    paq { 'folke/lsp-trouble.nvim' }
    paq { 'hrsh7th/nvim-compe' }
    paq { 'onsails/lspkind-nvim' }
    paq { 'tpope/vim-rhubarb' } -- github plugin
    paq { 'nvim-lua/popup.nvim' }
    paq { 'nvim-lua/plenary.nvim' }
    paq { 'nvim-telescope/telescope.nvim' }
    paq { 'glepnir/galaxyline.nvim' }
    paq { 'Avimitin/nerd-galaxyline' }
    paq { 'Pocco81/Catppuccino.nvim' }
end

local status, res = pcall(packages, {})
if not status then
    print("Failed to set up packages", res)
end


vim.cmd[[
autocmd BufRead,BufNewFile *.frag set filetype=glsl
autocmd BufRead,BufNewFile *.mm set filetype=objcpp
]]

function setupNERDcommenter()
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
end

setupNERDcommenter()

-- Custom, legacy functions
--
vim.cmd[[
if !exists("*DeleteHiddenBuffers") " Clear all hidden buffers when running
	function DeleteHiddenBuffers() " Vim with the 'hidden' option
		let tpbl=[]
		call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
		for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
			silent execute 'bwipeout!' buf
		endfor
	endfunction
endif
command! DeleteHiddenBuffers call DeleteHiddenBuffers()

if !exists("*FernFindCurrentFile")
	function FernFindCurrentFile() " Vim with the 'hidden' option
        let current=expand('%:p:h')
        silent execute 'Fern ' current ' -drawer'
	endfunction
endif
command! FernFindCurrentFile call FernFindCurrentFile()

if !exists("*ChangeCwdHere")
	function ChangeCwdHere() " Vim with the 'hidden' option
        let current=expand('%:p:h')
        silent execute 'chdir ' current
	endfunction
endif
command! ChangeCwdHere call ChangeCwdHere()
]]

require'plugin_setup'.initialize()


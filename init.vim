" REQUIRES nvim 0.5+ !!!
"
let HOME = 'C:/Users/dkiss/AppData/Local/nvim'

set termguicolors

let g:python3_host_prog = HOME . '/python3/Scripts/python.exe'
let g:mapleader = ','

call plug#begin('~/.vim/plugged')
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/vifm/vifm.vim.git'
Plug 'gko/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'lambdalisue/fern.vim'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

" github plugin
Plug 'https://github.com/tpope/vim-rhubarb'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

Plug 'folke/tokyonight.nvim'
call plug#end()

lua << EOF
require'tools'.initialize()
EOF

" Some nonsense :)
let g:neovide_cursor_vfx_mode = "railgun"

" fzf
"
nnoremap <C-P> :Files<CR>

" NERDcommenter
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

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

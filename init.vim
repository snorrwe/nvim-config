" REQUIRES nvim 0.5+ !!!
"
let HOME = 'C:/Users/dkiss/AppData/Local/nvim/'

set termguicolors

let g:python3_host_prog = HOME . 'python3/Scripts/python.exe'
let g:mapleader = ','

call plug#begin('~/.vim/plugged')
Plug 'luochen1990/rainbow'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/itchyny/lightline.vim.git'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'segeljakt/vim-silicon'
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/vifm/vifm.vim.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'gko/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'lambdalisue/fern.vim'
Plug 'https://github.com/natebosch/vim-lsc.git'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
call plug#end()

syntax on
set background=dark
colorscheme frenetiq

" Some nonsense :)
let g:neovide_cursor_vfx_mode = "railgun"

" VimTex

let g:vimtex_compiler_progname = 'nvr'

set nocompatible
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoread
set number
set relativenumber
set ignorecase
set smartcase

vnoremap // y/<C-R>"<CR>
noremap <C-T> :CtrlPTag<CR>
noremap <Space> :noh<CR>
noremap <A-o> :only<CR>
noremap <A-n> :Fern . -drawer -toggle<CR>
noremap <A-f> :FernFindCurrentFile<CR>
noremap <leader>a :Autoformat 

" ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))|(node_modules|target|build)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Go to last file(s) if invoked without arguments.
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
            \ call mkdir($HOME . "/.vim") |
            \ endif |
            \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
            \ execute "source " . $HOME . "/.vim/Session.vim"

" NERDcommenter
filetype plugin on
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
			silent execute 'bwipeout' buf
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


" lsp client
"
let g:lsc_server_commands = {
            \ 'cpp': 'clangd'
            \, 'rust': 'rust-analyzer'
            \}
let g:lsc_auto_map = {
    \ 'defaults': v:true,
    \ 'PreviousReference': '',
    \}

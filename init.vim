let HOME = 'C:/Users/Daniel Kiss/AppData/Local/nvim'

if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
endif

let g:python3_host_prog = HOME . 'python3/Scripts/python.exe'
let g:mapleader = ','

call plug#begin('~/.vim/plugged')
Plug 'skbolton/embark'
Plug 'hardcoreplayers/spaceline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
Plug 'segeljakt/vim-silicon'
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/vifm/vifm.vim.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'gko/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'lambdalisue/fern.vim'
call plug#end()

syntax on
set background=dark
colorscheme embark

" Some nonsense :)
let g:neovide_cursor_vfx_mode = "railgun"

" VimTex

let g:vimtex_compiler_progname = 'nvr'

" CoC
"
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
map <C-T> :CtrlPTag<CR>
map <Space> :noh<CR>
map <F12> :ALEGoToDefinition<CR>
map <A-l> :ClangFormat<CR>
map <A-t> :ALEFix prettier<CR>
map <A-o> :only<CR>
map <A-j> :ALENext<CR>
map <A-n> :Fern . -drawer -toggle<CR>
map <leader>a :ALEFix<space>

" ctrlp
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Go to last file(s) if invoked without arguments.
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
            \ call mkdir($HOME . "/.vim") |
            \ endif |
            \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
            \ execute "source " . $HOME . "/.vim/Session.vim"

" ALE
let g:ale_completion_enabled = 0
let g:ale_lint_on_save = 1
let g:ale_set_balloons = 1
let g:ale_set_highlights = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_linter_aliases = {'markdown': ['markdown', 'text'] }
let g:ale_fixers = {'javascriptreact': ['prettier'], 'cpp': ['clang-format'], 'rust': ['rustfmt']}

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

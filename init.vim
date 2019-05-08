
let HOME = 'C:/Users/Frenetiq/AppData/Local/nvim/'
let LLVM = 'C:/Program Files(x86)/LLVM/bin'

set encoding=utf-8

if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
endif

let g:python3_host_prog = HOME . 'python3/Scripts/python.exe'
let g:mapleader = '-'

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-rhubarb.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'mindriot101/vim-yapf'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'rust-lang/rust.vim'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git' 
Plug 'https://github.com/rhysd/vim-clang-format.git'
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'w0rp/ale'
Plug 'lervag/vimtex'
call plug#end()

syntax on
set background=dark
colorscheme gruvbox

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
let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = ['branch', 'hunks', 'coc']

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoread
set number

vnoremap // y/<C-R>"<CR>
map <C-T> :CtrlPTag<CR>
map <Space> :noh<CR>
map <F12> :ALEGoToDefinition<CR>
map <A-k> :Autoformat<CR>
map <A-l> :ClangFormat<CR>
map <A-n> :NERDTreeToggle<CR>
map <A-f> :NERDTreeFind<CR>
map <A-t> :ALEFix prettier<CR>
map <A-o> :only<CR>

" ctrlp
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Go to last file(s) if invoked without arguments.
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
            \ call mkdir($HOME . "/.vim") |
            \ endif |
            \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
            \ execute "source " . $HOME . "/.vim/Session.vim"

" Pymode
let g:pymode_python = 'python3'
let g:pymode_folding = 0
let g:pymode_syntax_slow_sync = 0
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = ["E501"]

" ALE	
let g:ale_completion_enabled = 0	
let g:ale_lint_on_save = 1	
let g:ale_set_balloons = 1	
let g:ale_set_highlights = 1	
let g:ale_set_loclist = 0	
let g:ale_set_quickfix = 1

" NERDcommenter
filetype plugin on
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Disable the red line
let g:pymode_options_colorcolumn = 0

" Vimade
let g:vimade = {}
let g:vimade.fadelevel = 0.7

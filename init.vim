
let HOME = 'C:/Users/Frenetiq.DESKTOP-9QE7I3Q/AppData/Local/nvim/'
let LLVM = 'C:/Program Files/LLVM/lib'

set encoding=utf-8

if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
endif

let g:python3_host_prog = HOME . 'python3/Scripts/python.exe'
let g:mapleader = '-'

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
" Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-rhubarb.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git'
Plug 'mindriot101/vim-yapf'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'arithran/vim-delete-hidden-buffers'
Plug 'rust-lang/rust.vim'
call plug#end()

syntax on
colorscheme onedark

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

" YouCompleteMe
let g:ycm_add_preview_to_completeopt = 0

" Autoformat
" au BufWrite * :Autoformat
map <A-k> :Autoformat<CR>

" NERDTree
map <A-n> :NERDTreeToggle<CR>
map <A-f> :NERDTreeFind<CR>

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
let g:pymode_rope = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
let g:pymode_lint_ignore = ["E501"]

" NERDcommenter
filetype plugin on
" map <c-c> :NERDComInvertComment<CR>
" Add spaces after comment delimiters by default
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


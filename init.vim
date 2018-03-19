set encoding=utf-8
if has('nvim-0.1.5')        " True color in neovim wasn't added until 0.1.5
    set termguicolors
endif

let g:python3_host_prog='C:/Users/Frenetiq.DESKTOP-9QE7I3Q/AppData/Local/nvim/python3/Scripts/python.exe'

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/joshdick/onedark.vim.git'
Plug 'vim-airline/vim-airline'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/Valloric/YouCompleteMe.git'
call plug#end()

syntax on
colorscheme onedark

set expandtab ts=4 sw=4 ai
set autoread

" Autoformat

" au BufWrite * :Autoformat
map <A-k> :Autoformat<CR>

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <C-n> :NERDTreeToggle<CR>

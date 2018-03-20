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
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-rhubarb.git'
Plug 'https://github.com/vhdirk/vim-cmake.git'
call plug#end()

syntax on
colorscheme onedark

set expandtab ts=4 sw=4 ai
set autoread

" Autoformat
" au BufWrite * :Autoformat
map <A-k> :Autoformat<CR>

" NERDTree
map <A-n> :NERDTreeToggle<CR>

"ctrlp
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" Go to last file(s) if invoked without arguments.
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
    \ call mkdir($HOME . "/.vim") |
    \ endif |
    \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
    \ execute "source " . $HOME . "/.vim/Session.vim"

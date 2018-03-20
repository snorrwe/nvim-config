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

" Go to last file if invoked without arguments.
autocmd VimEnter * nested if
  \ argc() == 0 &&
  \ bufname("%") == "" &&
  \ bufname("2" + 0) != "" |
  \   exe "normal! `0" |
  \ endif
" Open last active file(s) if VIM is invoked without arguments.
autocmd VimLeave * nested let buffernr = bufnr("$") |
    \ let buflist = [] |
    \ while buffernr > 0 |
    \	if buflisted(buffernr) |
    \	    let buflist += [ bufname(buffernr) ] |
    \	endif |
    \   let buffernr -= 1 |
    \ endwhile |
    \ if (!isdirectory($HOME . "/.vim")) |
    \	call mkdir($HOME . "/.vim") |
    \ endif |
    \ call writefile(reverse(buflist), $HOME . "/.vim/buflist.txt")

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/buflist.txt") |
    \	for line in readfile($HOME . "/.vim/buflist.txt") |
    \	    if filereadable(line) |
    \		execute "tabedit " . line |
    \		set bufhidden=delete |
    \	    endif |
    \	endfor |
    \	tabclose 1 |
    \ endif

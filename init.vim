" REQUIRES nvim 0.5+ !!!
"
let HOME = 'C:/Users/dkiss/AppData/Local/nvim/'

set termguicolors

let g:python3_host_prog = HOME . 'python3/Scripts/python.exe'
let g:mapleader = ','

call plug#begin('~/.vim/plugged')
Plug 'chuling/ci_dark'
Plug 'luochen1990/rainbow'
Plug 'hardcoreplayers/spaceline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/Shougo/vimproc.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'w0rp/ale'
Plug 'segeljakt/vim-silicon'
Plug 'psliwka/vim-smoothie'
Plug 'https://github.com/vifm/vifm.vim.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'gko/vim-coloresque'
Plug 'altercation/vim-colors-solarized'
Plug 'lambdalisue/fern.vim'
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'
" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'
" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'
" Diagnostic navigation and settings for built-in LSP
Plug 'nvim-lua/diagnostic-nvim'
call plug#end()

syntax on
set background=dark
colorscheme ci_dark

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
map <C-T> :CtrlPTag<CR>
map <Space> :noh<CR>
map <A-l> :ClangFormat<CR>
map <A-t> :ALEFix prettier<CR>
map <A-o> :only<CR>
map <A-j> :ALENext<CR>
map <A-n> :Fern . -drawer -toggle<CR>
map <A-f> :FernFindCurrentFile<CR>
map <leader>a :ALEFix<space>

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

autocmd FileType cpp let b:coc_suggest_disable = 1
autocmd FileType rust let b:coc_suggest_disable = 1

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
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_linter_aliases = {'markdown': ['markdown', 'text'] }
let g:ale_fixers = {
      \  "html": ["prettier"]
      \, "css": ["prettier"]
      \, "javascript": ["prettier"]
      \, "javascriptreact": ["prettier"]
      \, "cpp": ["clang-format"]
      \ }

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


" nvim lsp
"
" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'nvim_lsp'

-- function to attach completion and diagnostics
-- when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable lsps
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })
nvim_lsp.clangd.setup({ on_attach=on_attach })

EOF

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>PrevDiagnosticCycle<cr>
nnoremap <silent> g] <cmd>NextDiagnosticCycle<cr>

set signcolumn=yes

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }

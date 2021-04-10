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
Plug 'neovim/nvim-lspconfig'
Plug 'https://github.com/Chiel92/vim-autoformat.git'
Plug 'tjdevries/lsp_extensions.nvim'
Plug 'nvim-lua/completion-nvim'

Plug 'hoob3rt/lualine.nvim'

Plug 'junegunn/fzf', {'do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'
call plug#end()

lua << EOF
require'tools'.initialize()
EOF

" Some nonsense :)
let g:neovide_cursor_vfx_mode = "railgun"

" fzf
"
nnoremap <C-P> :Files<CR>

" autoformat
"
let g:formatter_path = ["c:/tools"]
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:formatters_js = ['prettier']
let g:formatters_jsx = ['prettier']
let g:formatters_ts = ['prettier']
let g:formatters_javascript = ['prettier']
let g:formatters_typescript = ['prettier']
let g:formatters_javascriptreact = ['prettier']
let g:formatters_typescriptreact = ['prettier']
let g:formatters_html = ['prettier']
let g:formatters_css = ['prettier']
let g:formatters_json = ['prettier']
let g:formatters_toml = ['prettier']
let g:formatters_md = ['prettier']
let g:formatters_yaml = ['prettier']
let g:formatters_svelte = ['prettier']
let g:formatters_sql = []
let g:formatters_python = ['black']

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


" lsp
"
set shortmess-=F
set shortmess+=c

set completeopt=menuone,noinsert,noselect

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 800ms of no cursor movement to trigger CursorHold
set updatetime=800
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }





" lualine
"
let g:lualine = {
    \'options' : {
    \  'theme' : 'gruvbox',
    \  'section_separators' : ['', ''],
    \  'component_separators' : ['', ''],
    \  'icons_enabled' : v:true,
    \},
    \'sections' : {
    \  'lualine_a' : [ ['mode', {'upper': v:true,},], ],
    \  'lualine_b' : [ ['branch', {'icon': '',}, ], ],
    \  'lualine_c' : [ ['filename', {'file_status': v:true,},], ],
    \  'lualine_x' : [ 'encoding', 'fileformat', 'filetype' ],
    \  'lualine_y' : [ 'progress' ],
    \  'lualine_z' : [ 'location'  ],
    \},
    \'inactive_sections' : {
    \  'lualine_a' : [  ],
    \  'lualine_b' : [  ],
    \  'lualine_c' : [ 'filename' ],
    \  'lualine_x' : [ 'location' ],
    \  'lualine_y' : [  ],
    \  'lualine_z' : [  ],
    \},
    \'extensions' : [ 'fzf' ],
    \}
lua require("lualine").setup()

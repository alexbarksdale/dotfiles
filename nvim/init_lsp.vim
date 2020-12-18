" -----------------------------------------------------------------------------
" - Plugins -
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" LSP 
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

" Neovim tree sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" FZF (fuzzy searching)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Utilities
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
Plug 'SirVer/ultisnips'
Plug 'wakatime/vim-wakatime'

" Language support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'

" All kindsss of treeesss
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

" Cool color themes
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'

" The status bar
Plug 'itchyny/lightline.vim'
let g:lightline = { 
      \  'colorscheme': 'gruvbox',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \  },
      \  'inactive': {
      \    'left': [['relativepath']],
      \  }
      \}
call plug#end()

" -----------------------------------------------------------------------------
" - General settings -
" -----------------------------------------------------------------------------
syntax on

colorscheme gruvbox

set signcolumn=yes
set encoding=utf-8
set termencoding=utf-8
set undodir=~/.vim/undodir
set tabstop=4
set shiftwidth=4
set background=dark
set updatetime=50
set cmdheight=2
set shortmess+=c
set colorcolumn=90
set mouse=a
set clipboard=unnamed
set completeopt=menuone,noinsert,noselect
set termguicolors noswapfile undofile nowrap smartindent autoindent expandtab ignorecase
set number hidden nobackup nowritebackup noshowmode autoread

" Removes highlighting after you enter insert mode
autocmd InsertEnter * :let @/=""

let mapleader=","
map - <C-W>-
map + <C-W>+
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-f> :NERDTreeToggle<CR>
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>==
nnoremap <expr> <leader>c (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<CR>"
nnoremap <Leader>pf :NERDTreeFind<CR>
nnoremap <leader>gc :GCheckout<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>u :UndotreeShow<CR>

" Allows you to hold onto highlighting
vnoremap < <gv
vnoremap > >gv

let g:go_fmt_command = "goimports"
let g:move_key_modifier = 'C'
let g:rustfmt_autosave = 1
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.tsx,*.ts"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Nerdtree on startup
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" -----------------------------------------------------------------------------
" - LSP Config -
" -----------------------------------------------------------------------------

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gh :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>

let g:completion_confirm_key = "\<C-y>"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_enable_snippet = 'UltiSnips'
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
lua require'lspconfig'.tsserver.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.gopls.setup{ on_attach=require'completion'.on_attach }
lua require'lspconfig'.rust_analyzer.setup{ on_attach=require'completion'.on_attach }

command! Format execute 'lua vim.lsp.buf.formatting()'

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"

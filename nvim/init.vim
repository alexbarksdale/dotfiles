" -----------------------------------------------------------------------------
" - Plugins -
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" FZF (fuzzy searching)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Utilities
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wakatime/vim-wakatime'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'

" All kindsss of treeesss
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

" Cool color themes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'

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

let mapleader=","

colorscheme gruvbox
set background=dark

set undodir=~/.vim/undodir
set signcolumn=yes encoding=utf-8 termencoding=utf-8
set mouse=a clipboard=unnamed shortmess+=c
set completeopt=menuone,noinsert,noselect
set tabstop=4 shiftwidth=4 cmdheight=2 colorcolumn=90 updatetime=50
set termguicolors noswapfile undofile nowrap smartindent autoindent expandtab ignorecase
set number hidden nobackup nowritebackup noshowmode autoread

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
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>gc :GCheckout<CR>
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>u :UndotreeShow<CR>

" Allows you to hold onto highlighting
vnoremap < <gv
vnoremap > >gv

" Removes highlighting after you enter insert mode
autocmd InsertEnter * :let @/=""

let g:go_fmt_command = "goimports"
let g:move_key_modifier = 'C'
let g:rustfmt_autosave = 1
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.tsx,*.ts"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Nerdtree on startup
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" -----------------------------------------------------------------------------
" - COC Config -
" -----------------------------------------------------------------------------
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Confirm completion
if has('patch8.1.1068')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Select similar text 
nmap <expr> <silent> <M-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Format on save
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Utilities
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>qf  <Plug>(coc-fix-current)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" ========================================
" PLUGINS
" ========================================
call plug#begin('~/.vim/plugged')

" FZF (fuzzy searching)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Better ways to comment code
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'

" Git 
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/fzf-checkout.vim'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Front End Goodies 
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

" Wakatime to track productivity metrics
Plug 'wakatime/vim-wakatime'

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'

" Better snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetDirectories = ['/users/alex/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"

" Auto import packages in Go
let g:go_fmt_command = "goimports"

" All kindsss of treeesss
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

" Move multiple lines
Plug 'matze/vim-move'

" Cool color themes
Plug 'gruvbox-community/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'chriskempson/base16-vim'
Plug 'ayu-theme/ayu-vim'

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
" ========================================

syntax on
syntax sync fromstart 

set signcolumn=yes
set encoding=utf-8
set termencoding=utf-8
set termguicolors
set noswapfile
set undodir=~/.vim/undodir
set undofile
set nowrap
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set expandtab
set mouse=a
set ignorecase
set number
set background=dark
set hidden
set hls is  
set nobackup
set nowritebackup
set updatetime=50
set cmdheight=2
set shortmess+=c
set noshowmode 
set autoread

let ayucolor="mirage"
" colorscheme base16-default-dark
colorscheme gruvbox

" Removes highlighting after you enter insert mode
autocmd InsertEnter * :let @/=""

highlight LineNr guibg=clear
highlight GitGutterAdd guibg=clear
highlight GitGutterChange guibg=clear
highlight GitGutterDelete guibg=clear
highlight GitGutterChangeDelete guibg=clear

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
nnoremap <leader>gc :GCheckout<CR>
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>==
nnoremap <Leader>pf :NERDTreeFind<CR>
nnoremap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <expr> <leader>c (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<CR>"
nnoremap <leader>ghw :h <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>u :UndotreeShow<CR>
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi

" Allows you to hold onto highlighting
vnoremap < <gv
vnoremap > >gv

let g:move_key_modifier = 'C'
let g:python_highlight_space_errors = 0
let g:rustfmt_autosave = 1
let g:autopep8_max_line_length=90
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.tsx,*.ts"
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

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

" Nerdtree on startup
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Format on save
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ================================================
" COC Config
" ================================================
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
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

" Nerdtree on startup
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Format on save
command! -nargs=0 Prettier :CocCommand prettier.formatFile

nmap <leader>rn <Plug>(coc-rename)
xmap <leader>f  <Plug>(coc-format-selected)
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

let g:coc_global_extensions = [
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ 'coc-python',
  \ 'coc-highlight',
  \ 'coc-json', 
  \ ]

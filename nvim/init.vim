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

" Git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Front End Goodies 
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

" Wakatime to track productivity metrics
Plug 'wakatime/vim-wakatime'

" For better snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories = ['/users/alex/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"

" Language support
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'tell-k/vim-autopep8'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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

" The status bar
Plug 'itchyny/lightline.vim'
let g:lightline = { 
      \  'colorscheme': 'onedark',
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
syntax sync fromstart " Fix syntax highlighting breaking in some filetypes

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

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Disables the second status line (using lightline)
set noshowmode 

" Automatically refresh any files that haven't been edited by Vim
set autoread

colorscheme onedark
highlight LineNr guibg=clear

" Remove VimGutter BG color
highlight GitGutterAdd guibg=clear
highlight GitGutterChange guibg=clear
highlight GitGutterDelete guibg=clear
highlight GitGutterChangeDelete guibg=clear

" ========================================
" KEY MAPS
" ========================================
let mapleader=","
" For simple sizing of splits
map - <C-W>-
map + <C-W>+
" Shortcut for split navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-f> :NERDTreeToggle<CR>
nnoremap <C-j> :m .+1<CR>
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
nnoremap <Leader>pf :NERDTreeFind<CR>
nnoremap <expr> <leader>c (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<CR>"
let g:move_key_modifier = 'C'
let g:python_highlight_space_errors = 0

" Allows you to hold onto highlighting
vnoremap < <gv
vnoremap > >gv

" Removes highlighting after you enter insert mode
autocmd InsertEnter * :let @/=""

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap jj <ESC>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader>u :UndotreeShow<CR>
" ========================================

" AutoPep8 Config
let g:autopep8_max_line_length=90
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1

let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.tsx,*.ts"

if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" ================================================
" CAUTION SCARY COC CONFIG BELOW
" ============== COC Config ============== 
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Select similar text (CMD + D feature from VSCODE)
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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
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


" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Resume latest coc list.
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


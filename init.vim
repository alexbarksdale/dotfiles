" ========================================
" PLUGINS
" ========================================
call plug#begin('~/.vim/plugged')
" Multi-Cursor
Plug 'mg979/vim-visual-multi'
" FZF (fuzzy searching)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Comments!
Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-commentary'

" Change surrounding
Plug 'tpope/vim-surround'

" Git stuff (2)
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Front End Goodies 
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'pangloss/vim-javascript' 
Plug 'mxw/vim-jsx'
Plug 'styled-components/vim-styled-components'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'
" Hex colors
Plug 'ap/vim-css-color' 

" GoLang Support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Auto import packages in Go
let g:go_fmt_command = "goimports"

" Wakatime
Plug 'wakatime/vim-wakatime'

" For awesome snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsSnippetDirectories = ['/users/alex/.config/nvim/UltiSnips']
let g:UltiSnipsExpandTrigger="<tab>"

" Common language snippets
Plug 'honza/vim-snippets'

" Nerdtree
Plug 'preservim/nerdtree'

" Move multiple lines
Plug 'matze/vim-move'
" The status bar
Plug 'itchyny/lightline.vim'
Plug 'nicknisi/vim-base16-lightline'
let g:lightline = { 
      \  'colorscheme': 'base16',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \  },
      \  'inactive': {
      \    'left': [['relativepath']],
      \  }
      \}


" Cool color theme
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
call plug#end()
" ========================================
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Disables the second status line (using lightline)
set noshowmode 

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
set encoding=utf-8
set termencoding=utf-8
set termguicolors

set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set number
set background=dark
" So that gutter markers appear quicker
set updatetime=100

set ignorecase
set cursorline

" Automatically refresh any files that haven't been edited by Vim
set autoread

syntax on
colorscheme base16-default-dark
highlight Normal guibg=black guifg=white
" colorscheme gruvbox
let mapleader=","
" ========================================
" KEY MAPS
" ========================================
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
" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Removes highlighting after you enter insert mode
autocmd InsertEnter * :let @/=""
inoremap jj <ESC>
nnoremap ,b :Buffers<CR>
"inoremap c. <ESC>:w<CR>
"nnoremap c. <ESC>:w<CR>
"nnoremap ,f :Files<CR>
"nnoremap ,s :BLines<CR>
"nnoremap ,l :Lines<CR>
"nnoremap ,m :Marks<CR>
"nnoremap ,a :Ag<CR>
"nnoremap ,r :Rg<CR>
"nnoremap ,qo :copen<CR>
"nnoremap ,qn :cnext<CR>
"nnoremap ,qp :cprev<CR>
"nnoremap ,qq :cclose<CR>
"nnoremap ,lo :lopen<CR>
"nnoremap ,ln :lnext<CR>
"nnoremap ,lp :lprev<CR>
"nnoremap ,lq :lclose<CR>
""nmap <F8> :TagbarToggle<CR>


let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.php,*.jsx"
autocmd BufNewFile,BufRead *.js set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx

" delete the current buffer, but not the split
nmap ,d :b#<bar>bd#<CR>

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

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

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

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-python',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ 'coc-json', 
  \ ]

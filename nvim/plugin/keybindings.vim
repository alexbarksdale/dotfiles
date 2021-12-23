let mapleader = ","

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-W>k
map <C-l> <C-W>l
map <C-f> :NERDTreeToggle<CR>

nnoremap <Leader>pf :NERDTreeFind<CR>
nnoremap <leader>s :BLines<CR>
nnoremap <leader>u :UndotreeShow<CR>

" create new tab based on current file
nnoremap <leader>nt :tabnew %<CR>

" git
nnoremap <leader>gf :diffget //2<CR> " grabs diff A
nnoremap <leader>gj :diffget //3<CR> " grabs diff B
nnoremap <leader>gs :G<CR>

augroup ALEX
    autocmd!
    " remove trailing white space
    autocmd BufWritePre * %s/\s\+$//e
    autocmd BufEnter,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{}
augroup END


syntax on

set nohlsearch
set nu
set nowrap
set expandtab
set smartindent
set termguicolors

let g:gruvbox_bold=0
let ayucolor="mirage"
" colorscheme xcodedark
colorscheme ayu

" Give more space for displaying messages.
set cmdheight=1

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

let g:lightline = {
      \  'colorscheme': 'ayu',
      \  'active': {
      \    'left': [['mode', 'paste'], ['readonly', 'relativepath', 'modified']],
      \  },
      \  'inactive': {
      \    'left': [['relativepath']],
      \  }
      \}

" auto formatting
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

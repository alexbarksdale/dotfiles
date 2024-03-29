call plug#begin('~/.vim/plugged')
" lsp / auto-complete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'

" linter(s)
Plug 'ambv/black'

" theme(s)
Plug 'ayu-theme/ayu-vim'
Plug 'dracula/vim'
Plug 'gruvbox-community/gruvbox'
Plug 'arzg/vim-colors-xcode'

" trees
Plug 'preservim/nerdtree'
Plug 'mbbill/undotree'

" language support
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go'

" telescope requirements
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

" utilities
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'norcalli/nvim-colorizer.lua'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ThePrimeagen/git-worktree.nvim'
Plug 'github/copilot.vim'

" status bar
Plug 'itchyny/lightline.vim'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'graphql', 'yaml', 'html', 'json', 'typescriptreact'] }

" Plug 'MarcWeber/vim-addon-mw-utils' " dep of vim-snipmate
" Plug 'tomtom/tlib_vim' " dep of vim-snipmate
" Plug 'garbas/vim-snipmate'

" signature help
Plug 'ray-x/lsp_signature.nvim'

call plug#end()


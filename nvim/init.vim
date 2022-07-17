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

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ThePrimeagen/git-worktree.nvim'

" status bar
Plug 'itchyny/lightline.vim'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Plug 'MarcWeber/vim-addon-mw-utils' " dep of vim-snipmate
" Plug 'tomtom/tlib_vim' " dep of vim-snipmate
" Plug 'garbas/vim-snipmate'

" signature help
Plug 'ray-x/lsp_signature.nvim'

call plug#end()


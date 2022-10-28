call plug#begin()

" NERDTree stuff
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'

" neovim lsp plugins and depencencies
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'mfussenegger/nvim-lint'
"Plug 'dense-analysis/ale'

" various plugins
Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
Plug 'gorbit99/codewindow.nvim'
Plug 'vim-perl/vim-perl', { 'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'preservim/nerdcommenter'
Plug 'mhinz/vim-startify'
Plug 'rmagatti/auto-session'
Plug 'tpope/vim-fugitive'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'vmware-archive/salt-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'itchyny/vim-cursorword'
Plug 'sheerun/vim-polyglot'

" themes
Plug 'navarasu/onedark.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'dracula/vim'
Plug 'vigoux/oak'
Plug 'NLKNguyen/papercolor-theme'
Plug 'bluz71/vim-moonfly-colors'

"Fuzzy search by Telescope and its dependencies:
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'BurntSushi/ripgrep'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" set termguicolors before lua config,
" as it can contain some theme stuff that
" checks for termguicolors
set termguicolors

" load main lua file with additional configs
lua require("my-lspconfig")
lua require("my-lint")
lua require("general")

" highlight all .conf files as apache config (:])
autocmd BufEnter *.conf :setlocal filetype=apache

"nerdtree bindings
nnoremap <leader>n :NvimTreeFocus<CR>
nnoremap <C-t> :NvimTreeToggle<CR>

" nerdcommenter custom bindings
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

"theme configuration
syntax enable
let g:onedark_config = {
    \ 'style': 'darker',
\}
let g:PaperColor_Theme_Options = {
  \   'language': {
  \     'python': {
  \       'highlight_builtins' : 1
  \     },
  \     'cpp': {
  \       'highlight_standard_library': 1
  \     },
  \     'c': {
  \       'highlight_builtins' : 1
  \     }
  \   }
  \ }
colorscheme moonfly
let g:airline_theme='dark'

set splitright
set splitbelow


" indent/unindent with tab/shift-tab
nmap <Tab> >>
nmap <S-tab> <<
imap <S-Tab> <Esc><<i
vmap <Tab> >gv
vmap <S-Tab> <gv

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" general configs
set modeline
let g:sls_use_jinja_syntax = 1
set encoding=UTF-8
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " add relative line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
"set mouse=a                " enable mouse click
set clipboard+=unnamedplus  " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

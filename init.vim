" set termguicolors before lua config,
" as it can contain some theme stuff that
" checks for termguicolors
set termguicolors
" load main lua file with additional configs
lua require("initializer")

" highlight all .conf files as apache config (:])
autocmd BufEnter *.conf :setlocal filetype=apache
au BufNewFile,BufRead *.sls set filetype=sls.yaml

"nerdtree bindings
nnoremap <leader>n :NvimTreeFocus<CR>
nnoremap <C-t> :NvimTreeToggle<CR>

" nerdcommenter custom bindings
nmap <c-/> <plug>NERDCommenterToggle
vmap <c-/> <plug>NERDCommenterToggle

"theme configuration
syntax enable
colorscheme gruvbox

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

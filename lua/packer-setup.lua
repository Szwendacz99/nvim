return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- NERDTree stuff
    use 'nvim-tree/nvim-web-devicons' -- optional, for file icons
    use 'nvim-tree/nvim-tree.lua'

    -- neovim lsp plugins and depencencies
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'mfussenegger/nvim-lint'
    use 'onsails/lspkind.nvim'

    -- various plugins
    use 'lewis6991/gitsigns.nvim'
    use 'petertriho/nvim-scrollbar'
    use 'kevinhwang91/nvim-hlslens'
    use 'windwp/nvim-ts-autotag'
    use 'hrsh7th/cmp-path'
    use { 'L3MON4D3/LuaSnip', tag = '*' }
    use 'saadparwaiz1/cmp_luasnip'
    use 'lambdalisue/suda.vim'
    use { 'akinsho/bufferline.nvim', tag = '*' }
    use 'gorbit99/codewindow.nvim'
    use 'preservim/nerdcommenter'
    use 'rmagatti/auto-session'
    use 'tpope/vim-fugitive'
    use 'Glench/Vim-Jinja2-Syntax'
    use 'vmware-archive/salt-vim'
    use 'stephpy/vim-yaml'

    use 'nvim-lualine/lualine.nvim'
    use 'itchyny/vim-cursorword'
    use 'sheerun/vim-polyglot'
    use 'ray-x/lsp_signature.nvim'

    -- themes
    use 'olimorris/onedarkpro.nvim'
    use 'ellisonleao/gruvbox.nvim'
    use 'Mofiqul/dracula.nvim'
    use 'vigoux/oak'
    use 'NLKNguyen/papercolor-theme'
    use 'bluz71/vim-moonfly-colors'
    use 'luisiacc/gruvbox-baby'
    use 'catppuccin/nvim'
    use 'EdenEast/nightfox.nvim'
    use 'projekt0n/github-nvim-theme'

    --Fuzzy search by Telescope and its dependencies:
    use {
        'nvim-telescope/telescope.nvim', branch = 'master',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'BurntSushi/ripgrep'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)

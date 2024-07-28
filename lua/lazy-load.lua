require("lazy").setup({
        { 'mracos/mermaid.vim' },
        -- Nvim-tree stuff
        { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
        {
            'nvim-tree/nvim-tree.lua',
            opts = require('plugins.nvim-tree').config,
            keys = require('plugins.nvim-tree').keys
        },

        {
            'nvim-treesitter/nvim-treesitter',
            -- treesitter need to be configured after load,
            -- so let here be init, not config
            init = require('plugins.treesitter'),
            --build = ':TSUpdate', -- not needed in Container workflow
            priority = 400
        },
        -- neovim lsp plugins and depencencies
        {
            'nvimdev/lspsaga.nvim',
            config = function()
                require('lspsaga').setup({
                    lightbulb = { enable = false }
                })
            end,
        },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "theHamsta/nvim-dap-virtual-text" },
            config = require('plugins.nvim-dap').init
        },
        {
            "folke/neodev.nvim",
            config = require('plugins.neodev').init
        },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-cmdline' },
        { 'hrsh7th/cmp-path' },
        {
            'hrsh7th/nvim-cmp',
            config = require('plugins.nvim-cmp').init,
            dependencies = { 'onsails/lspkind.nvim' }
        },
        {
            'williamboman/mason.nvim',
            opts = {},
            priority = 200
        },
        -- mason-lspconfig might need disabling on first run
        {
            'williamboman/mason-lspconfig.nvim',
            opts = require('plugins.mason-lspconfig').config,
            dependencies = { 'williamboman/mason.nvim' },
            priority = 150
        },
        {
            'neovim/nvim-lspconfig',
            init = require('plugins.nvim-lspconfig').init
        },
        {
            'mfussenegger/nvim-lint',
            init = require('plugins.nvim-lint').init
        },
        {
            'folke/trouble.nvim',
            opts = {},
            cmd = "Trouble",
            --opts = require('plugins.trouble').config,
            keys = require("plugins.trouble").keys
        },

        -- various plugins
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("which-key").setup(
                    require('plugins.which-key').conf)
            end,
        },
        {
            'lewis6991/gitsigns.nvim',
            opts = require('plugins.gitsigns').config
        },
        {
            'petertriho/nvim-scrollbar',
            opts = {}
        },
        {
            'kevinhwang91/nvim-hlslens',
            opts = {},
            keys = require('plugins.hlslens').keys
        },
        { 'L3MON4D3/LuaSnip',        version = '*' },
        { 'saadparwaiz1/cmp_luasnip' },
        {
            'akinsho/bufferline.nvim',
            version = '*',
            opts = require('plugins.bufferline').config
        },
        {
            'gorbit99/codewindow.nvim',
            opts = require('plugins.codewindow').config,
            init = require('plugins.codewindow').build
        },
        {
            'preservim/nerdcommenter',
            keys = require('plugins.nerdcommenter').keys
        },
        {
            'rmagatti/auto-session',
            opts = require('plugins.auto-session').config
        },
        {
            "NeogitOrg/neogit",
            dependencies = {
                "nvim-lua/plenary.nvim",  -- required
                "sindrets/diffview.nvim", -- optional - Diff integration

                -- Only one of these is needed, not both.
                "nvim-telescope/telescope.nvim", -- optional
            },
            opts = require('plugins.neogit').config
        },

        --{ 'Glench/Vim-Jinja2-Syntax', priority = 15 },
        --{ 'vmware-archive/salt-vim',  priority = 10 },
        --{ 'stephpy/vim-yaml' }, -- for proper sls syntax highlighting when jinja
        {
            'lukas-reineke/indent-blankline.nvim',
            main = "ibl",
            init = require('plugins.indent-blankline').init
        },
        { 'MunifTanjim/nui.nvim' },
        {
            'folke/noice.nvim',
            opts = require("plugins.noice").config,
            dependencies = {
                "MunifTanjim/nui.nvim",
                -- OPTIONAL:
                --   `nvim-notify` is only needed, if you want to use the notification view.
                --   If not available, we use `mini` as the fallback
                "rcarriga/nvim-notify", }
        },
        {
            'rcarriga/nvim-notify',
            opts = require('plugins.nvim-notify').config
        },
        {
            'MeanderingProgrammer/markdown.nvim',
            main = "render-markdown",
            opts = {},
            name = 'render-markdown',                                              -- Only needed if you have another plugin named markdown.nvim
            --dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
             dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        },
        {
            'nvim-lualine/lualine.nvim',
            opts = require('plugins.lualine').config
        },
        { 'RRethy/vim-illuminate' },
        { 'sheerun/vim-polyglot' },

        -- themes
        { "ellisonleao/gruvbox.nvim", priority = 1000, config = true },

        --Fuzzy search by Telescope and its dependencies:
        {
            'nvim-telescope/telescope.nvim',
            branch = 'master',
            config = require('plugins.nvim-telescope').config,
            dependencies = { 'nvim-lua/plenary.nvim' },
            priority = 100
        },
        { 'BurntSushi/ripgrep' },

    },
    {
        root = vim.fn.stdpath("data") .. "/lazy", -- directory where plugins will be installed
        defaults = {
            lazy = false,                         -- should plugins be lazy-loaded?
            version = nil,
            -- version = "*", -- enable this to try installing the latest stable versions of plugins
        },
        -- leave nil when passing the spec as the first argument to setup()
        spec = nil, ---@type LazySpec
        lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
        concurrency = 1, ---@type number limit the maximum amount of concurrent tasks
        git = {
            -- defaults for the `Lazy log` command
            -- log = { "-10" }, -- show the last 10 commits
            log = { "--since=3 days ago" }, -- show commits from the last 3 days
            timeout = 120,                  -- kill processes that take more than 2 minutes
            url_format = "https://github.com/%s.git",
            -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
            -- then set the below to false. This is should work, but is NOT supported and will
            -- increase downloads a lot.
            filter = true,
        },
        dev = {
            -- directory where you store your local plugin projects
            path = "~/projects",
            ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
            patterns = {},    -- For example {"folke"}
            fallback = false, -- Fallback to git when local plugin doesn't exist
        },
        install = {
            -- install missing plugins on startup. This doesn't increase startup time.
            missing = true,
            -- try to load one of these colorschemes when starting an installation during startup
            colorscheme = {},
        },
        ui = {
            -- a number <1 is a percentage., >1 is a fixed size
            size = { width = 0.8, height = 0.8 },
            wrap = true, -- wrap the lines in the ui
            -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
            border = "none",
            icons = {
                cmd = " ",
                config = "",
                event = "",
                ft = " ",
                init = " ",
                import = " ",
                keys = " ",
                lazy = "鈴 ",
                loaded = "●",
                not_loaded = "○",
                plugin = " ",
                runtime = " ",
                source = " ",
                start = "",
                task = "✔ ",
                list = {
                    "●",
                    "➜",
                    "★",
                    "‒",
                },
            },
            -- leave nil, to automatically select a browser depending on your OS.
            -- If you want to use a specific browser, you can define it here
            browser = nil, ---@type string?
            throttle = 20, -- how frequently should the ui process render events
            custom_keys = {
                -- you can define custom key maps here.
                -- To disable one of the defaults, set it to false

                -- open lazygit log
                ["<localleader>l"] = function(plugin)
                    require("lazy.util").float_term({ "lazygit", "log" }, {
                        cwd = plugin.dir,
                    })
                end,
                -- open a terminal for the plugin dir
                ["<localleader>t"] = function(plugin)
                    require("lazy.util").float_term(nil, {
                        cwd = plugin.dir,
                    })
                end,
            },
        },
        diff = {
            -- diff command <d> can be one of:
            -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
            --   so you can have a different command for diff <d>
            -- * git: will run git diff and open a buffer with filetype git
            -- * terminal_git: will open a pseudo terminal with git diff
            -- * diffview.nvim: will open Diffview to show the diff
            cmd = "git",
        },
        checker = {
            -- automatically check for plugin updates
            enabled = false,
            concurrency = nil, ---@type number? set to 1 to check for updates very slowly
            notify = true,    -- get a notification when new updates are found
            frequency = 3600, -- check for updates every hour
        },
        change_detection = {
            -- automatically check for config file changes and reload the ui
            enabled = true,
            notify = true, -- get a notification when changes are found
        },
        performance = {
            cache = {
                enabled = true,
                path = vim.fn.stdpath("cache") .. "/lazy/cache",
                -- Once one of the following events triggers, caching will be disabled.
                -- To cache all modules, set this to `{}`, but that is not recommended.
                -- The default is to disable on:
                --  * VimEnter: not useful to cache anything else beyond startup
                --  * BufReadPre: this will be triggered early when opening a file from the command line directly
                disable_events = { "UIEnter", "BufReadPre" },
                ttl = 3600 * 24 * 5, -- keep unused modules for up to 5 days
            },
            reset_packpath = true,   -- reset the package path to improve startup time
            rtp = {
                reset = true,        -- reset the runtime path to $VIMRUNTIME and your config directory
                ---@type string[]
                paths = {},          -- add any custom paths here that you want to includes in the rtp
                ---@type string[] list any plugins you want to disable here
                disabled_plugins = {
                    -- "gzip",
                    -- "matchit",
                    -- "matchparen",
                    -- "netrwPlugin",
                    -- "tarPlugin",
                    -- "tohtml",
                    -- "tutor",
                    -- "zipPlugin",
                },
            },
        },
        -- lazy can generate helptags from the headings in markdown readme files,
        -- so :help works even for plugins that don't have vim docs.
        -- when the readme opens with :help it will be correctly displayed as markdown
        readme = {
            root = vim.fn.stdpath("state") .. "/lazy/readme",
            files = { "README.md", "lua/**/README.md" },
            -- only generate markdown helptags for plugins that dont have docs
            skip_if_doc_exists = true,
        },
        state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
    })

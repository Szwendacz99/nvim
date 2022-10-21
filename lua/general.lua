-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- load lsp and dependencies (help for both coc and independent lsp setup)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "pyright",
        "perlnavigator",
        "salt_ls",
        "dockerls",
        "kotlin_language_server",
        "intelephense",
        "phpactor",
        "eslint"
    }
})
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
        require("null-ls").builtins.code_actions.gitsigns,
    },
})

-- setup minimap
local codewindow = require('codewindow')
codewindow.setup({
    minimap_width = 20, -- The width of the text part of the minimap
    width_multiplier = 4, -- How many characters one dot represents
    use_lsp = true, -- Use the builtin LSP to show errors and warnings
    use_treesitter = true, -- Use nvim-treesitter to highlight the code
    exclude_filetypes = {}, -- Choose certain filetypes to not show minimap on
    z_index = 1, -- The z-index the floating window will be on
    })
codewindow.apply_default_keybinds()


-- load perl lsp
require'lspconfig'.perlnavigator.setup{
    settings = {
      perlnavigator = {
          perlPath = 'perl',
          enableWarnings = true,
          perltidyProfile = '',
          perlcriticProfile = '',
          perlcriticEnabled = true,
      }
    }
}

require("nvim-tree").setup({
    create_in_closed_folder = true,
    hijack_cursor = true,
    open_on_setup = true,
    open_on_setup_file = true,
    sync_root_with_cwd = true,
    view = {
      adaptive_size = true,
    },
    renderer = {
      full_name = true,
      group_empty = true,
      special_files = {},
      symlink_destination = false,
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "signcolumn",
        show = {
          file = true,
          folder = false,
          folder_arrow = false,
          git = true,
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = { "help" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    filters = {
      custom = {
        "^.git$",
        "^.mypy_cache$",
      },
    },
    actions = {
      change_dir = {
        enable = false,
        restrict_above_cwd = true,
      },
      open_file = {
        resize_window = true,
      },
      remove_file = {
        close_window = false,
      },
    },
    log = {
      enable = false,
      truncate = true,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
  })

--Gruvbox theme settings
-- setup must be called before loading the colorscheme
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = false, -- default=true
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = true, -- default=false
  transparent_mode = false,
})


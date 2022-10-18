-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- load lsp stuff
require("mason").setup()
require("mason-lspconfig").setup()
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua,
        require("null-ls").builtins.diagnostics.eslint,
        require("null-ls").builtins.completion.spell,
    },
})


-- load perl lsp 
local config = {
  cmd = { 'pls' }, -- complete path to where PLS is located
  settings = {
    pls = {
      --inc = { '/my/perl/5.34/lib', '/some/other/perl/lib' },  -- add list of dirs to @INC
      --cwd = { '/my/projects' },   -- working directory for PLS
      perlcritic = { enabled = true },  -- use perlcritic and pass a non-default location for its config
      syntax = { enabled = true, perl = '/usr/bin/perl' }, -- enable syntax checking and use a non-default perl binary
      --perltidy = { perltidyrc = '/my/projects/.perltidyrc' } -- non-default location for perltidy's config
    }
  }
}
require'lspconfig'.perlpls.setup(config)

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


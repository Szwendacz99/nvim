require("scrollbar").setup()

-- setup minimap
local codewindow = require('codewindow')
codewindow.setup({
    minimap_width = 20, -- The width of the text part of the minimap
    width_multiplier = 4, -- How many characters one dot represents
    use_lsp = true, -- Use the builtin LSP to show errors and warnings
    use_treesitter = true, -- Use nvim-treesitter to highlight the code
    show_cursor = true,
    exclude_filetypes = {}, -- Choose certain filetypes to not show minimap on
    z_index = 1, -- The z-index the floating window will be on
})
codewindow.apply_default_keybinds()

local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------
-- general setup start
----------------------

-- open nvim tree on start
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- tab lines in normal and visual mode
map("n", "<Tab>", ">>")
map("n", "<S-Tab>", "<<")
map("i", "<S-Tab>", "<Esc><<i")
map("n", "<Tab>", ">>")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

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


vim.opt.mouse = "c" -- set mouse in command line mode
vim.opt.colorcolumn = "80" -- highlight this column
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus" -- synchronize with system clipboard
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.cmd [[
    highlight clear
    colorscheme dracula
    TSEnable highlight
]]


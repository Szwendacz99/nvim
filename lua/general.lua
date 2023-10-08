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

--mardown preview settings
vim.cmd [[
    let g:mkdp_echo_preview_url = 1
]]


----------------------
-- general setup start
----------------------

-- open nvim tree on start
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- disabling virtual text
VIRTUAL_TEXT_ENABLED = true
function switch_virtual_text()
    VIRTUAL_TEXT_ENABLED = not VIRTUAL_TEXT_ENABLED
    vim.diagnostic.config({
      virtual_text = VIRTUAL_TEXT_ENABLED,
    })
end
map("n", "<leader>vt", ":lua switch_virtual_text()<CR>")
map("c", "<C-r>", ":Telescope command_history<CR>")
map("n", "<leader>gs", ":Telescope git_status<CR>")
map("n", "<leader>gc", ":Telescope git_commits<CR>")
map("n", "<leader>gb", ":Telescope git_branches<CR>")

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
vim.opt.tabstop = 4 -- number of columns occupied by a tab
vim.opt.softtabstop = 4 -- see multiple spaces as tabstops so <BS> does the right thing
vim.opt.expandtab = true -- converts tabs to white space
vim.opt.shiftwidth = 4 -- width for autoindents
vim.cmd [[
    highlight clear
    colorscheme dracula
]]

require("initializer")
vim.opt.mouse = "c" -- set mouse in command line mode
vim.opt.colorcolumn = "80" -- highlight this column
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus" -- synchronize with system clipboard
vim.opt.swapfile = false
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.cmd [[
    highlight clear
    colorscheme dracula
]]

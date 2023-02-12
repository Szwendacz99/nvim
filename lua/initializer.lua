local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- load all modules
require("lazy-setup")
require("general")
require("my-lint")
require("conf-hlslens")
require("conf-gitsigns")
require("conf-lualine")
require("conf-nvim-cmp")
require("conf-nvim-tree")
require("conf-bufferline")
require("conf-treesitter")
require("conf-indent-blankline")
require("my-lspconfig") -- need to be after treesitter initialization

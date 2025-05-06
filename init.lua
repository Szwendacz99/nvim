-- set leader here, so other configs know about it
vim.g.mapleader = " "

--make sure Lazy is installed
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

vim.opt.termguicolors = true
-- load all plugins
require("lazy-load")
-- load general config
require("general")
require("mc-functions")

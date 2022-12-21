-- load all modules
require("packer-setup")
require("general")
require("my-lint")
require("conf-hlslens")
require("conf-gitsigns")
require("conf-lualine")
require("conf-mason")
require("conf-nvim-cmp")
require("conf-nvim-tree")
require("conf-bufferline")
require("conf-themes")
require("conf-treesitter")
require("my-lspconfig") -- need to be after treesitter initialization

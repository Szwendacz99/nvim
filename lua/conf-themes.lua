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
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = true, -- default=false
    transparent_mode = false,
})

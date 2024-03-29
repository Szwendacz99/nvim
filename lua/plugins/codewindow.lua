return {
    config = {
        minimap_width = 20, -- The width of the text part of the minimap
        width_multiplier = 4, -- How many characters one dot represents
        use_lsp = true, -- Use the builtin LSP to show errors and warnings
        use_treesitter = true, -- Use nvim-treesitter to highlight the code
        show_cursor = true,
        exclude_filetypes = {}, -- Choose certain filetypes to not show minimap on
        z_index = 1, -- The z-index the floating window will be on
    },
    build = function ()
        require("codewindow").apply_default_keybinds()
    end
}

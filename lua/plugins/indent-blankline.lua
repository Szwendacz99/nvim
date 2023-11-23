function init()
    local highlight = {
        "Violet",
        "Blue",
        "Orange",
        "Green",
        "Cyan",
        "Yellow",
        "Red",
    }
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "Red", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "Yellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "Blue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "Orange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "Green", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "Violet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "Cyan", { fg = "#56B6C2" })
    end)

    vim.g.rainbow_delimiters = { highlight = highlight }
    require("ibl").setup { scope = { highlight = highlight } }

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return {
    init = init
}

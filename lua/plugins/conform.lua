return {
    -- This will provide type hinting with LuaLS
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            yaml = { "yamlfmt" },
            markdown = { "mdformat" },
            bash = { "shfmt" },
            --lua = { "stylua" },
            --python = { "isort", "black" },
            --javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        --format_on_save = { timeout_ms = 500 },
        -- Customize formatters
        formatters = {
            yamlfmt = {
                prepend_args = { "-formatter", "retain_line_breaks=true,indentless_arrays=true" },
            },
        },
    }
}

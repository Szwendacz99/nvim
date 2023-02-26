return {
    config = {
        --ensure_installed = {
            --"bashls",
            --"pyright",
            --"pylsp",
            --"ruff_lsp",
            ----"pyre",
            --"perlnavigator",
            --"dockerls",
            --"intelephense",
            --"eslint",
            --"tsserver",
            --"cssls",
            --"cssmodules_ls",
            --"jsonls",
            --"lua_ls",
            --"sqlls",
            --"yamlls",
            --"lemminx",
            --"marksman",
            --"html",
        --},
        -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
        -- This setting has no relation with the `ensure_installed` setting.
        -- Can either be:
        --   - false: Servers are not automatically installed.
        --   - true: All servers set up via lspconfig are automatically installed.
        --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
        --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
        automatic_installation = true,
    }
}

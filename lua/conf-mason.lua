require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "pyright",
        "pylsp",
        "ruff_lsp",
        --"python-jedi-server",
        --"pyre",
        "perlnavigator",
        "dockerls",
        --"kotlin_language_server",
        "intelephense",
        "eslint",
        "tsserver",
        "cssls",
        "cssmodules_ls",
        "diagnosticls",
        "jsonls",
        "sumneko_lua",
        "sqlls",
        "yamlls",
        "lemminx",
        "marksman"
    }
})

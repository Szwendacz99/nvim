return function()
    local parsers = { "helm", "awk", "bash", "comment",
        "css", "csv", "c", "cmake", "devicetree", "diff", "dockerfile", "git_config",
        "git_rebase", "gitattributes", "gitcommit", "gitignore",
        "html", "htmldjango", "http", "ini",
        "json", "kconfig",
        "lua", "luadoc", "markdown", "markdown_inline", "mermaid",
        "perl", "php",
        "pod", "properties", "python",
        "regex", "requirements", "ruby", "ssh_config", "sql",
        "toml", "vim", "vimdoc", "xml", "yaml",
    }
    local ts = require("nvim-treesitter")
    -- Install each parser sequentially
    for parser in parsers do
        ts.install({ parser }):wait(30000)
    end
end

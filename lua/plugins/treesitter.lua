return function()
    require('nvim-treesitter').install({ "helm", "awk", "bash", "comment",
            "css", "csv", "c", "cmake", "devicetree", "diff", "dockerfile", "git_config",
            "git_rebase", "gitattributes", "gitcommit",
            "html", "htmldjango", "http", "ini",
            "json", "kconfig",
            "lua", "luadoc", "markdown", "markdown_inline", "mermaid",
            "perl", "php",
            "pod", "properties", "python",
            "regex", "requirements", "ssh_config",
            "toml", "vim", "vimdoc", "xml", "yaml",
        }):wait(3000000)

end

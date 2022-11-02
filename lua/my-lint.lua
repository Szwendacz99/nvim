require('lint').linters_by_ft = {
    python = { 'flake8', 'pylint', 'pycodestyle', },
    php = { 'phpcs' },
    markdown = { 'markdownlint' }
}

local pylint = require('lint.linters.pylint')
pylint.args = {
    '-f',
    'json',
    '--disable=C0114', -- disable missing module docstring info
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

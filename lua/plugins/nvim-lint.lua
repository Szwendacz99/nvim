return {
    init = function()
        require('lint').linters_by_ft = {
            --python = {
            --'ruff'
            --'flake8',
            --'pylint',
            --'pycodestyle',
            --'pydocstyle'
            --},
            php = { 'phpcs' },
            markdown = { 'markdownlint' }
        }

        --local pydocstyle = require('lint.linters.pydocstyle')
        --pydocstyle.args = {
        --'--ignore=D100,D203,D213', -- disable missing module docstring info
        ---- disable one line before class docstring required
        ---- disable multiline docstring summary
        ---- should start at the second line
        --}
        --local pylint = require('lint.linters.pylint')
        --pylint.args = {
        --'-f',
        --'json',
        --'--disable=C0114', -- disable missing module docstring info
        --}

        --vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        --callback = function()
        --require("lint").try_lint()
        --end,
        --})

        vim.api.nvim_create_autocmd({ "BufEnter" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}

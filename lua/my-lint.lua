require('lint').linters_by_ft = {
  python = {'flake8', 'pylint', 'pycodestyle', 'pydocstyle',},
  php = {'phpcs'},
  markdown = {'markdownlint'}
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


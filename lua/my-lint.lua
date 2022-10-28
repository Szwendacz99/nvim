require('lint').linters_by_ft = {
  python = {'flake8', 'pylint', 'pycodestyle',}
}

vim.api.nvim_create_autocmd({ "TextChanged" }, {
  callback = function()
    require("lint").try_lint()
  end,
})


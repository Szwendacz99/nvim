return {
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        require('telescope').setup {
            defaults = {
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--no-ignore',
                    '--hidden',
                    '--glob',
                    '!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}',
                },
            } }
    end,
    opts = {
        --defaults = {
        --vimgrep_arguments = {
        --'rg',
        --'--color=never',
        --'--no-heading',
        --'--with-filename',
        --'--line-number',
        --'--column',
        --'--smart-case',
        --'--no-ignore',
        ----'--hidden',
        --}
        --},
        pickers = {
            live_grep = {
                additional_args = function(opts)
                    return { "--hidden" }
                end
            },
        },
    }
}

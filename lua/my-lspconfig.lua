-- setup nvim-lspconfig
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- config for ray-x/lsp_signature.nvim
--local cfg = {
    --debug = false, -- set to true to enable debug logging
    --log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
    ---- default is  ~/.cache/nvim/lsp_signature.log
    --verbose = false, -- show debug line number

    --bind = true, -- This is mandatory, otherwise border config won't get registered.
    ---- If you want to hook lspsaga or other signature handler, pls set to false
    --doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    ---- set to 0 if you DO NOT want any API comments be shown
    ---- This setting only take effect in insert mode, it does not affect signature help in normal
    ---- mode, 10 by default

    --max_height = 12, -- max height of signature floating_window
    --max_width = 80, -- max_width of signature floating_window
    --noice = false, -- set to true if you using noice to render markdown
    --wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

    --floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    --floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    ---- will set to true when fully tested, set to false will use whichever side has more space
    ---- this setting will be helpful if you do not want the PUM and floating win overlap

    --floating_window_off_x = 1, -- adjust float windows x position.
    --floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
    ---- can be either number or function, see examples

    --close_timeout = 4000, -- close floating window after ms when laster parameter is entered
    --fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    --hint_enable = true, -- virtual hint enable
    --hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    --hint_scheme = "String",
    --hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    --handler_opts = {
        --border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
    --},

    --always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    --auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    --extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    --zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    --padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

    --transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    --shadow_blend = 36, -- if you using shadow as border use this set the opacity
    --shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    --timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    --toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

    --select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    --move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
--}

---- recommended:
--require 'lsp_signature'.setup(cfg) -- no need to specify bufnr if you don't use toggle_key


-----------------
-- attaching all lsp servers, order matters (for example in autocompletion)
-----------------
require 'lspconfig'.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities
    , settings = {
        pylsp = {
            plugins = {
                rope_autoimport = { enabled = false, memory = true },
                rope_completion = { enabled = false, eager = true },
                jedi_completion = {
                    enabled = true,
                    include_params = true,
                    include_class_objects = true,
                    include_function_objects = true,
                    fuzzy = true,
                    eager = true,

                },
                jedi_hover = { enabled = true },
                jedi_references = { enabled = true },
                jedi_signature_help = { enabled = true },
                jedi_symbols = { enabled = true },
                --ruff = { enabled = true },
                flake8 = {
                    enabled = false -- ruff_lsp
                },
                pylint = {
                    enabled = true,
                    args = {
                        -- disable missing module docstring info
                        -- and temporarilt false cannot import errors
                        '--disable=C0114,E0401'
                    }
                },
                yapf = {
                    enabled = true
                },
                autopep8 = {
                    enabled = false
                },
                pyflakes = { enabled = false }, -- ruff_lsp
                pyodestyle = { enabled = false }, -- ruff_lsp
                pydocstyle = {
                    enabled = true,
                    ignore = {
                        'D100', -- disable missing module docstring info
                        'D203', -- disable one line before class docstring required
                        'D213' -- disable multiline docstring summary
                        -- should start at the second line
                    }
                },
            }
        }
    }
}
require'lspconfig'.ruff_lsp.setup{
on_attach = on_attach,
capabilities = capabilities,
}
require 'lspconfig'.pyright.setup {
on_attach = on_attach,
capabilities = capabilities,
}
--require'lspconfig'.jedi_language_server.setup{
--on_attach = on_attach,
--capabilities = capabilities,
--}
--require 'lspconfig'.pyre.setup {
--on_attach = on_attach,
--capabilities = capabilities,
--}
require 'lspconfig'.sourcekit.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
--require 'lspconfig'.kotlin_language_server.setup {
    --on_attach = on_attach,
    --capabilities = capabilities,
--}
require 'lspconfig'.intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.eslint.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.tsserver.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
require 'lspconfig'.perlnavigator.setup {
    settings = {
        perlnavigator = {
            perlPath = 'perl',
            enableWarnings = true,
            perltidyProfile = '',
            perlcriticProfile = '',
            perlcriticEnabled = true,
        }
    },
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.cssmodules_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.diagnosticls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    },
}

require 'lspconfig'.sqlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.yamlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.lemminx.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require 'lspconfig'.marksman.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

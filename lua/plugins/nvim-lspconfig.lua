return {
    init = function()
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
        require 'lspconfig'.ruff_lsp.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        require 'lspconfig'.pyright.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
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
        require'lspconfig'.perlpls.setup{
            on_attach = on_attach,
            capabilities = capabilities,
        }
        --require 'lspconfig'.perlnavigator.setup {
            --settings = {
                --perlnavigator = {
                    --perlPath = 'perl',
                    --enableWarnings = true,
                    --perltidyProfile = '',
                    --perlcriticProfile = '',
                    --perlcriticEnabled = true,
                --}
            --},
            --on_attach = on_attach,
            --capabilities = capabilities,
        --}

        require 'lspconfig'.cssls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        require 'lspconfig'.cssmodules_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        require 'lspconfig'.jsonls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }

        require 'lspconfig'.lua_ls.setup {
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
        require 'lspconfig'.html.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        require 'lspconfig'.ansiblels.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
        require 'lspconfig'.r_language_server.setup {
            on_attach = on_attach,
            capabilities = capabilities,
        }
    end
}

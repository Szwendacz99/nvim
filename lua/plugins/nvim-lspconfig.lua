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
            vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
                require("conform").format({ async = true })
            end, bufopts)
        end

        local capabilities = require('cmp_nvim_lsp').default_capabilities()


        -----------------
        -- attaching all lsp servers, order matters (for example in autocompletion)
        -----------------
        --vim.lsp.config("pylsp", {
        --on_attach = on_attach,
        --capabilities = capabilities
        --, settings = {
        --pylsp = {
        --plugins = {
        --rope_autoimport = { enabled = true, memory = true },
        --rope_completion = { enabled = false, eager = false },
        --rope = {
        --ropeFolder = nil
        --},
        --jedi_completion = {
        --enabled = false,
        --include_params = true,
        --include_class_objects = true,
        --include_function_objects = true,
        --fuzzy = true,
        --eager = true,

        --},
        --jedi_definition = {
        --enabled = false,
        --},
        --mccabe = {
        --enabled = false
        --},
        --jedi_hover = { enabled = false },
        --jedi_references = { enabled = false },
        --jedi_signature_help = { enabled = false },
        --jedi_symbols = { enabled = false },
        --ruff = { enabled = false },
        --flake8 = {
        --enabled = false -- ruff_lsp
        --},
        --pylint = {
        --enabled = true,
        --args = {
        ---- disable missing module docstring info
        ---- and temporarilt false cannot import errors
        ---- too few public methods
        ---- missing functon or method doc
        --'--disable=C0114,E0401,R0903,C0116'
        --}
        --},
        --yapf = {
        --enabled = false
        --},
        --autopep8 = {
        --enabled = false
        --},
        --pyflakes = { enabled = false },    -- ruff_lsp
        --pycodestyle = { enabled = false }, -- ruff_lsp
        --pydocstyle = {
        --enabled = false,
        --ignore = {
        --'D100', -- disable missing module docstring info
        --'D101', -- disable missing public class doc
        --'D102', -- disable missing class method doc
        --'D103', -- disable missing function doc
        --'D203', -- disable one line before class docstring required
        --'D213', -- disable multiline docstring summary
        ---- should start at the second line
        --}
        --},
        --}
        --}
        --}
        --}
        vim.lsp.config("ruff", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"ruff"})
        vim.lsp.config("jedi_language_server", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"jedi_language_server"})
        --vim.lsp.config("pyright", {
        --on_attach = on_attach,
        --capabilities = capabilities,
        --}
        vim.lsp.config("bashls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"bashls"})
        vim.lsp.config("dockerls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"dockerls"})
        vim.lsp.config("cssls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"cssls"})

        vim.lsp.config("cssmodules_ls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"cssmodules_ls"})

        vim.lsp.config("jsonls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"jsonls"})

        vim.lsp.config("lua_ls", {
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
        })
        vim.lsp.enable({"lua_ls"})

        vim.lsp.config("yamlls", {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                yaml = {
                    schemas = { kubernetes = "*{namespace,policy,middleware,configmap,role,deployment,cron,service,volume,secret,ingress,svc,pvc}*.y*ml" },
                }
            }
        })
        vim.lsp.enable({"yamlls"})

        vim.lsp.config("lemminx", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"lemminx"})

        vim.lsp.config("marksman", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"marksman"})
        vim.lsp.config("html", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"html"})
        vim.lsp.config("ansiblels", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"ansiblels"})
        vim.lsp.config("helm_ls", {
            on_attach = on_attach,
            capabilities = capabilities,
        })
        vim.lsp.enable({"helm_ls"})
    end
}

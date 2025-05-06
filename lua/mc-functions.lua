function mc_mode_ansible()
    vim.filetype.add({
        extension = {
            yml = "yaml.ansible",
            yaml = "yaml.ansible",
        },
    })
    vim.cmd [[
LspStart ansiblels
]]
end

function mc_mode_helm()
    vim.filetype.add({
        extension = {
            yml = "helm",
            yaml = "helm",
        },
    })
    vim.cmd [[
LspStart helm_ls
LspStop yamlls
]]
end

vim.api.nvim_create_user_command(
    'MCModeAnsible',
    mc_mode_ansible,
    {}
)
vim.api.nvim_create_user_command(
    'MCModeHelm',
    mc_mode_helm,
    {}
)

return {
    config = {
        graph_style = "unicode",
        -- Used to generate URL's for branch popup action "pull request".
        git_services = {
            ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
            ["bitbucket.org"] =
            "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
            ["gitlab.com"] =
            "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
            ["gitlab.inpl.work"] =
            "https://gitlab.inpl.work/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        },
    }
}

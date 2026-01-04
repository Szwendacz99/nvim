FROM forgejo.maciej.cloud/pkg/mc-fedora-base as builder

COPY ./build_stage.sh /build_stage.sh

RUN bash /build_stage.sh

FROM forgejo.maciej.cloud/pkg/mc-fedora-base

# required by ansible-config
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# ripgrep and fd-find for telescope 
ENV NEOVIM_PKGS="\
    wget \
    unzip \
    git \
    git-lfs \
    neovim \
    ripgrep \
    fd-find \
    npm \
    tree-sitter-cli \
    wl-clipboard \
    python3-pip \
    cmake"

# libicu - for marksman linter
ENV DNF_LSP_PKGS="shfmt \
    ansible-config \
    libicu \
    ansible \
    ShellCheck \
    ansible-lint \
    ruff \
    nodejs-bash-language-server \
    "

ENV NPM_PKGS="vscode-langservers-extracted \
    dockerfile-language-server-nodejs\
    yaml-language-server \
    @ansible/ansible-language-server \
    markdownlint-cli \
    "

ENV PIP_PKGS="\
    \"python-lsp-server[all]\" \
    pyright \
    mdformat \
    "

ENV BUILD_PKGS="golang"

ENV GENERAL_PKGS="\
    tar \
    gcc"

ENV PYTHON_DEVEL_PKGS="python3"

COPY --from=builder /outputs/ /

COPY . /root/.config/nvim
# install system dependencies
RUN dnf install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${DNF_LSP_PKGS} ${BUILD_PKGS} && \
    npm i -g ${NPM_PKGS} && \
    pip install ${PIP_PKGS} && \
    go install github.com/google/yamlfmt/cmd/yamlfmt@latest && \
    mv /root/go/bin/yamlfmt /usr/local/bin/ && \
    rm -rf /root/go && \
    bash /root/.config/nvim/github_download.sh "https://github.com/mrjosh/helm-ls/releases/download/master/helm_ls_linux_{arch}" /usr/bin/helm_ls && \
    nvim --headless +qa || exit 1 ; \
    dnf remove -y ${BUILD_PKGS} && \
    dnf -y autoremove && \
    dnf clean all && \
    rm -rf /root/.npm/ /root/.cache/

ENTRYPOINT [ "/usr/bin/nvim" ]

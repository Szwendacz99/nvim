FROM forgejo.maciej.cloud/pkg/mc-fedora-base

# required by ansible-config
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# libicu - for marksman linter
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
    ShellCheck \
    tree-sitter-cli \
    wl-clipboard \
    ansible-config \
    ansible \
    libicu"

ENV GENERAL_PKGS="\
    tar \
    gcc"

ENV PYTHON_DEVEL_PKGS="python3"

ENV MASON_PKGS=" \
    bash-language-server \
    css-lsp \
    cssmodules-language-server \
    dockerfile-language-server \
    html-lsp \
    json-lsp \
    marksman \
    jedi-language-server \
    ruff \
    yaml-language-server \
    markdownlint \
    ansible-language-server \
    ansible-lint \
    yamlfmt \
    mdformat \
    shfmt"

ENV MASON_PKGS_NO_ARM="lemminx helm-ls lua-language-server"


COPY . /root/.config/nvim
# install system dependencies
RUN dnf install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${BUILD_ONLY_PKGS} && \
    dnf -y autoremove && \
    dnf clean all && \
    nvim --headless +"MasonInstall ${MASON_PKGS}" +qa || exit 1 ; \
    nvim --headless +"MasonInstall ${MASON_PKGS_NO_ARM}" +qa || true

ENTRYPOINT [ "/usr/bin/nvim" ]

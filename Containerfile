FROM forgejo.maciej.cloud/pkg/mc-fedora-base

# required by ansible-config
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# libicu - for marksman linter
ENV NEOVIM_PKGS="\
    wget \
    unzip \
	git \
	neovim \
    ripgrep \
    fd-find \
    npm \
    ShellCheck \
    tree-sitter-cli \
    wl-clipboard \
    python3-neovim \
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
    eslint-lsp \
    html-lsp \
    intelephense \
    json-lsp \
    marksman \
    phpcs \
    phpstan \
    python-lsp-server \
    jedi-language-server \
    ruff \
    sqlls \
    typescript-language-server \
    yaml-language-server \
    markdownlint \
    ansible-language-server \
    ansible-lint \
    debugpy"

ENV MASON_PKGS_NO_ARM="lemminx helm-ls lua-language-server"


COPY . /root/.config/nvim
# install system dependencies
RUN dnf5 install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${BUILD_ONLY_PKGS} && \
    dnf5 -y autoremove && \
    dnf5 clean all && \
    nvim --headless +"MasonInstall ${MASON_PKGS}" +qa || exit 1 ; \
    nvim --headless +"MasonInstall ${MASON_PKGS_NO_ARM}" +qa || true

ENTRYPOINT [ "/usr/bin/nvim" ]

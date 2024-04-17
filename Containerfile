FROM registry.fedoraproject.org/fedora-minimal

USER root
# required by ansible-config
ENV LANG="C.UTF-8"

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
    ansible-config"

ENV GENERAL_PKGS="\
    bash-completion \
    procps \
    fzf \
    tar"

ENV PYTHON_DEVEL_PKGS="python3"

ENV BUILD_ONLY_PKGS="python3-devel"

ENV MASON_PKGS=" \
    bash-language-server \
    css-lsp \
    cssmodules-language-server \
    dockerfile-language-server \
    eslint-lsp \
    html-lsp \
    intelephense \
    json-lsp \
    lua-language-server \
    marksman \
    phpcs \
    phpstan \
    pyright \
    python-lsp-server \
    sqlls \
    typescript-language-server \
    yaml-language-server \
    markdownlint \
    ansible-language-server \
    ansible-lint \
    debugpy"

ENV MASON_PKGS_NO_ARM="lemminx helm-ls"


COPY . /root/.config/nvim
# install system dependencies
RUN dnf5 install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${BUILD_ONLY_PKGS} && \
    dnf5 remove -y ${BUILD_ONLY_PKGS} && \
    dnf5 -y autoremove && \
    dnf5 clean all && \
    nvim --headless +"MasonInstall ${MASON_PKGS}" +qa || exit 1 ; \
    nvim --headless +"MasonInstall ${MASON_PKGS_NO_ARM}" +qa ; \
    echo '[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash' >> /root/.bashrc

ENTRYPOINT [ "/usr/bin/nvim" ]

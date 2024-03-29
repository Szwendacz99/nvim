FROM registry.fedoraproject.org/fedora-minimal:39

USER root

ENV NEOVIM_PKGS="\
    wget \
    unzip \
	git \
    python3-pip \
	neovim \
    ripgrep \
    fd-find \
    npm \
    ShellCheck \
    tree-sitter-cli \
    wl-clipboard \
    clang"

ENV GENERAL_PKGS="\
    bash-completion \
    procps \
    fzf \
    tar"

ENV PYTHON_DEVEL_PKGS="\
    python3\
    conda"

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
    lemminx \
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
    helm-ls"

ENV PIP_PKGS="pynvim ansible ansible-lint"

COPY . /root/.config/nvim
# install system dependencies
RUN dnf5 install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${BUILD_ONLY_PKGS} && \
    pip install ${PIP_PKGS} && \
    dnf5 remove -y ${BUILD_ONLY_PKGS} && \
    dnf5 -y autoremove && \
    dnf5 clean all && \
    rm /root/.config/nvim/lazy-lock.json; \
    nvim --headless \
    +"MasonInstall ${MASON_PKGS}" \
    +qa ; \
    chown -R root:root /root/.local/share/nvim/mason/packages/sqlls/node_modules/sql-language-server/ && \
    echo '[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash' >> /root/.bashrc

ENTRYPOINT [ "/usr/bin/nvim" ]

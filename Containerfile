FROM registry.fedoraproject.org/fedora:39

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
    fzf"

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
RUN dnf install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${BUILD_ONLY_PKGS} && \
    pip install ${PIP_PKGS} && \
    dnf remove -y ${BUILD_ONLY_PKGS} && \
    dnf -y autoremove && \
    dnf clean all

RUN rm /root/.config/nvim/lazy-lock.json || true
# install lsp and linters using mason
RUN nvim --headless '+TSInstall all' \
    +"MasonInstall ${MASON_PKGS}" \
    +qa ; \
    nvim --headless '+TSInstall all' \
    +qa; \
    nvim --headless '+TSInstall all' \
    +qa; \
    nvim --headless '+TSInstall all' \
    +qa; \
    chown -R root:root /root/.local/share/nvim/mason/packages/sqlls/node_modules/sql-language-server/

RUN echo '[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash' >> /root/.bashrc

ENTRYPOINT [ "/usr/bin/nvim" ]

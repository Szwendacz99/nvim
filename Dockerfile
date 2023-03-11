FROM registry.fedoraproject.org/fedora:37

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
    perlnavigator \
    phpcs \
    phpstan \
    pyright \
    python-lsp-server \
    ruff-lsp \
    sqlls \
    typescript-language-server \
    yaml-language-server \
    markdownlint"

COPY . /root/.config/nvim
# install system dependencies
RUN dnf install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} \
    && dnf clean all
RUN pip install pynvim

RUN rm /root/.config/nvim/lazy-lock.json || true
# install lsp and linters using mason
RUN nvim --headless +TSUpdateSync \
    +"MasonInstall ${MASON_PKGS}" \
    +qa ; chown -R root:root /root/.local/share/nvim/mason/packages/sqlls/node_modules/sql-language-server/node_modules/buffer-equal-constant-time/

RUN echo $'[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash \n\
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash \n\
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash' >> /root/.bashrc

ENTRYPOINT [ "/usr/bin/nvim" ]

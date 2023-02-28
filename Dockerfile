FROM registry.fedoraproject.org/fedora:37

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
    procps"

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
    
# install lsp and linters using mason
RUN nvim --headless +TSUpdateSync \
    +"MasonInstall ${MASON_PKGS}" \
    +qa || true

ENTRYPOINT [ "/usr/bin/nvim" ]

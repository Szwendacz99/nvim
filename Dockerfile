FROM registry.fedoraproject.org/fedora:37

COPY . /root/.config/nvim

# install system dependencies
RUN dnf install -y \
    wget \
    unzip \
	git \
	python3-pip \
	neovim \
    ripgrep \
    fd-find \
    npm \
    tree-sitter-cli \
    wl-clipboard \
    clang \
    && \
    dnf clean all && \
    pip install pynvim
    
# install lsp and liners using mason
RUN nvim --headless +"MasonInstall \
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
    markdownlint" \
    +qa || true

ENTRYPOINT [ "/usr/bin/nvim" ]

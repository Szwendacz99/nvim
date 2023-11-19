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

ENV R_DEVEL_PKGS="R-core R-core-devel cmake"

ENV RUBY_DEVEL_PKGS="ruby-devel rubygems"

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
    ruff-lsp \
    sqlls \
    typescript-language-server \
    yaml-language-server \
    markdownlint\
    ansible-language-server \
    standardrb \
    ruby-lsp \
    solargraph"

ENV PIP_PKGS="pynvim ansible ansible-lint"

COPY . /root/.config/nvim
# install system dependencies
RUN dnf install -y \
    ${GENERAL_PKGS} ${NEOVIM_PKGS} ${PYTHON_DEVEL_PKGS} ${R_DEVEL_PKGS} ${RUBY_DEVEL_PKGS} && \
    R -e 'install.packages("languageserver", repos = "http://cran.us.r-project.org")' && \
    dnf clean all && \
    pip install ${PIP_PKGS}

RUN rm /root/.config/nvim/lazy-lock.json || true
# install lsp and linters using mason
RUN nvim --headless +TSUpdateSync \
    +"MasonInstall ${MASON_PKGS}" \
    +qa ; \
    nvim --headless +TSUpdateSync \
    +qa; \
    nvim --headless +TSUpdateSync \
    +qa; \
    chown -R root:root /root/.local/share/nvim/mason/packages/sqlls/node_modules/sql-language-server/

RUN echo $'[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash \n\
[ -f /usr/share/fzf/shell/key-bindings.bash ] && source /usr/share/fzf/shell/key-bindings.bash \n\
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash' >> /root/.bashrc

ENTRYPOINT [ "/usr/bin/nvim" ]

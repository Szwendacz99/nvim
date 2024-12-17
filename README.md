# My personal **neovim as container** configuration

I made this public so I can easily clone without authentication,\
but since I treat this as a personal use only stuff,\
there can be some(read "a lot of") messy stuff.

Much of this might have been selectively copy pasted from plugin repos.
Those repos are obviously listed in plugin setup part.

**Tested only with rootless podman, docker might require additional setup,
or proper in-container user setup**

## Basic usage of this config

### Host system Setup

Installing host system stuff, currently just fonts (Fedora example):

```bash
sudo dnf install -y \
    dejavu-fonts-all \
    gnu-free-mono-fonts
```

### Image management

#### get latest version from ghcr

```bash
podman pull ghcr.io/szwendacz99/neovim:latest
```

#### or build

```bash
git clone https://github.com/Szwendacz99/nvim && \
podman build -t neovim ./nvim && \
podman tag localhost/neovim:latest localhost/neovim:$(date +"%Y-%m-%dT%H-%M")
```

pack to file with high compression:

```bash
podman save localhost/neovim:latest -o /dev/stdout | \
    xz -z -T 8 -c > neovim$(date +"%Y-%m-%dT%H-%M").tar.xz
```

import file back to local registry:

```bash
podman load -i ./neovim.tar.xz
```

### Image usage examples

basic startup for editing current folder:

```bash
podman run --privileged -it --rm \
    -e XDG_RUNTIME_DIR=/runtime_dir \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY \
    -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions \
    --workdir /data \
    -v "$(pwd):/data:rw" \
        neovim:latest
```

function for opening current dir or some files/folders in temporary container:

```bash
function nvim() {
    # Mount current folder OR folders/files given as parameters, then
    # open neovim. Container will be removed on neovim exit.
    # Mount wayland for clipboard sync.
    # Also pass all parameters to neovim as its arguments.

    for arg in "$@"; do
        if [ -f "$arg" ] || [ -d "$arg" ]; then
            local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$arg:$arg:rw")
            echo "Mounting $arg"
        fi
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path="$(pwd)"

        # use list as a trick to allow paths with spaces
        local MOUNT_FILE=(--workdir "/data$base_path" -v "$base_path:/data$base_path:rw")
    fi

    if [ -f "$HOME/.gitconfig" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$HOME/.gitconfig:/root/.gitconfig:ro")
    fi

    if [ -f "$HOME/.ssh/known_hosts" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$HOME/.ssh/known_hosts:/root/.ssh/known_hosts:ro")
    fi

    if [ -d "$XDG_RUNTIME_DIR" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$XDG_RUNTIME_DIR:/runtime_dir:rw")
    else
        local MOUNT_FILE=("${MOUNT_FILE[@]}" --tmpfs "/runtime_dir")
    fi

    if [ -S "$SSH_AUTH_SOCK" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$SSH_AUTH_SOCK:/runtime_dir/ssh-agent.socket:rw")
    fi

    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions ~/.local/state/nvim/shada

    echo "Files mount options: ${MOUNT_FILE[*]}"
    podman run --privileged -it --rm \
        --shm-size=0 \
        --init \
        --network host \
        -e XDG_RUNTIME_DIR=/runtime_dir \
        -e SSH_AUTH_SOCK=/runtime_dir/ssh-agent.socket \
        -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
        -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
        -v ~/.local/state/nvim/shada/:/root/.local/state/nvim/shada/:rw \
        "${MOUNT_FILE[@]}" \
        neovim:latest "$@"
}
```

If there is need to make more persistent container that will also start with
bash so you can install project dependencies and stuff,
then use function below.

```bash
function nvim_project() {
    # Mount current folder to a container that will not be removed on exit.
    # If you specify some paths as latter parameters, then these paths will
    # be mounted instead of current folder.
    # Also mounts wayland for clipboard sync.

    read -p "Enter container name: " container_name
    for arg in "$@"; do
        if [ -f "$arg" ] || [ -d "$arg" ]; then
            local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$arg:$arg:rw")
            echo "Mounting $arg"
        fi
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path
        base_path="$(pwd)"
        local MOUNT_FILE=(--workdir "/data$base_path" -v "$base_path:/data$base_path:rw")
    fi

    if [ -f "$HOME/.gitconfig" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$HOME/.gitconfig:/root/.gitconfig:ro")
    fi

    if [ -f "$HOME/.ssh/known_hosts" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$HOME/.ssh/known_hosts:/root/.ssh/known_hosts:ro")
    fi

    if [ -d "$XDG_RUNTIME_DIR" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$XDG_RUNTIME_DIR:/runtime_dir:rw")
    else
        local MOUNT_FILE=("${MOUNT_FILE[@]}" --tmpfs "/runtime_dir")
    fi

    if [ -S "$SSH_AUTH_SOCK" ]; then
        local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$SSH_AUTH_SOCK:/runtime_dir/ssh-agent.socket:rw")
    fi

    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions ~/.local/state/nvim/shada

    echo "Files mount options: ${MOUNT_FILE[*]}"
    podman run --privileged -it \
        --shm-size=0 \
        --init \
        --network host \
        -e XDG_RUNTIME_DIR=/runtime_dir \
        -e SSH_AUTH_SOCK=/runtime_dir/ssh-agent.socket \
        -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
        -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY:rw" \
        -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
        -v ~/.local/state/nvim/shada/:/root/.local/state/nvim/shada/:rw \
        "${MOUNT_FILE[@]}" \
        --entrypoint bash \
        "$@" \
        --name "nvim-$container_name" \
        neovim:latest
}
```

This container will not be removed on exit, you can reenter later with:

```bash
podman start -ai {project/container name}
```

## Additional packages to install as needed

**remember to enable them in plugings/nvim-lspconfig.lua**

### Perl lang

For Perl language support run this command to install required packages for
lsp server:

```bash
dnf install -y perl-App-cpanminus;
cpanm PLS;
```

And then in neovim:

```bash
:MasonInstall perlnavigator
```

### Ruby

```bash
dnf install -y ruby-devel rubygems
```

```bash
:MasonInstall standardrb ruby-lsp solargraph
```

### PHP

```bash
:MasonInstall php cs phpstan
```

## Inside vim

```vim
# manage plugins:
:Lazy
```

There is need to make sure your system can display (almost) any unicode
character. Hacked fonts may be needed for filetype icons but there is also
need for a dedicated package with unicode fonts (like unifont-fonts.noarch)
that will have every character missing from default font used in Neovim editor.
Link to hacked fonts:\
[https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)

### General info

#### Mason

Mason installs stuff in `.local/share/nvim/mason/packages` so they are
independent from system stuff, like pip installed python packages.
All that is saved in image, so that is why image is so heavy.

### Commands and keys

#### General

|keys|action|
|----|----|
|\<leader>l|disable (search) highlighting|
|\<leader>cb|Close all buffers (:bufdo bd)|

#### Opened files navigation

|keys|action|
|----|----|
|Ctrl w w| Move to next splitted frame|
|Ctrl w \<arrow> | moving throught splitted frame|
|Ctrl w c | close split|
|Ctrl w v | split vertically|
|Ctrl w s| split horizontally|
|Ctrl w x| swap places of two splits|
|gt |next tab|
|gT| previous tab|
|:tabnew |Create new tab|
|Ctrl+g Ctrl+t |(when in file tree) open selected file in new tab|
|:bd | close buffer|
|:bnext | next buffer|
|:b3 |switch to buffer 3|
|:buffers | list buffers and their numbers |

#### File explorer

|keys|action|
|----|----|
|Ctrl+t | Toggle file explorer when not focused on it|
|f | Toggle filtering when focused on explorer|
|\<leader> n | Move focus to explorer|
|d |Delete selected file|
|rn |Rename file|
|c |add file to clipboard|
|p | paste (file) from clipboard |

#### File searching / Telescope

|keys|action|
|----|----|
|\<leader>ff |Find files|
|\<leader>fg| Live grep|
|\<leader>fb| Buffers|
|\<leader>fh |Help tags|
|Ctrl+/|Show mappings for picker actions (insert mode)|
|Ctrl+q| Open search result list as a dedicated split (quickfix list) (will overwrite previous one created this way in current tab)|
|Ctrl+u | Scroll preview up|
|Ctrl+d | Scroll preview down|
|Ctrl+f|Scroll left in preview window|
|Ctrl+k|Scroll right in preview window|
|Ctrl+x |Open selection as a split|
|Ctrl+v | Open selection as a vsplit|
|Ctrl+t | Open selection in new tab |

##### Usefull Telescope commands

Find files including hidden

```bash
Telescope find_files hidden=true
```

#### Markdown Preview

Mardkown plugin commands:

```bash
:RenderMarkdown*
```

#### Git stuff

##### Neogit

Just run `:Neogit` (shortcut: `<leader>ng`) to launch it, `?` for help, changing parameters is
done usually by adding `-` before letter assigned to specific option.

##### Diffview

Diff log / file history:

```bash
:DiffviewFileHistory
```

Diff log of single file (or dir):

```bash
:DiffviewFileHistory <filename/dirname>
```

##### Telescope git stuff

Commands: `:Telescope git_*`

Bindings:
|keys|action|
|----|----|
|<leader>gs|git_status|
|<leader>gc|git_commits|
|<leader>gb|git_branches|

GitSings provides some commands for displaying git stuff:

```bash
:Gitsigns *

#examples:
:Gitsigns toggle_word_diff
:Gitsigns toggle_linehl
:Gitsigns toggle_numhl
:Gitsigns toggle_signs
```

#### Code editing stuff

|||
|----|----|
|w|jump forward by one word|
|b|jump backward by one word|
|:%s/^original.\\\*/replacement/gc|regex replacing (c is for choice prompt, its optional)|
|Ctrl+q|Visual block select mode|

#### LSP usage

|||
|----|----|
|\<space>q | open list with diagnostics postions|
|\<space>e |open diagnostics floating window|
|\[d | next diagnostic|
|\] | previous diagnostic|
|\<leader>k| open hoover box and enter it|
|\<leader>rn |rename element (function name, etc)|
|\<leader>f| format file|
|gd |go to definition|
|gD| go to declaration|
|\<space>D| go to type definition|
|gi| go to implementation|
|gr| go to references|
|Ctrl+f |scroll down popup with docstring|
|Ctrl+b |scroll up popup with docstring|
|\<leader>wa |add workspace folder|
|\<leader>wr |remove workspace folder|
|\<leader>wl | list workspace folders |

#### LSP diagnostics (custom and trouble.nvim)

|||
|----|----|
|\<leader>vt| switch display of virtual text|
|\<leader>xx| Open diagnostics window|
|gR | lsp references |
|\<space>ca | code action menu |

#### Sessions

To save new session on specific path, just use :SaveSession, then when opening nvim there, without arguments, the session will be restored.

#### Notifications

|||
|----|----|
|:Notifications |show recent notifications|
|:Telescope notify | show recent notifications in telescope gui|

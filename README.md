# My personal **neovim as container** configuration

I made this public so I can easily clone without authentication,  
but since I treat this as a personal use only stuff,  
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
        if [ -f "$arg" ] || [ -d "$arg" ] ; then
            local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$arg:$arg:rw")
            echo "Mounting $arg"
        fi 
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path="$(pwd)"

        # use list as a trick to allow paths with spaces
        local MOUNT_FOLDER=(--workdir "/data$base_path" -v "$base_path:/data$base_path:rw")
    fi
    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions ~/.local/state/nvim/shada/
    touch ~/.local/state/nvim/shada/main.shada

    echo "Files mount options: ${MOUNT_FILE[*]}"
    echo "Folder mount options: ${MOUNT_FOLDER[*]}"
    podman run --privileged -it --rm \
      -e XDG_RUNTIME_DIR=/runtime_dir \
      -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
      -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY:rw" \
      -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
      -v ~/.local/state/nvim/shada/main.shada:/root/.local/state/nvim/shada/main.shada:rw \
      "${MOUNT_FILE[@]}" \
      "${MOUNT_FOLDER[@]}" \
          neovim:latest "$@"
}
```

If there is need to make more persistent container that will also start with
bash so you can install project dependencies and stuff,
then use function below.

```bash
function nvim_project() {
    # Mount current folder to a container that will not be removed on exit.
    # Requires first argument to be a name for the container so it can be
    # easily reentered later.
    # If you specify some paths as latter parameters, then these paths will
    # be mounted instead of current folder.
    # Also mounts wayland for clipboard sync.

    if [ -z "$1" ]; then
        echo "give project/container name as first parameter"
        return 1
    fi
    local container_name="$1"
    shift # skip first parameter as it can be name of a folder/file in
          # current dir so it could try mounting it later
    for arg in "$@"; do
        if [ -f "$arg" ] || [ -d "$arg" ] ; then
            local MOUNT_FILE=("${MOUNT_FILE[@]}" -v "$arg:$arg:rw")
            echo "Mounting $arg"
        fi 
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path
        base_path="$(pwd)"
        local MOUNT_FOLDER=(--workdir "/data$base_path" -v "$base_path:/data$base_path:rw")
    fi
    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions ~/.local/state/nvim/shada/
    touch ~/.local/state/nvim/shada/main.shada

    echo "Files mount options: ${MOUNT_FILE[*]}"
    echo "Folder mount options: ${MOUNT_FOLDER[*]}"
    podman run --privileged -it \
      -e XDG_RUNTIME_DIR=/runtime_dir \
      -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
      -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY:rw" \
      -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
      -v ~/.local/state/nvim/shada/main.shada:/root/.local/state/nvim/shada/main.shada:rw \
      "${MOUNT_FILE[@]}" \
      "${MOUNT_FOLDER[@]}" \
      --entrypoint bash \
      --name $container_name \
          neovim:latest
}
```

This container will not be removed on exit, you can reenter later with:

```bash
podman start -ai {project/container name}
```

## Additional packages to install as needed

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

## Inside vim

```vim
# manage plugins:
:Lazy
```

There is need to make sure your system can display (almost) any unicode
character. Hacked fonts may be needed for filetype icons but there is also
need for a dedicated package with unicode fonts (like unifont-fonts.noarch)
that will have every character missing from default font used in Neovim editor.
Link to hacked fonts:  
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
|\<leader\>l|disable (search) highlighting|

#### Opened files navigation

|keys|action|
|----|----|
|\<leader\> m m| 	open minimap|
|\<leader\> m c |	close minimap|
|\<leader\> m f |	focus minimap|
|Ctrl w w| 	Move to next splitted frame|
|Ctrl w \<arrow\> |	moving throught splitted frame|
|Ctrl w c |	close split|
|Ctrl w v |	split vertically|
|Ctrl w s| 	split horizontally|
|Ctrl w x| 	swap places of two splits|
|gt	|next tab|
|gT| 	previous tab|
|:tabnew 	|Create new tab|
|Ctrl+g Ctrl+t 	|(when in file tree) open selected file in new tab|
|:bd |	close buffer|
|:bnext |	next buffer|
|:b3 	|switch to buffer 3|
|:buffers |	list buffers and their numbers |

#### File explorer

|keys|action|
|----|----|
|Ctrl+t |	Toggle file explorer when not focused on it|
|f |	Toggle filtering when focused on explorer|
|\<leader\> n |	Move focus to explorer|
|d 	|Delete selected file|
|rn 	|Rename file|
|c 	|add file to clipboard|
|p |	paste (file) from clipboard |

#### File searching / Telescope

|keys|action|
|----|----|
|\<leader\>ff	|Find files|
|\<leader\>fg|	Live grep|
|\<leader\>fb|	Buffers|
|\<leader\>fh	|Help tags|
|Ctrl+/|Show mappings for picker actions (insert mode)|
|Ctrl+q|	Open search result list as a dedicated split (quickfix list) (will overwrite previous one created this way in current tab)|
|Ctrl+u |	Scroll preview up|
|Ctrl+d |	Scroll preview down|
|Ctrl+f|Scroll left in preview window|
|Ctrl+k|Scroll right in preview window|
|Ctrl+x 	|Open selection as a split|
|Ctrl+v |	Open selection as a vsplit|
|Ctrl+t |	Open selection in new tab |

#### Markdown Preview

Mardkown Preview plugin commands:

```bash
:MarkdownPreview*
```

#### Git stuff

|keys|action|
|----|----|
Ctrl+g 	show current code chunk changes
|\<leader\>hb |	show full git blame of current line (double use to enter displayed diff)|
|\<leader\>hD	|show splitted blame diff (double use to enter displayed diff)|
|\<leader\>hd|	show splitted diff|
|\<leader\>hr| 	reset hunk|
|\<leader\>hR|	reset whole buffer|
|\<leader\>td|	toggle deleted |

##### Telescope git stuff

Commands: `:Telescope git_*`

Bindings:
|keys|action|
|----|----|
|<leader>gs|git_status|
|<leader>gc|git_commits|
|<leader>gb|git_branches|

Genreal git commands:

```bash
:Git <command>

#Commands with dedicated display
:Git # show nice interactive summary of whole git project state
:Git mergetool, :Git difftool # load their changesets into the quickfix list
:Git blame # this will nicely show \
		   # for every line in separate split
           # Useful shortcuts for blame mode:
           # o - jump to patch or blob in horizontal split
           # A, C, D - different display (lenght) modes
           # g? - other keybindings

#other examples:
:Git add .
:Git commit
```

Nice single file diff viewer:

```
:Gdiffsplit
```

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
|\<space\>q |	open list with diagnostics postions|
|\<space\>e 	|open diagnostics floating window|
|\[d |	next diagnostic|
|\] |	previous diagnostic|
|\<leader\>k| 	open hoover box and enter it|
|\<leader\>rn	|rename element (function name, etc)|
|\<leader\>f|	format file|
|gd	|go to definition|
|gD|	go to declaration|
|\<space\>D|	go to type definition|
|gi|	go to implementation|
|gr|	go to references|
|Ctrl+f	|scroll down popup with docstring|
|Ctrl+b	|scroll up popup with docstring|
|\<leader\>wa 	|add workspace folder|
|\<leader\>wr 	|remove workspace folder|
|\<leader\>wl |	list workspace folders |

#### Lspsaga plugin

Display element (function or whatever?) hierarchy
```bash
:Lspsaga incoming_calls and :Lspsaga outgoing_calls
```
Show avaliable code actions for current line
```bash
:Lspsaga code_action
```
Element definition
```text
Invoke by running :Lspsaga peek_definition and :Lspsaga peek_type_definition. Layout is drawer and is currently the only one available. If you want to go to the definition, use :Lspsaga goto_definition and :Lspsaga goto_type_definition
```
Finder - find current element over all files
```bash
:Lspsaga finder
```
Floating terminal
```bash
:Lspsaga term_toggle
```
Show hover doc (Use `:Lspsaga hover_doc ++keep` if you want to keep the hover window.)
```bash
:Lspsaga hover_doc
```
Outline
```bash
:Lspsaga outline
```
Rename
```bash
:Lspsaga rename
```


#### LSP diagnostics (custom and trouble.nvim)

|||
|----|----|
|\<leader\>vt| 	switch display of virtual text|
|\<leader\>xx| 	Open diagnostics window|
|\<leader\>xw	|workspace diagnostics|
|\<leader\>xd	|document diagnostics|
|\<leader\>xl|	loclist|
|\<leader\>xq	|quickfix|
|gR |	lsp references |

#### Sessions

To save new session on specific path, just use :SaveSession, then when opening nvim there, without arguments, the session will be restored.

#### Notifications

|||
|----|----|
|:Notifications 	|show recent notifications|
|:Telescope notify |	show recent notifications in telescope gui|

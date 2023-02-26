# My personal **neovim as container** configuration

I made this public so I can easily clone without authentication,  
but since I treat this as a personal use only stuff,  
there can be some(read "a lot of") messy stuff.

Much of this might have been selectively copy pasted from plugin repos.
Those repos are obviously listed in plugin setup part.

# Basic usage of this config

<p class="callout warning">**Tested only with rootless podman, docker might require additional setup, or proper in-container user setup**</p>

### Host system Setup

Installing host system stuff, currently just fonts (Fedora example):

```bash
sudo dnf install -y \
    dejavu-fonts-all \
    gnu-free-mono-fonts
```

##### Image management:

build:

```bash
git clone https://github.com/Szwendacz99/nvim && \
podman build -t neovim ./nvim
```

pack to file with high compression:

```bash
podman save localhost/neovim:latest -o /dev/stdout | xz -z -9 -e -c > neovim.tar.xz
```

import file back to local registry:

```bash
podman load -i ./neovim.tar.xz
```

##### Image usage examples  


basic startup for editing current folder:

```bash
podman run --privileged -it --rm \
    -e XDG_RUNTIME_DIR=/runtime_dir \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY \
    --workdir /data \
    -v "./:/data:rw" \
    	neovim:latest
```

function to run neovim container easily,  
allowing passing parameters and mounting files:

```bash
function nvim() {
    if [ $1 ] && [ -f $1 ]; then
        MOUNT_FILE="-v "$1:$1"";
        echo "mounting file $1";
   	else
        MOUNT_FOLDER="--workdir /data -v ./:/data:rw"
    fi
    podman run --privileged -it --rm \
      -e XDG_RUNTIME_DIR=/runtime_dir \
      -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
      -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY \
      -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions \
      $MOUNT_FILE \
      $MOUNT_FOLDER \
          neovim:latest "$@"
}
```

##### Inside vim

```
# manage plugins:
:Lazy
```

There is need to make sure your system can display (almost) any unicode character. Hacked fonts may be needed for filetype icons but there is also need for a dedicated package with unicode fonts (like unifont-fonts.noarch) that will have every character missing from default font used in Neovim editor. Link to hacked fonts:  
[https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)

#### General info

##### Mason:

Mason installs stuff in `.local/share/nvim/mason/packages` so they are independent from system stuff, like pip installed python packages. All that is saved in image, so that is why image is so heavy.

### Usage

##### root perms when editing

```bash
# Re-open a current file with sudo
:SudaRead
# Open /etc/sudoers with sudo
:SudaRead /etc/sudoers
```

```bash
# Forcedly save a current file with sudo
:SudaWrite
# Write contents to /etc/profile
:SudaWrite /etc/profile
```

##### General

<table border="1" id="bkmrk-%3Cleader%3El-disable-%28s" style="border-collapse: collapse; width: 100%;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>&lt;leader&gt;l  
</td><td>disable (search) highlighting</td></tr></tbody></table>

##### Opened files navigation:

<table border="1" id="bkmrk-ctrl-w-%3Carrow%3E-movin" style="border-collapse: collapse; width: 100%; height: 506.6px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt; m m  
</td><td style="height: 29.8px;">open minimap  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt; m c  
</td><td style="height: 29.8px;">close minimap  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt; m f  
</td><td style="height: 29.8px;">focus minimap  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w w  
</td><td style="height: 29.8px;">Move to next splitted frame  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w &lt;arrow&gt;  
</td><td style="height: 29.8px;">moving throught splitted frame  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w c  
</td><td style="height: 29.8px;">close split</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w v  
</td><td style="height: 29.8px;">split vertically  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w s  
</td><td style="height: 29.8px;">split horizontally  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w x  
</td><td style="height: 29.8px;">swap places of two splits  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gt</td><td style="height: 29.8px;">next tab</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gT  
</td><td style="height: 29.8px;">previous tab  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:tabnew  
</td><td style="height: 29.8px;">Create new tab  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+g Ctrl+t  
</td><td style="height: 29.8px;">(when in file tree) open selected file in new tab  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:bd  
</td><td style="height: 29.8px;">close buffer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:bnext  
</td><td style="height: 29.8px;">next buffer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:b3  
</td><td style="height: 29.8px;">switch to buffer 3  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:buffers  
</td><td style="height: 29.8px;">list buffers and their numbers  
</td></tr></tbody></table>

##### File explorer:

<table border="1" id="bkmrk-ctrl%2Bt-toggle-file-e" style="border-collapse: collapse; width: 100%; height: 327.8px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+t  
</td><td style="height: 29.8px;">Toggle file explorer when not focused on it  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">f  
</td><td style="height: 29.8px;">Toggle filtering when focused on explorer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt; n  
</td><td style="height: 29.8px;">Move focus to explorer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">d  
</td><td style="height: 29.8px;">Delete selected file  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">rn  
</td><td style="height: 29.8px;">Rename file  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">c  
</td><td style="height: 29.8px;">add file to clipboard  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">p  
</td><td style="height: 29.8px;">paste (file) from clipboard  
</td></tr></tbody></table>

##### File searching / Telescope

<table border="1" id="bkmrk-%3Cleader%3Eff-find-file" style="border-collapse: collapse; width: 100%;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>&lt;leader&gt;ff</td><td>Find files  
</td></tr><tr><td>&lt;leader&gt;fg</td><td>Live grep  
</td></tr><tr><td>&lt;leader&gt;fb</td><td>Buffers  
</td></tr><tr><td>&lt;leader&gt;fh</td><td>Help tags</td></tr><tr><td>Ctrl+q</td><td>Open search result list as a dedicated split (quickfix list) (will overwrite previous one created this way in current tab)</td></tr><tr><td>Ctrl+u  
</td><td>Scroll preview up  
</td></tr><tr><td>Ctrl+d  
</td><td>Scroll preview down  
</td></tr><tr><td>Ctrl+x  
</td><td>Open selection as a split  
</td></tr><tr><td>Ctrl+v  
</td><td>Open selection as a vsplit  
</td></tr><tr><td>Ctrl+t  
</td><td>Open selection in new tab  
</td></tr></tbody></table>

##### Git stuff

<table border="1" id="bkmrk-ctrl%2Bs-show-current-" style="border-collapse: collapse; width: 100%; height: 208.6px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+g  
</td><td style="height: 29.8px;">show current code chunk changes</td></tr><tr><td>&lt;leader&gt;hb  
</td><td>show full git blame of current line (double use to enter displayed diff)  
</td></tr><tr><td>&lt;leader&gt;hD</td><td>show splitted blame diff (double use to enter displayed diff)  
</td></tr><tr><td>&lt;leader&gt;hd</td><td>show splitted diff</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;hr  
</td><td style="height: 29.8px;">reset hunk  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;hR</td><td style="height: 29.8px;">reset whole buffer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;td</td><td style="height: 29.8px;">toggle deleted  
</td></tr></tbody></table>

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

##### Code editing stuff

<table border="1" id="bkmrk-%3Cleader%3Ern-rename-el" style="border-collapse: collapse; width: 100%; height: 387.4px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">w  
</td><td style="height: 29.8px;">jump forward by one word  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">b  
</td><td style="height: 29.8px;">jump backward by one word  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:%s/^original.\*/replacement/gc  
</td><td style="height: 29.8px;">regex replacing (c is for choice prompt, its optional)  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+q  
</td><td style="height: 29.8px;">Visual block select mode  
</td></tr></tbody></table>

##### LSP usage  


<table border="1" id="bkmrk-%3Cspace%3Eq-open-list-w" style="border-collapse: collapse; width: 100%; height: 476.8px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;space&gt;q  
</td><td style="height: 29.8px;">open list with diagnostics postions  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;space&gt;e  
</td><td style="height: 29.8px;">open diagnostics floating window  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">\[d  
</td><td style="height: 29.8px;">next diagnostic  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">\]  
</td><td style="height: 29.8px;">previous diagnostic  
</td></tr><tr><td>&lt;leader&gt;k  
</td><td>open hoover box and enter it  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;rn</td><td style="height: 29.8px;">rename element (function name, etc):</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;f</td><td style="height: 29.8px;">format file  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gd</td><td style="height: 29.8px;">go to definition</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gD</td><td style="height: 29.8px;">go to declaration</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;space&gt;D</td><td style="height: 29.8px;">go to type definition</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gi</td><td style="height: 29.8px;">go to implementation</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gr</td><td style="height: 29.8px;">go to references</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+f</td><td style="height: 29.8px;">scroll down popup with docstring</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+b</td><td style="height: 29.8px;">scroll up popup with docstring</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;wa  
</td><td style="height: 29.8px;">add workspace folder</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;wr  
</td><td style="height: 29.8px;">remove workspace folder  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;wl  
</td><td style="height: 29.8px;">list workspace folders  
</td></tr></tbody></table>

##### LSP diagnostics, etc:  


<table border="1" id="bkmrk-%3Cleader%3Exx-open-diag" style="border-collapse: collapse; width: 100%; height: 178.8px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;xx  
</td><td style="height: 29.8px;">Open diagnostics window  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;xw</td><td style="height: 29.8px;">workspace diagnostics  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;xd</td><td style="height: 29.8px;">document diagnostics  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;xl</td><td style="height: 29.8px;">loclist</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;xq</td><td style="height: 29.8px;">quickfix</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gR  
</td><td style="height: 29.8px;">lsp references  
</td></tr></tbody></table>

##### Sessions

To save **new** session on specific path, just use `:SaveSession`, then when opening nvim there, without arguments, the session will be restored.

##### Notifications

<table border="1" id="bkmrk-%3Anotifications-show-" style="border-collapse: collapse; width: 100%;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>:Notifications  
</td><td>show recent notifications  
</td></tr><tr><td>:Telescope notify  
</td><td>show recent notifications in telescope gui</td></tr></tbody></table>

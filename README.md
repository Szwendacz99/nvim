# My personal nvim configuration

I made this public so I can easily clone without authentication,  
but since I treat this as a personal use only stuff,  
there can be some(read "a lot of") messy stuff.
  
Much of this might have been selectively copy pasted from plugin repos.
Those repos are obviously listed in plugin setup part.

# Neovim

Repo: [https://github.com/Szwendacz99/nvim](https://github.com/Szwendacz99/nvim)

### First Time Setup

Installing system stuff (Fedora example):

```bash
sudo dnf install \
	neovim \
    ripgrep \
    fd-find \
    nodejs-bash-language-server \
    tree-sitter-cli \
    wl-clipboard

pip install \
	pynvim \
    'pylama[all]' \
    flake8 \
    jedi \
    bandit \
    yapf \
    rope
    
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

#####   


##### Inside vim

```
:PlugInstall
:CocInstall coc-git coc-pyright coc-sh coc-json coc-css coc-tsserver coc-eslint coc-prettier coc-snippets coc-yaml
```

Hacked font is needed to display file type icons:  
[https://www.nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads)

### Usage

##### Opened files navigation:

<table border="1" id="bkmrk-ctrl-w-%3Carrow%3E-movin" style="border-collapse: collapse; width: 100%; height: 178.8px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>Ctrl w w  
</td><td>Move to next splitted frame  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w &lt;arrow&gt;  
</td><td style="height: 29.8px;">moving throught splitted frame  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w c  
</td><td style="height: 29.8px;">close split</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w v  
</td><td style="height: 29.8px;">split vertically  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl w s  
</td><td style="height: 29.8px;">split horizontally  
</td></tr><tr><td>Ctrl w x  
</td><td>swap places of two splits  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gt</td><td style="height: 29.8px;">next tab</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gT  
</td><td style="height: 29.8px;">previous tab  
</td></tr><tr><td>:tabnew  
</td><td>Create new tab  
</td></tr><tr><td>Ctrl g t  
</td><td>(when in file tree) open selected file in new tab  
</td></tr></tbody></table>

##### File explorer:

<table border="1" id="bkmrk-ctrl%2Bt-toggle-file-e" style="border-collapse: collapse; width: 100%; height: 89.4px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+t  
</td><td style="height: 29.8px;">Toggle file explorer when not focused on it  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">f  
</td><td style="height: 29.8px;">Toggle filtering when focused on explorer  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt; n  
</td><td style="height: 29.8px;">Move focus to explorer  
</td></tr><tr><td>d  
</td><td>Delete selected file  
</td></tr><tr><td>rn  
</td><td>Rename file  
</td></tr><tr><td>c  
</td><td>add file to clipboard  
</td></tr><tr><td>p  
</td><td>paste (file) from clipboard  
</td></tr></tbody></table>

##### File searching / Telescope

<table border="1" id="bkmrk-%3Cleader%3Eff-find-file" style="border-collapse: collapse; width: 100%;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>&lt;leader&gt;ff</td><td>Find files  
</td></tr><tr><td>&lt;leader&gt;fg</td><td>Live grep  
</td></tr><tr><td>&lt;leader&gt;fb</td><td>Buffers  
</td></tr><tr><td>&lt;leader&gt;fh</td><td>Help tags</td></tr></tbody></table>

##### Git stuff

<table border="1" id="bkmrk-ctrl%2Bs-show-current-" style="border-collapse: collapse; width: 100%;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr><td>Ctrl+g  
</td><td>show current code chunk changes</td></tr></tbody></table>

Genreal git commands:

```bash
:Git <command>

#example:
:Git blame # this will nicely show \
		   # for every line in separate split
:Git add .
```

Nice single file diff viewer:

```
:Gdiffsplit
```

coc-git provides some commands for git:

```bash
:CocCommand git.<command>

#examples:
:CocCommand git.chunkUndo
:CocCommand git.showCommit
:CocCommand git.showBlameDoc
```

##### Code editing stuff  


<table border="1" id="bkmrk-%3Cleader%3Ern-rename-el" style="border-collapse: collapse; width: 100%; height: 298px;"><colgroup><col style="width: 50%;"></col><col style="width: 50%;"></col></colgroup><tbody><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;rn</td><td style="height: 29.8px;">rename element (function name, etc):</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">&lt;leader&gt;ft</td><td style="height: 29.8px;">format code  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gd  
</td><td style="height: 29.8px;">go to definition  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gy  
</td><td style="height: 29.8px;">go to type definition</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gi  
</td><td style="height: 29.8px;">go to implementation  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">gr  
</td><td style="height: 29.8px;">go to references  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">:%s/^original.\*/replacement/gc  
</td><td style="height: 29.8px;">regex replacing (c is for choice prompt, its optional)  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+f  
</td><td style="height: 29.8px;">scroll down popup with docstring  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">Ctrl+b  
</td><td style="height: 29.8px;">scroll up popup with docstring  
</td></tr><tr style="height: 29.8px;"><td style="height: 29.8px;">ZZ  
</td><td style="height: 29.8px;">same as :wq  
</td></tr><tr><td>Ctrl+q  
</td><td>Visual block mode  
</td></tr></tbody></table>

##### Sessions

To save **new** session on specific path, just use `:SaveSession`, then when opening nvim there, without arguments, the session will be restored.

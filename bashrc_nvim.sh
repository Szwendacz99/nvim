#!/bin/bash

function nvim() {
    # Mount current folder OR folders/files given as parameters, then
    # open neovim. Container will be removed on neovim exit.
    # Mount wayland for clipboard sync.
    # Also pass all parameters to neovim as its arguments.

    for arg in "$@"; do
        if [ -f "$arg" ] || [ -d "$arg" ] ; then
                local MOUNT_FILE="$MOUNT_FILE -v "$arg:$arg:rw""
                echo "Mounting $arg"
        fi 
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path
        base_path="$(pwd)"
        local MOUNT_FOLDER="--workdir /data$base_path -v "$base_path:/data$base_path:rw""
    fi
    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions

    podman run --privileged -it --rm \
      -e XDG_RUNTIME_DIR=/runtime_dir \
      -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
      -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY:rw" \
      -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
      $MOUNT_FILE \
      $MOUNT_FOLDER \
          neovim:latest "$@"
}

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
    local container_name
    container_name="$1"
    shift # skip first parameter as it can be name of a folder/file in
          # current dir so it could try mounting it later
    for arg in "$@"; do
        if [ -f "$arg" ] || [ -d "$arg" ] ; then
                local MOUNT_FILE="$MOUNT_FILE -v "$arg:$arg:rw""
                echo "Mounting $arg"
        fi 
    done
    if [ -z "$MOUNT_FILE" ]; then
        # mount current workdir if no arguments with path
        # mount on base_path to make sessions saving work
        local base_path
        base_path="$(pwd)"
        local MOUNT_FOLDER="--workdir /data$base_path -v "$base_path:/data$base_path:rw""
    fi
    # make sure there is a folder for sessions on default path
    mkdir -p ~/.local/share/nvim/sessions

    podman run --privileged -it \
      -e XDG_RUNTIME_DIR=/runtime_dir \
      -e WAYLAND_DISPLAY="$WAYLAND_DISPLAY" \
      -v "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/runtime_dir/$WAYLAND_DISPLAY:rw" \
      -v ~/.local/share/nvim/sessions:/root/.local/share/nvim/sessions:rw \
      $MOUNT_FILE \
      $MOUNT_FOLDER \
      --entrypoint bash \
      --name $container_name \
          neovim:latest
}

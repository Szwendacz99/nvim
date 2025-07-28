#!/bin/bash

set -euo pipefail

rm -rf /outputs /lua-language-server || true

mkdir /outputs

dnf install -y git libstdc++-static gcc ninja-build g++

cd /

git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server

./make.sh

mv /lua-language-server/build/bin/* /outputs/

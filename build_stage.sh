#!/bin/bash

set -euo pipefail

rm -rf /outputs /lua-language-server || true

mkdir /outputs

dnf install -y git libstdc++-static gcc ninja-build g++

cd /

git clone https://github.com/LuaLS/lua-language-server
cd lua-language-server

./make.sh

mkdir -p /outputs/usr/local/bin

cp -r script /outputs/usr/local/
cp main.lua /outputs/usr/local/
cp debugger.lua /outputs/usr/usr/local/
mv /lua-language-server/bin/* /outputs/usr/local/bin/

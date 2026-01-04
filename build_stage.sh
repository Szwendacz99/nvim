#!/bin/bash

set -euo pipefail

rm -rf /outputs /lua-language-server /marksman || true

mkdir /outputs

dnf install -y git libstdc++-static gcc ninja-build g++ dotnet-sdk-8.0 dotnet-sdk-9.0

cd /

git clone https://github.com/LuaLS/lua-language-server
git clone https://github.com/artempyanykh/marksman.git

cd lua-language-server
chmod +x make.sh
./make.sh

cd /marksman
make install

mkdir -p /outputs/usr/local/bin

# marksman
mv ~/.local/bin/marksman /outputs/usr/local/bin/
lua-language-server
cd /lua-language-server
cp -r script /outputs/usr/local/
cp -r locale /outputs/usr/local/
cp main.lua /outputs/usr/local/
cp debugger.lua /outputs/usr/local/
mv /lua-language-server/bin/* /outputs/usr/local/bin/

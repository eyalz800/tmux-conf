#!/bin/bash

set -e

if [ -e $SUDO_USER ]; then
    sudo -E ./install.sh
    exit
fi

apt update
apt install -y \
    build-essential gcc autotools-dev automake libncurses5-dev libncursesw5-dev libevent-dev xclip bison pkg-config

rm -rf tmux
git clone https://github.com/tmux/tmux.git
cd tmux
git reset --hard 022d0210c5afa4e516183bf19715316ccca5d240
./autogen.sh
./configure
make -j
make install
cd ..
rm -rf tmux

cp .tmux.conf ~/.tmux.conf
chown $SUDO_USER:$SUDO_GID ~/.tmux.conf

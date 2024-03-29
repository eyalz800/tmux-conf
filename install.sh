#!/bin/bash

set -e

if [ -x "$(command -v brew)" ]; then
	brew install tmux
    cp .tmux.conf ~/.tmux.conf
else
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
    git reset --hard 9f9156c0303ad9c50fd44e0561ef0f5bb21a418b
    ./autogen.sh
    ./configure
    make -j
    make install
    cd ..
    rm -rf tmux

    cp .tmux.conf ~/.tmux.conf
    chown $SUDO_USER:$SUDO_GID ~/.tmux.conf
fi


#!/bin/bash

set -e

if [ -x "$(command -v brew)" ]; then
	brew install tmux
    cp .tmux.conf ~/.tmux.conf
else
    if [ "$(id -u)" -ne 0 ]; then
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

    # Do not rely on $HOME while running as root, sudo may reset it to /root
    # depending on the sudo implementation and configuration. Resolve the
    # invoking user's home directory explicitly instead.
    if [ -n "$SUDO_USER" ]; then
        user_home=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    else
        user_home=$HOME
    fi

    cp .tmux.conf "$user_home/.tmux.conf"
    if [ -n "$SUDO_USER" ]; then
        chown "$SUDO_USER:$SUDO_GID" "$user_home/.tmux.conf"
    fi
fi


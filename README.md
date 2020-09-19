tmux-conf
=========

Add the following lines to your  ~/.bashrc file:
```
printf "\e[?2004l"

if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    if [ -z "$DISPLAY" ]; then
        echo "X DISPLAY not available"
    fi
    tmux a -t "main"
    if [ $? != 0 ]; then
        tmux new-session -s "main"
    fi
fi
```

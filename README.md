tmux-conf
=========

Screenshots
-----------
<img src="screenshots/image1.png">

Installation
------------
* Install tmux:
```
sudo ./install.sh
```

* Add the following lines to your ~/.bashrc file for automatic activation:
```
if [[ -z "$TMUX" ]]; then
    tmux a -t "main"
    if [ $? != 0 ]; then
        tmux new-session -s "main"
    fi
else
    export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
fi
```

* Add the following lines to your ~/.bashrc file for automatic activation in remote sessions only:
```
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux a -t "main"
    if [ $? != 0 ]; then
        tmux new-session -s "main"
    fi
else
    export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
fi
```

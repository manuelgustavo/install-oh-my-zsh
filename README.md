# install-oh-my-zsh

Script to install easily installoh-my-zsh with my preferred settings.

> Tested against Ubuntu 22.04.

The **bash** script `ubuntu.sh` is designed to offer minimal user interaction and install the following on Ubuntu.

Running it in 1 line:

``` bash
sudo apt update && sudo apt install -y -q wget && /bin/bash -c "$(wget --no-cache -O- https://raw.githubusercontent.com/manuelgustavo/install-oh-my-zsh/main/install-oh-my-zsh.sh)"
```

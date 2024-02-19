#!/bin/bash
#set -x
set -euo pipefail

installed=""
not_installed=""

install_oh_my_zsh()
{
    if [[ ! -d "$HOME/.oh-my-zsh" ]]
    then
    {
        echo "Installing oh-my-zsh"
        wget --no-cache -O "$HOME/.zshrc" "https://raw.githubusercontent.com/manuelgustavo/ubuntu-setup/main/.zshrc"
        sudo apt install -y -q zsh fonts-powerline
        # chsh -s "$(which zsh)"
        #sudo apt install -y -q zsh-autosuggestions zsh-syntax-highlighting
        # install oh-my-zsh
        rm -fr "$HOME/.oh-my-zsh"
        sh -c "$(wget --no-cache -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended --skip-chsh --keep-zshrc"
        git clone --quiet --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
        git clone --quiet --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone --quiet --depth 1 https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
        
        # Change the default shell
        sudo sed -i -E "s/($USER.*)(bash)/\1zsh/" /etc/passwd
        sudo update-passwd
        installed+="oh-my-zsh\n"
    }
    else
    {
        echo "If you want to install oh-my-zsh, delete the ~/.oh-my-zsh directory"
        not_installed+="oh-my-zsh\n"
    }
    fi
}

main()
{
    sudo apt update -q 
    sudo apt install -y -q git wget

    install_oh_my_zsh

    echo .
    echo .
    echo .
    echo "SCRIPT SUCCESS!"
    echo .
    echo "-------------------- Summary --------------------"
    if [[ -n "${installed}" ]]
    then
    {
        echo "Installed:"
        printf "${installed}"
    }
    fi
    echo "-------------------------------------------------"
    if [[ -n "${not_installed}" ]]
    then
    {
        echo "Skipped:"
        printf "${not_installed}"
    }
    fi
    echo "-------------------------------------------------"
    echo .
    echo .
    echo "It's recommended to log-off and log-on again!"
}

main "$@"
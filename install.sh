#!/usr/bin/env bash
# Autor:      João "Aktoch" Florencio
# github      https://www.github.com/Aktoch

APPS=(
    ffmpeg
    chrome-gnome-shell
    flameshot
    fonts-hack-ttf
    fonts-powerline
    git
    gnome-tweaks
    nmap
    vim
    neovim
    powerline
    python3
    python3-pip
    tilix
    transmission
    tmux
    virtualbox
    vagrant    
    vlc
    zsh
    fdupes
    neofetch
    steam
    brave-browser
    code
)


ssh-keygen -t ed25519 -a 100

sudo apt install apt-transport-https curl gnupg -y

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

sudo apt update    
for counter in ${APPS[@]}; do
  sudo apt install -y "$counter"
done

#!/usr/bin/env bash
# Autor:      João "Aktoch" Florencio
# github      https://www.github.com/Aktoch
URL=(
    'https://linux.wps.com/'
    'https://my.vmware.com/en/web/vmware/downloads/info/slug/desktop_end_user_computing/vmware_workstation_player/16_0'
    "https://discord.com/"
    'https://www.insynchq.com/'
    'https://extensions.gnome.org/extension/1160/dash-to-panel/'
    'https://extensions.gnome.org/extension/1319/gsconnect/'
    'https://extensions.gnome.org/extension/2120/sound-percentage/'
    'https://extensions.gnome.org/extension/906/sound-output-device-chooser/'
)
BOX=(
    debian/buster64
    kalilinux/rolling
    hashicorp/bionic64
)
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
    vagrant
    virtualbox
    vlc
    zsh
    fdupes
    neofetch
    steam
    apt-transport-https
    curl
    gnupg
    brave-browser
    code
)
# ------------------------------- FUNCTIONS ----------------------------------------- #
Sshkey() {
    ssh-keygen -t ed25519 -a 100
}
Ppa() {
    xargs -I % sudo add-apt-repository % <<EOF
  ppa:deadsnakes/ppa
EOF
}
Brave() {
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
}
Vscode() {
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
}
Snap() {
    sudo snap install discord powershell skype sosumi thunderbird onlyoffice-desktopeditors
}
Vagrant() {
    for ivagr in ${BOX[@]}; do
        vagrant box add "$ivagr" --provider virtualbox
    done
}
Install() {
    sudo dpkg --add-architecture i386    
    sudo apt update    
    for counter in ${APPS[@]}; do
        sudo apt install -y "$counter"
    done
}
# ------------------------------- EXECUTION ----------------------------------------- #
Sshkey
Ppa
Brave
Vscode
Install
Snap
Vagrant
sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
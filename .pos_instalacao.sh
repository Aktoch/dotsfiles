#!/usr/bin/env bash
# Autor:      João "Aktoch" Florencio
# github      https://www.github.com/Aktoch
##URL to open
URL=(
    'https://linux.wps.com/'
    'https://my.vmware.com/en/web/vmware/downloads/details?downloadGroup=PLAYER-1610&productId=1039&rPId=55792'
    "https://discord.com/"
    'https://www.insynchq.com/'
    'https://extensions.gnome.org/extension/1160/dash-to-panel/'
    'https://extensions.gnome.org/extension/1319/gsconnect/'
    'https://extensions.gnome.org/extension/2120/sound-percentage/'
    'https://extensions.gnome.org/extension/906/sound-output-device-chooser/'
)
#Packages installed by APT
PACKAGES=(
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
    python-is-python3
    snapd
    steam
    tilix
    transmission
    tmux
    vagrant
    virtualbox
    vlc
    zsh
    fdupes
    neofetch
)
BOX=(
    debian/buster64
    kalilinux/rolling
    hashicorp/bionic64
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
Install() {
    sudo dpkg --add-architecture i386
    sudo apt remove snapd --purge -y
    for name_program in ${PACKAGES[@]}; do
        if ! dpkg -l | grep -q $name_program; then
            sudo apt install "$name_program" -y
        else
            echo "[INSTALLED] - $name_program"
        fi
    done
}
Vscode() {
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code
}
Brave() {
    sudo apt install apt-transport-https curl gnupg
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
}
Ohmyzsh() {
    sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}
Snap() {
    sudo snap install discord
}
Vagrant() {
    for ivagr in ${BOX[@]}; do
        vagrant box add "$ivagr" --provider virtualbox
    done
}
Openlinks() {
    firefox "${URL[@]}"
}
# ------------------------------- EXECUTION ----------------------------------------- #
sudo apt update
#Sshkey
Ppa
Install
# Vscode
# Brave
# Ohmyzsh
# Snap
#Vagrant
#OpenLinks
#sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
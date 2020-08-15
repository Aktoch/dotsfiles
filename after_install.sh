#!/usr/bin/env bash
# ----------------------------- VARIÁVEIS ----------------------------- #
#PPAs
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_PYTHON="ppa:deadsnakes/ppa"
#URLS testa depois para impremetar um vetor.
URL_DOWNLOAD=(
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
    https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.2.5.40859-focal_amd64.deb
)
URL_GIT_ICONS="https://github.com/daniruiz/flat-remix"
URL_GIT_THEMES="https://github.com/daniruiz/flat-remix-gtk"
#Pasta que serao que usadas.
DIR_DOWNLOAD="$HOME/Downloads/apps"
THEMES="$HOME/projects"
#Programas que serão instalados / alterar quem quiser
PROGRAMAS_PARA_INSTALAR=(
    chrome-gnome-shell
    flameshot
    fonts-hack-ttf
    fonts-powerline
    git
    gnome-software
    gnome-tweaks
    net-tools
    nmap
    nvim
    piper
    powerline
    python3
    python3-pip
    python-is-python3
    snapd
    steam
    tilix
    tmux
    vagrant
    vim
    virtualbox
    vlc
    zsh
)
# ----------------------------- REQUISITOS ----------------------------- #
#Adicionando a x32
sudo dpkg --add-architecture i386
sudo apt update -y
#adicionando o ppa do python
sudo apt-add-repository "$PPA_PYTHON" -y

# ----------------------------- EXECUÇÃO ----------------------------- #
sudo apt update -y
#verificando se tem a variavem or not e instalando o lutris.
[[ "$*" = "-lutris"]] && sudo add-apt-repository "$PPA_LUTRIS" -y && sudo apt install-y lutris

mkdir -p "$DIR_DOWNLOAD"
for idown in ${URL[@]}; do
wget -c "$idown" -P "$DIR_DOWNLOAD"
done

#instalando os .deb baixado
sudo dpkg -i $DIR_DOWNLOAD/*.deb
sudo apt install -f -y

# Instalar programas no apt
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
    if ! dpkg -l | grep -q $nome_do_programa; then
        sudo apt install "$nome_do_programa" -y
    else
        echo "[INSTALADO] - $nome_do_programa"
    fi
done

## Instalando pacotes Flatpak and Snap ##
sudo snap install code --classic
sudo snap install discord
#sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#flatpak install -y flathub com.discordapp.Discord
#flatpak install -y flathub com.visualstudio.code

#----------------themes-----------------#
#Em fazer de teste
mkdir "$THEMES"
mkdir -p ~/.icons && mkdir -p ~/.themes
cd "$DIR_DOWNLOAD"
git clone "$URL_GIT_ICONS"
git clone "$URL_GIT_THEMES"
cp -r flat-remix/Flat-Remix* ~/.icons/ && cp -r flat-remix-gtk/Flat-Remix-GTK* ~/.themes

#git clone "$DOTFILES"

#OH my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Vagrant box add
vagrant box add kalilinux/rolling
vagrant box add hashicorp/bionic64
vagrant box add debian/buster64
vagrant box add centos/7

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo snap remove snap-store
sudo apt update && sudo apt dist-upgrade -y
sudo apt autoclean
sudo apt autoremove -y
rm -r "$DIR_DOWNLOAD"

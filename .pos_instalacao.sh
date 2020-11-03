#!/usr/bin/env bash
#
# after_INSTALAR.sh - Pos-instalação do Ubuntu 20.04
#
# github      https://www.github.com/Aktoch
# Autor:      João "Aktoch" Florencio
# Manutenção: João "Aktoch" Florencio
#
#    Observações usuario que executar precisa de tem permisão de sudo
#    Exemplos:
#    $ ./after_INSTALAR.sh -i
#    Neste exemplo o script será executado no modo de instalação que instala tudo.
# Testado em:
#   bash  5.0.17
#  Para uso
#  mude as variavel:
# ppa recomendo saber um pouco para pode adicionar os ppa nessa variavel
# PROGRAMAS_PARA_INSTALAR sao os programas que serao instalados pelo apt
# URL_DOWNLOAD sao links dos pacotes .deb que o script ira baixar é instalar /
# (pacotes .deb pode ser colocados na pasta indicada pela variavel "DIR_DOWNLOAD" para serem instalados)
# BOXES sao as boxes do vagrant(pode ser deixado em branco caso nao use)
# quando rodado sem paramentos ele ira rodar um apt update.
# ------------------------------- VARIÁVEIS ----------------------------------------- #
MENSAGEM_USO="
    $(basename $0) - Para pos instalação do ubuntu 20.04
    $(basename $0) - [OPÇÕES]

    -h - Menu de ajuda
    -i - Todos a baixo menos o lutris
    -a - instala somente os pacotes do apt
    -d - instala somenteos pacotes .deb    
    -l - instala somente o lutris
    -p - Adiciona as PPA'S
    -t - Update e Upgrade.
    -v - Adicinar as vagrant boxes
"
MENSAGEM_ERRO="
     Nenhuma opção informada valida verifique o -h
"
DIR_DOWNLOAD="$HOME/Downloads"
#PPA's
PPA_LUTRIS="ppa:lutris-team/lutris"
PPA_PYTHON="ppa:deadsnakes/ppa"
#Chaves flags.
KEY_DOWNLOAD=0
KEY_INSTALAR=0
KEY_LUTRIS=0
KEY_PPA=0
KEY_TODOS=0
KEY_UPDATE=0
KEY_VAGRANT=0
#Pacotes .deb que serao baixados para instalar.
URL=(
    'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
    'https://d2t3ff60b2tol4.cloudfront.net/builds/insync_3.3.0.40894-focal_amd64.deb'
    'https://download3.vmware.com/software/player/file/VMware-Player-16.0.0-16894299.x86_64.bundle'
)
#Pacotes instalados pelo APT
PROGRAMAS_PARA_INSTALAR=(
    chrome-gnome-shell
    flameshot
    fonts-hack-ttf
    fonts-powerline
    git
    gnome-tweaks
    net-tools
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
    centos/7
    debian/buster64
    kalilinux/rolling
    hashicorp/bionic64
)
# ------------------------------- FUNÇÕES ----------------------------------------- #
Ppa() {
    sudo apt-add-repository "$PPA_PYTHON" -y
}
Lutris() {
    sudo add-apt-repository "$PPA_LUTRIS" -y && sudo apt INSTALAR-y lutris
}
Download() {
    mkdir -p "$DIR_DOWNLOAD"
    for idown in ${URL[@]}; do
        wget -c "${URL[@]}" -P "$DIR_DOWNLOAD"
    done
    sudo dpkg -i $DIR_DOWNLOAD/*.deb
}
Snap() {
    sudo snap install code --classic
    sudo snap install discord
    #sudo snap install opera
}
Instalacao() {
    sudo dpkg --add-architecture i386
    for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
        if ! dpkg -l | grep -q $nome_do_programa; then
            sudo apt install "$nome_do_programa" -y
        else
            echo "[INSTALADO] - $nome_do_programa"
        fi
    done
}
Vagrant() {
    for ivagr in ${BOX[@]}; do
        vagrant box add "$ivagr"
    done
}
Todos() {
    Ppa
    Download
    Snap
    Instalacao
}
# ------------------------------- EXECUÇÃO ----------------------------------------- #
while test -n "$1"; do
    case "$1" in
    -h) echo "$MENSAGEM_USO" && exit 0 ;;
    -i) KEY_TODOS=1 ;;
    -a) KEY_INSTALAR=1 ;;
    -d) KEY_DOWNLOAD=1 ;;
    -l) KEY_LUTRIS=1 ;;
    -p) KEY-PPA=1 ;;
    -t) KEY_UPDATE=1 ;;
    -v) KEY_VAGRANT=1 ;;
    *) echo "$MENSAGEM_ERRO" && exit 1 ;;
    esac
    shift
done

# sudo apt update -y
[ $KEY_TODOS -eq 1 ] && Todos && exit 0
[ $KEY_INSTALAR -eq 1 ] && Instalacao && exit 0
[ $KEY_DOWNLOAD -eq 1 ] && Download && exit 0
[ $KEY_LUTRIS -eq 1 ] && Lutris && exit 0
[ $KEY_PPA -eq 1 ] && Lutris && exit 0
[ $KEY_UPDATE -eq 1 ] && sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y
[ $KEY_VAGRANT -eq 1 ] && Vagrant && exit 0
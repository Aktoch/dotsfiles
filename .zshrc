export ZSH="/home/aktoch/.oh-my-zsh"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="clean"
plugins=(git
vagrant)
source $ZSH/oh-my-zsh.sh
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

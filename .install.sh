git clone --bare https://github.com/Aktoch/dotfiles.git $HOME/.cfg
function config {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
config checkout
config config status.showUntrackedFiles no
./.pos_instalacao.sh -i

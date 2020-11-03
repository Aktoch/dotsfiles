# Dotfiles 
As configurações que uso no meu dia a dia  que são bem poucas. Também um script para pos-instalação para facilitar uma reinstalação de sistema ou troca de maquina.
***
## Requisitos

* **curl**
* **git**

### instalação


```
sh -c "`curl -fsSL https://raw.githubusercontent.com/Aktoch/dotfiles/master/.noinstall.sh`"
```
executa o pos instala automaticamente.
```
sh -c "`curl -fsSL https://raw.githubusercontent.com/Aktoch/dotfiles/master/.install.sh`"
```
[SpaceVim](https://spacevim.org)
```
curl -sLf https://spacevim.org/install.sh | bash -s -- --install neovim
```
[Oh my zsh](https://ohmyz.sh/) tema “agnoster”
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
***
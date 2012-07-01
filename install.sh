#!/bin/zsh
install() {
  local current=$(cd $(dirname $0) && pwd)
  ln -sF $current/.vimrc $HOME
  ln -sF $current/.vim $HOME
}
install

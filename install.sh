#!/bin/sh
for rc 

pushd make -f make_mac.mak
ln -sF $RC_DIR/.vim $HOME
ln -sf $RC_DIR/.vimrc $HOME
ln -sf $RC_DIR/.gvimrc $HOME

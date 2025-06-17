#!/usr/bin/env bash

function link_one() {
    src="${PWD}/$1"
    tgt="${HOME}/${1/_/.}"

    if [ -e "${tgt}" ] && [ ! -L "${tgt}" ]; then
        echo "Backing up $tgt to $tgt.df.bak"
        mv $tgt $tgt.df.bak
    fi

    ln -sf $src $tgt
}

for i in _*; do
    link_one $i
done

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PluginInstall +qall

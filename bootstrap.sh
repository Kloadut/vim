#!/usr/bin/env sh

endpath="$HOME/.kload-vim"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

echo "thanks for installing kload-vim\n"

# Backup existing .vim stuff
echo "backing up current kload config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $endpath; do [ -e $i ] && mv $i $i.$today; done


echo "cloning kload-vim\n"
mkdir -p $endpath/colors/
wget -O $endpath/.vimrc https://raw.github.com/Kloadut/vim/mini/.vimrc
wget -O $endpath/.vim/colors/Tomorrow-Night.vim https://raw.github.com/Kloadut/vim/mini/.vim/colors/Tomorrow-Night.vim
wget -O $endpath/.vim/colors/molokai.vim https://raw.github.com/Kloadut/vim/mini/.vim/colors/molokai.vim
ln -s $endpath/.vimrc $HOME/.vimrc
ln -s $endpath/.vim $HOME/.vim


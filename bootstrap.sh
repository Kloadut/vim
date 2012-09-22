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
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.color.vim $endpath; do [ -e $i ] && mv $i $i.$today; done


echo "cloning kload-vim\n"
git clone --recursive -b 3.0 http://github.com/Kloadut/vim.git $endpath
mkdir -p $endpath/.vim/bundle
ln -s $endpath/.vimrc $HOME/.vimrc
ln -s $endpath/.vim $HOME/.vim
ln -s $endpath/.color.vim $HOME/.color.vim

echo "Installing Vundle"
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "installing plugins using Vundle"
vim +BundleInstall! +BundleClean +qall

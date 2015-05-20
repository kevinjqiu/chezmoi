#! /usr/bin/env sh

if [ $# -eq 1 ]; then
    ENDPATH=$(realpath $1)
else
    ENDPATH="$HOME/vimmy"
fi

REPO_URL="https://github.com/kevinjqiu/vimmy.git"

TODAY=`date +%Y%m%d`

for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do
    [ -e $i ] && mv $i $i.$TODAY
done

git clone --recursive $REPO_URL $ENDPATH
mkdir -p $ENDPATH/vim/bundle
ln -s $ENDPATH/vimrc $HOME/.vimrc
ln -s $ENDPATH/vim $HOME/.vim

git clone "https://github.com/gmarik/Vundle.vim.git" "$HOME/.vim/bundle/vundle"

vim +BundleInstall! +BundleClean +qall

cd $ENDPATH && ./update-snippets.sh

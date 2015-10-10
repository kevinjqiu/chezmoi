#! /usr/bin/env sh

if [ $# -eq 1 ]; then
    ENDPATH=$(readlink -f $1)
else
    ENDPATH="$HOME/vimmy"
fi

REPO_URL="https://github.com/kevinjqiu/vimmy.git"

TODAY=`date +%Y%m%d`

for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do
    [ -e $i ] && mv $i $i.$TODAY
done

if [ ! -d "$ENDPATH" ]; then
    git clone --recursive "$REPO_URL" "$ENDPATH"
fi

if [ ! -d "$ENDPATH/vim/bundle" ]; then
    mkdir -p "$ENDPATH/vim/bundle"
fi

ln -s "$ENDPATH/vimrc" "$HOME/.vimrc"
ln -s "$ENDPATH/vim" "$HOME/.vim"

if [ ! -d "$HOME/.vim/bundle/vundle" ]; then
    git clone "https://github.com/gmarik/Vundle.vim.git" "$HOME/.vim/bundle/vundle"
fi

vim +BundleInstall! +BundleClean +qall

cd "$ENDPATH" && ./update_snippets.sh

git clone https://github.com/kevinjqiu/chezmoi.git
cd chezmoi
make git
make tmux
make ssh
git clone https://github.com/kevinjqiu/dot_bash.git
cd dot_bash
./install.sh
cd ..
git clone https://github.com/kevinjqiu/vimmy.git
cd vimmy
make link
make bootstrap
cd

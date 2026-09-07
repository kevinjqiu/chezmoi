.PHONY: git ssh tmux herdr xmonad xmobar

inputrc:
	-unlink $(HOME)/.inputrc
	ln --symbolic $(shell pwd)/etc/inputrc $(HOME)/.inputrc

git:
	-unlink $(HOME)/.gitconfig
	ln --symbolic $(shell pwd)/git/gitconfig $(HOME)/.gitconfig

ssh:
	-unlink $(HOME)/.ssh
	ln --symbolic $(shell pwd)/ssh $(HOME)/.ssh

tmux:
	-unlink $(HOME)/.tmux.conf
	ln --symbolic $(shell pwd)/tmux/tmux.conf $(HOME)/.tmux.conf
	-mkdir $(HOME)/.tmux
	-git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm

herdr:
	-mkdir -p $(HOME)/.config/herdr
	-unlink $(HOME)/.config/herdr/config.toml
	ln -s $(shell pwd)/herdr/config.toml $(HOME)/.config/herdr/config.toml

xmonad:
	-unlink $(HOME)/.xmonad
	ln --symbolic $(shell pwd)/xmonad $(HOME)/.xmonad
	xmonad --recompile

xmobar:
	-unlink $(HOME)/.xmobarrc
	ln --symbolic $(shell pwd)/xmobar/xmobarrc $(HOME)/.xmobarrc


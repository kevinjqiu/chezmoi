.PHONY: xmonad xmobar

xmonad:
	-unlink $(HOME)/.xmonad
	ln --symbolic $(shell pwd)/xmonad $(HOME)/.xmonad
	xmonad --recompile

xmobar:
	-unlink $(HOME)/.xmobarrc
	ln --symbolic $(shell pwd)/xmobar/xmobarrc $(HOME)/.xmobarrc

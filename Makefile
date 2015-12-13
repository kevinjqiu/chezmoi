.PHONY: xmonad xmobar

xmonad:
	unlink $(HOME)/.xmonad
	ln --symbolic xmonad $(HOME)/.xmonad
	xmonad --recompile

xmobar:
	unlink $(HOME)/.xmobarrc
	ln --symbolic xmobar/xmobarrc $(HOME)/.xmobarrc

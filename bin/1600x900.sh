xrandr --newmode "1600x900_60.00"  118.25  1600 1696 1856 2112  900 903 908 934 -hsync +vsync
xrandr --addmode eDP1 "1600x900_60.00"
xrandr --output eDP1 --mode "1600x900_60.00"
gsettings set org.gnome.desktop.interface text-scaling-factor 1.0

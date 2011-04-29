#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

DEFAULT_SESSION=awesome
case $1 in 
	awesome) exec awesome ;;
	wmii) exec wmii ;;
	twm) exec twm ;;
	xterm) xterm ;;
	*) exec $DEFAULT_SESSION ;;
esac

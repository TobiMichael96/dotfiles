#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

xrdb  ~/.Xresources

if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
  exec startx
fi

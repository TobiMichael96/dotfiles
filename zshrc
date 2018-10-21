#
# ~/.bashrc
#

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
	eval "$(<~/.ssh-agent-thing)" >/dev/null
	ssh-add ~/.ssh/raspi &>/dev/null
	ssh-add ~/.ssh/gitlab &>/dev/null
fi

alias px='ps ax | grep '
alias cdc='cd $HOME/.config'
alias screenshot='sh ~/.config/scripts/screenshot-tool.sh'
alias ls='ls --color=auto'
alias httpd='hostname -i && python3 -m http.server 8001'
alias note='sh ~/.config/scripts/notes.sh'
alias pacman-clean='sudo pacman -Rns $(pacman -Qtdq)'
alias webserver='ssh tobiasmichael.de -p 2222'

(cat ~/.cache/wal/sequences &)

powerline-daemon -q
. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh


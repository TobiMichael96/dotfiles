#
# ~/.bashrc
#

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
	ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
	eval "$(<~/.ssh-agent-thing)"
	ssh-add ~/.ssh/raspi
	ssh-add ~/.ssh/gitlab
fi

alias px='ps ax | grep '
alias cdc='cd $HOME/.config'
alias screenshot='sh ~/.config/scripts/screenshot-tool.sh'
alias ls='ls --color=auto'
alias httpd='hostname -i && python3 -m http.server 8001'
alias note='sh ~/.config/scripts/notes.sh'
alias pacman-clean='sudo pacman -Rns $(pacman -Qtdq)'
alias webserver='ssh tobiasmichael.de -p 2222'

PS1='[\u@\h > \W] [\A]\$ '

cat ~/.cache/wal/sequences

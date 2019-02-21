#
# ~/.bashrc
#

[[ $- != *i* ]] && return

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi

if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" &>/dev/null
    ssh-add ~/.ssh/amazon.pem &>/dev/null
    ssh-add ~/.ssh/gitlab &>/dev/null
    ssh-add ~/.ssh/linode &>/dev/null
fi

PS1='\e[33;1m\u@\h: \e[31m\W\e[0m\$ '

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less


alias px='ps ax | grep '
alias cdc='cd $HOME/.config'
alias screenshot='sh ~/.config/scripts/screenshot-tool.sh s'
alias httpd='hostname -i && python3 -m http.server 8001'
alias note='sh ~/.config/scripts/notes.sh'
alias pacman-clean='sudo pacman -Rns $(pacman -Qtdq)'
alias webserver='ssh 192.168.2.4'

alias homenet='sh ~/.config/scripts/wireguard.sh'

alias stickm='sh ~/.config/scripts/mount-stick.sh' 
alias stickum='sh ~/.config/scripts/umount-stick.sh'

(cat ~/.cache/wal/sequences &)

~/.config/scripts/show_aliases.sh

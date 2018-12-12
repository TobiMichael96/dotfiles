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

autoload -Uz compinit promptinit 
compinit 
promptinit

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
alias screenshot='python ~/.config/screenshot.py'
alias httpd='hostname -i && python3 -m http.server 8001'
alias note='sh ~/.config/scripts/notes.sh'
alias pacman-clean='sudo pacman -Rns $(pacman -Qtdq)'
alias webserver='mosh 192.168.2.4'

(cat ~/.cache/wal/sequences &)

powerline-daemon -q
. /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

~/.config/scripts/show_aliases.sh

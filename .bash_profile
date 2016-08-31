# give coreutils precedence over other versions in the path
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
# Set CLICOLOR if you want Ansi Colors in iTerm2
export CLICOLOR=1
# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color
# Set the bash prompt styling
export PS1="\[[1m\]\[[34m\][\[[35m\]\u\[[36m\]@\[[35m\]\h \[[32m\]\W\[[34m\]]\$ \[(B[m\]"
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#Enable bash completion
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi
export PATH="/usr/local/bin:$PATH"

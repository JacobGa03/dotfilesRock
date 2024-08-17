# Here are all the aliases for your bash scripting

# some more ls aliases (given by default in bash)
# 'ls' Uses 'eza' CLI instead of 'ls'
alias l='eza'
alias la='eza -A'
alias ld='eza -lD'
alias lf='eza -lF --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias ls='eza -alF --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'
# Custom commands
# Still a work in progress
alias fuzdir='vim $(fzf)'
# Open the current directory in the file manager (Dolphin for this distro
alias dolphine='dolphin . &'


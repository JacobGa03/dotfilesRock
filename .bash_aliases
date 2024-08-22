# Here are all the aliases for your bash scripting

# Show if a link exists between two files ('sl' = show link)
alias sl='eza --only-files -l'
# Syncthing based aliases. enabling, start, and end are long
alias syncstart='sudo systemctl start syncthing@$USER'
alias syncstop='sudo systemctl stop syncthing@$USER'
alias syncenable='sudo systemctl enable syncthing@$USER'
alias syncstatus='sudo systemctl status syncthing@$USER'
# Android studio start
alias asstart='cd ~/Desktop/android-studio/bin && ./studio.sh'
# 'ls' Uses 'eza' CLI instead of 'ls'
alias l='eza'
alias la='eza -A'
alias ld='eza -lD'
alias lf='eza -lF --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias ls='eza -alF --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'
# 'git' 
alias ga='git add'
alias gc='git commit -m'
alias gs='git status'
alias gpl='git pull'
alias gpu='git push'

# Custom commands
# Open the current directory in the file manager (Dolphin for this distro
alias dolphin='dolphin . &'


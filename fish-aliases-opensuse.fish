# Navigation
alias ll='ls -l --color=auto'
alias la='ls -la --color=auto'
alias l='ls --color=auto'
alias l.="ls -d .* --color=auto"
alias listdir="ls -d */ > list"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias home="cd ~"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"

# Zypper (openSUSE)
alias sps='sudo zypper install'
alias spr='sudo zypper remove'
alias sprs='sudo zypper remove --clean-deps'
alias sprdd='sudo zypper remove --force'
alias spqo='sudo rpm -qf'
alias spsii='sudo zypper info'
alias update='sudo zypper refresh'
alias upd='sudo zypper refresh && sudo zypper update'
alias pksyua='sudo zypper dup'
alias upall='sudo zypper dup'

# System Maintenance
alias cleanup='sudo zypper packages --orphaned | awk \'{print $5}\' | xargs -r sudo zypper remove --clean-deps'
alias list="rpm -qa --qf '%{NAME}\n' | sort"
alias listt="zypper se --installed-only | grep -v '^ ' | awk '{print \$3}'"
alias listaur="echo 'AUR packages not available on openSUSE'"

# Utilities
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias free='free -mt'
alias wget='wget -c'
alias userlist="cut -d: -f1 /etc/passwd | sort"
alias clean='clear'
alias cls='clear'

# YouTube Download
alias yta-aac="yt-dlp --extract-audio --audio-format aac"
alias yta-best="yt-dlp --extract-audio --audio-format best"
alias yta-flac="yt-dlp --extract-audio --audio-format flac"
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3"
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4"

# System Info
alias hw="hwinfo --short"
alias audio="pactl info | grep 'Server Name'"
alias howold="sudo lshw | grep -B 3 -A 8 BIOS"
alias cpu="lscpu | grep 'Model name'"
alias klist="ls -1 /usr/lib/modules"
alias kernels="ls -1 /usr/lib/modules"
alias xd="ls /usr/share/xsessions"
alias xdw="ls /usr/share/wayland-sessions"
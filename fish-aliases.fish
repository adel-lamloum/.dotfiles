# to source this aliases use "source ~/.dotfiles/aliases.fish"
#list
alias ll='ls --color=auto'
alias la='ls -a'
alias l='ls'
alias l.="ls -A | egrep '^\.'"
alias listdir="ls -d */ > list"
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias home="cd ~"
alias desk="cd ~/Desktop"
alias docs="cd ~/Documents"

# Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'

#free
alias free="free -mt"

#wget
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd | sort"

#switch between bash and zsh
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"

# hardware info --short
alias hw="hwinfo --short"

# audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#approximation of how old your hardware is
alias howold="sudo lshw | grep -B 3 -A 8 BIOS"

#check cpu
alias cpu="cpuid -i | grep uarch | head -n 1"

# === yt-dlp Aliases for Fish ===

# Video/Audio Download
alias ytv-best="yt-dlp -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias yta-best="yt-dlp -x --audio-format best"
alias yta-128k="yt-dlp -x --audio-format mp3 --audio-quality 5"
alias yta-64k="yt-dlp -x --audio-format opus --audio-quality 64K"

# Subtitles
alias ytv-subs-srt="yt-dlp -f 'bestvideo+bestaudio' --write-subs --sub-langs en --convert-subs srt --skip-download"
alias ytv-auto-subs="yt-dlp -f 'bestvideo+bestaudio' --write-auto-subs --sub-langs en --embed-subs"
alias ytv-multi-subs="yt-dlp -f 'bestvideo+bestaudio' --write-subs --sub-langs en,es --embed-subs"
alias ytv-mkv-subs="yt-dlp -f 'bestvideo+bestaudio' --write-subs --sub-langs en --merge-output-format mkv"

# Playlist & Resolutions
alias yt-playlist="yt-dlp -o '%(playlist_index)s-%(title)s.%(ext)s'"
alias ytv-1080="yt-dlp -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]'"
alias ytv-720="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"
alias ytv-360="yt-dlp -f 'bestvideo[height<=360][ext=mp4]+bestaudio[ext=m4a]/best[height<=360][ext=mp4]'"
alias ytv-360-webm="yt-dlp -f 'bestvideo[height<=360][ext=webm]+bestaudio[ext=webm]/best[height<=360][ext=webm]'"
alias ytv-360-subs="yt-dlp -f 'bestvideo[height<=360]+bestaudio' --write-subs --sub-langs en --embed-subs"
alias ytv-480="yt-dlp -f 'bestvideo[height<=480][ext=mp4]+bestaudio[ext=m4a]/best[height<=480][ext=mp4]'"
alias ytv-480-webm="yt-dlp -f 'bestvideo[height<=480][ext=webm]+bestaudio[ext=webm]/best[height<=480][ext=webm]'"
alias ytv-480-full="yt-dlp -f 'bestvideo[height<=480]+bestaudio' --write-thumbnail --write-description --write-info-json"

# Dynamic resolution (usage: `ytv-res 480 URL`)
function ytv-res
  yt-dlp -f "bestvideo[height<=$argv[1]]+bestaudio/best[height<=$argv[1]]" $argv[2]
end
#clear
alias clean='clear'
alias cls="clear"

#give a list of the kernels installed
alias klist="ls /usr/lib/modules"
alias kernels="ls /usr/lib/modules"

#give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"
alias xdw="ls /usr/share/wayland-sessions"

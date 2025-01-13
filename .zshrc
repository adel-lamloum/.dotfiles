# Source aliases if available
if [ -f ~/.dotfiles/.zsh_aliases ]; then
    source ~/.dotfiles/.zsh_aliases
else
    print "404: ~/.dotfiles/zsh_aliases not found."
fi

# Set history size
export HISTSIZE=10000
# Save history after logout
export SAVEHIST=10000
# History file
export HISTFILE=~/.zhistory
# Append into history file
setopt INC_APPEND_HISTORY
# Save only one command if 2 common are same and consistent
setopt HIST_IGNORE_DUPS
# Add timestamp for each entry
setopt EXTENDED_HISTORY
# Automatically cd into typed directory
setopt autocd

# Enable Emacs keybindings
bindkey -e

# Custom Emacs-style keybindings
bindkey '^A' beginning-of-line        # Move to beginning of line
bindkey '^E' end-of-line              # Move to end of line
bindkey '^K' kill-line                # Delete entire line
bindkey '^U' undo                     # Undo
bindkey '^R' history-incremental-search-backward  # Search history
bindkey '^P' up-history               # Previous command
bindkey '^N' down-history             # Next command
bindkey '^W' backward-kill-word       # Delete word under cursor

# Enhance tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}--- %d ---%f'

# Source plugins
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Display system info
fastfetch

# Initialize Starship prompt
eval "$(starship init zsh)"

# Add useful aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph'

# Enable fuzzy finder for completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey '^R' fzf-history-widget

# Enable syntax highlighting for less
export LESSOPEN="| /usr/bin/lesspipe %s"
export LESS=" -R "

# Add a custom function for directory navigation
function cdd {
  cd ~/$1
}

# Enable command-not-found suggestions (Debian-based systems)
if [[ -x /usr/lib/command-not-found ]]; then
    function command_not_found_handler {
        /usr/lib/command-not-found -- "$1"
    }
fi

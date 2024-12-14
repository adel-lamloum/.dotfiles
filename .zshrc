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

# Enable Vi mode
bindkey -v
export KEYTIMEOUT=1

# Custom keybindings
bindkey -M viins '^A' beginning-of-line  # Move to beginning of line
bindkey -M viins '^E' end-of-line        # Move to end of line
bindkey -M viins '^K' kill-line          # Delete entire line
bindkey -M viins '^U' undo               # Undo
bindkey -M viins '^R' redo               # Redo
bindkey -M viins '^P' up-history         # Previous command
bindkey -M viins '^N' down-history       # Next command
bindkey -M viins '^W' backward-kill-word # Delete word under cursor

# Character-wise movement in Vi mode
bindkey -M vicmd 'h' vi-backward-char  # Move left
bindkey -M vicmd 'j' vi-down-line      # Move down
bindkey -M vicmd 'k' vi-up-line        # Move up
bindkey -M vicmd 'l' vi-forward-char   # Move right

# Word-wise movement in Vi mode
bindkey -M vicmd 'w' vi-forward-word   # Move forward by word
bindkey -M vicmd 'b' vi-backward-word  # Move backward by word
bindkey -M vicmd 'e' vi-forward-word-end  # Move to end of word

# Delete word
bindkey -M vicmd 'dw' vi-backward-kill-word  # Delete word backward

# Cursor shape for Vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'  # Block cursor for normal mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'  # Beam cursor for insert mode
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  echo -ne '\e[5 q'  # Initialize beam cursor for insert mode
}
zle -N zle-line-init

# Vi mode indicator in prompt
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%F{yellow}<<< NORMAL >>>%f"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}"
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

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

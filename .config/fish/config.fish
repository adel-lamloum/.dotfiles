if status is-interactive
source ~/.config/fish/aliases.fish
# Commands to run in interactive sessions can go here
starship init fish | source
set fish_greeting
fastfetch
end

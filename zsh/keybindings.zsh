# Vi-style editing
bindkey -v

# Movement
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'G' end-of-buffer-or-history

# Undo / redo
bindkey -a 'u' undo
bindkey -a 'U' redo

# History search
if (( $+functions[history-substring-search-up] && $+functions[history-substring-search-down] )); then
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down
fi

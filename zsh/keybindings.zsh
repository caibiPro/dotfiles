# Vi-style editing
bindkey -v

# Insert-mode word deletion without vi's insert-start limit
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^[^?' backward-kill-word

# Insert-mode line/word movement (Ghostty sends ^A/^E for Cmd-Left/Right)
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[f' forward-word

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

# Vi-style editing
bindkey -v

# Switch to normal mode right after Esc (default waits 0.4s)
KEYTIMEOUT=1

# Insert-mode emacs keys, without vi's insert-start limit
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^[b' backward-word
bindkey -M viins '^[f' forward-word
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^[^?' backward-kill-word
bindkey -M viins '^[d' kill-word
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line

# Edit the current command in $EDITOR: Ctrl-X Ctrl-E in insert mode, v in normal mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M viins '^X^E' edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Cursor shape: blinking bar in insert mode, steady block in normal mode
_vi_cursor_shape() {
  if [[ $KEYMAP == vicmd ]]; then
    printf '\e[2 q'
  else
    printf '\e[5 q'
  fi
}
autoload -Uz add-zle-hook-widget
add-zle-hook-widget keymap-select _vi_cursor_shape
add-zle-hook-widget line-init _vi_cursor_shape

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

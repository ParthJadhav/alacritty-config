unbind C-b
set-option -g prefix C-Space
set-option -g status-position top
bind-key C-Space send-prefix

set -g mouse on
set -g set-clipboard on
set -g renumber-windows on
set -g detach-on-destroy on
set -g base-index 1

unbind '"'
unbind %
bind - split-window -h -c "#{pane_current_path}"
bind = split-window -v -c "#{pane_current_path}"

bind -n C-h select-pane -L
bind -n C-k select-pane -U
bind -n C-l select-pane -R
bind -n C-j select-pane -D

bind C-j display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"

bind-key r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'niksingh710/minimal-tmux-status'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @continuum-restore 'on'

set -g @minimal-tmux-bg "#698DDA"
set -g @minimal-tmux-justify "centre"
set -g @minimal-tmux-indicator-str "  tmux  "
set -g @minimal-tmux-indicator true
set -g @minimal-tmux-status "top"
bind-key h set-option status

# Enables or disables the left and right status bar
set -g @minimal-tmux-right false
set -g @minimal-tmux-left false

# expanded icon (fullscreen icon) 
set -g @minimal-tmux-expanded-icon " 󰊓 "

#on all tabs (default is false)
# false will make it visible for the current tab only
set -g @minimal-tmux-show-expanded-icons-for-all-tabs true

run '~/.tmux/plugins/tpm/tpm'

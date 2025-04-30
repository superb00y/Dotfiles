#!/usr/bin/env bash
source "$HOME/.config/tmux/tools/linkarzu/tmux_colors.sh"

# tmux set -g @catppuccin_directory_color "$color4"

# tmux set -g @catppuccin_window_current_color "$color2"
# tmux set -g @catppuccin_window_current_background "$color0"

# tmux set -g @catppuccin_window_default_color "$color2"
# tmux set -g @catppuccin_window_default_background "$color0"

# tmux set -g @catppuccin_pane_active_border_style "fg=$color3"
# tmux set -g @catppuccin_pane_border_style "fg=$color0"

# tmux set -g @catppuccin_status_background "$color0"

# tmux set -g @catppuccin_session_color "#{?client_prefix,$color9,$color2}"

# tmux set -g @catppuccin_window_default_fill "number"
# tmux set -g @catppuccin_window_default_text "#{fg=$color14}#W"
# tmux set -g @catppuccin_window_current_fill "number"
# tmux set -g @catppuccin_window_current_text "#{fg=$color14}#W"
# tmux set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,#[fg=$color4] (    ),}#{?pane_synchronized,#[fg=$color4] SYNCHRONIZED-PANES,}"
# 
# 

HALF_ROUND_OPEN="#(printf '\uE0B6')"
HALF_ROUND_CLOSE="#(printf '\uE0B4')"
TRIANGLE_OPEN="#(printf '\uE0B2')"
TRIANGLE_CLOSE="#(printf '\uE0B0')"

tmux set-option -g status-style "bg=$color0, fg=$color9"

tmux set-option -g status-justify centre

# Style and set contents on the left section
tmux set-option -g status-left "\
#[fg=$color8,bg=default]$HALF_ROUND_OPEN\
#[bg=$color8,fg=$color9]#S \
#[fg=$color8,bg=default]$TRIANGLE_CLOSE\
"
# Style and set contents on the right section
tmux set-option -g status-right "\
#[fg=$color8,bg=default]$TRIANGLE_OPEN\
#[bg=$color8,fg=$color15] #h\
#[fg=$color8,bg=default]$HALF_ROUND_CLOSE\
"

# Set max length of left and right section
tmux set-option -g status-left-length 100
tmux set-option -g status-right-length 100

# Style and set content for the inactive windows
tmux set-option -g window-status-format "\
 \
#I\
#[fg=$color12]:\
#[fg=default]#W\
 \
"

# Style and set content for the active windows
tmux set-option -g window-status-current-format "\
#[fg=$color8,bg=default]$HALF_ROUND_OPEN\
#[bg=$color8,fg=default]#I\
#[fg=$color11]:\
#[fg=default]#W\
#[fg=$color8,bg=default]$HALF_ROUND_CLOSE\
"

# Remove the separator between window list items, as we already have spacing
# "around" inactive items
tmux set-option -g window-status-separator ""

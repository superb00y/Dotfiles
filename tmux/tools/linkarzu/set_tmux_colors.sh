#!/usr/bin/env bash
source "$HOME/.config/tmux/tools/linkarzu/tmux_colors.sh"

tmux set -g @catppuccin_directory_color "$color4"

tmux set -g @catppuccin_window_current_color "$color2"
tmux set -g @catppuccin_window_current_background "$color0"

tmux set -g @catppuccin_window_default_color "$color2"
tmux set -g @catppuccin_window_default_background "$color0"

tmux set -g @catppuccin_pane_active_border_style "fg=$color3"
tmux set -g @catppuccin_pane_border_style "fg=$color0"

tmux set -g @catppuccin_status_background "$color0"

tmux set -g @catppuccin_session_color "#{?client_prefix,$color9,$color2}"

tmux set -g @catppuccin_window_default_fill "number"
tmux set -g @catppuccin_window_default_text "#{fg=$color14}#W"
tmux set -g @catppuccin_window_current_fill "number"
tmux set -g @catppuccin_window_current_text "#{fg=$color14}#W"
tmux set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,#[fg=$color4] (    ),}#{?pane_synchronized,#[fg=$color4] SYNCHRONIZED-PANES,}"


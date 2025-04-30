#!/usr/bin/env bash

# Check if one argument is being provided
if [[ $# -eq 1 ]]; then
  selected=$1
elif [[ $# -eq 0 ]]; then
  selected=$(find ~/Projects/go ~/Projects/python ~/Projects/love ~/Projects/C ~/STUDY/l3/l3:s6 ~/STUDY/l3/l3:s6/DRIVE -mindepth 1 -maxdepth 2 -type d | fzf)
elif [[ $# -eq 2 ]]; then
  # Use the second argument as the directory path for the find command
  dir_to_search="$2"
  if [[ -d "$dir_to_search" ]]; then
    selected=$(find "$dir_to_search" -mindepth 1 -maxdepth 1 -type d | fzf)
  else
    tmux display-message -d 3000 "Directory does not exist: $dir_to_search"
    exit 1
  fi
else
  tmux display-message -d 3000 "This script expects zero  one or two arguments."
  exit 1
fi

# Exit the script if no directory is selected
if [[ -z $selected ]]; then
  # Debugging
  # tmux display-message -d 5000 "No directory selected. Exiting."
  exit 0
fi

# replace '.' and '-' with '_'
# I had some dirs with '-' and couldn't get the value of the corresponding var
# in the mappings file because it was interpreting the '-'
selected_after_tr=$(basename "$selected" | tr '.-' '__')
selected_name=$selected_after_tr


# If a tmux session with the desired name does not already exist, create it in detached mode
if ! tmux has-session -t=$selected_name 2>/dev/null; then
  # I included quotes in "$selected" because wasn't changing to dirs that have a space
  # Like the iCloud dir
  tmux new-session -ds $selected_name -c "$selected"
fi

# Check if Neovim is running in the selected tmux session.
# If Neovim is not found in any pane, open it with the desired configuration lamw25wmal
# I'm also making sure that the name is NOT equal to "$current_username-${username_suffix}"
# I don't want to start neovim in my home directory
if [[ "$selected_name" != "$current_username-${username_suffix}" ]] && ! tmux list-panes -t "$selected_name" -F "#{pane_current_command}" | grep -q "helix"; then
  # Set NVIM_APPNAME variable to load config and start it in the selected tmux session.
  # C-m presses enter
  tmux send-keys -t "$selected_name" "y" C-m
fi

# If Neovim is running, just switch to the session
tmux switch-client -t $selected_name

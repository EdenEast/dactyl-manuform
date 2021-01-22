#!/bin/sh

set -e

SESN="dactyl-manform"

if tmux has-session -t=keyboard 2> /dev/null; then
  tmux attach -t keyboard
  exit
fi

# create new session with session-name `$SESN` with a new window called `code`
# Source for default-size: https://unix.stackexchange.com/a/569731
tmux new-session -d -s $SESN -n code -x "$(tput cols)" -y "$(tput lines)"

tmux split-window -t $SESN:code -hp 25
tmux split-window -t $SESN:code.right -p 25

tmux send-keys -t $SESN:code.bottom-right "lein auto generate" Enter

# reattach to window. selecting the top left first to make it the last selected
# after the top left
tmux select-pane -t $SESN:code.top-right
tmux attach -t $SESN:code.top-left


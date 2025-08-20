#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: smux <ssh_key> <ssh_user> <comma_separated_ips>" >&2
  exit 1
fi

SSHKEY=$1
USER=$2
IPS_RAW=$3

# Split the comma-separated list into an array
IFS=',' read -r -a IPS <<< "$IPS_RAW"
NUM=${#IPS[@]}

if (( NUM == 0 )); then
  echo "Error: no IPs provided." >&2
  exit 1
fi

# Name the session uniquely
SESSION="smux-$(date +%s)"

# Base SSH options
SSH_OPTS="-o StrictHostKeyChecking=no -i $SSHKEY"

# Start a detached session running ssh to the first IP
tmux new-session -d -s "$SESSION" -- "ssh $SSH_OPTS $USER@${IPS[0]}"

# Create additional panes for the rest
for idx in "${!IPS[@]}"; do
  # skip the first (already created)
  if (( idx == 0 )); then
    continue
  fi

  IP=${IPS[$idx]}
  pane_num=$((idx + 1))

  # even⇒horizontal split, odd⇒vertical
  if (( pane_num % 2 == 0 )); then
    tmux split-window -h -t "${SESSION}:0" -- "ssh $SSH_OPTS $USER@$IP"
  else
    tmux split-window -v -t "${SESSION}:0" -- "ssh $SSH_OPTS $USER@$IP"
  fi

  # rebalance
  tmux select-layout -t "${SESSION}:0" tiled
done

# Finally attach
tmux attach -t "$SESSION"

#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: smux <ssh_key> <ssh_user> <comma_separated_ips>" >&2
  exit 1
fi

SSHKEY=$1
USER=$2
IPS_RAW=$3

IFS=',' read -r -a IPS <<< "$IPS_RAW"
NUM=${#IPS[@]}

if (( NUM == 0 )); then
  echo "Error: no IPs provided." >&2
  exit 1
fi

SESSION="smux-$(date +%s)"
SSH_OPTS="-o StrictHostKeyChecking=no -i $SSHKEY"

tmux new-session -d -s "$SESSION" -- "ssh $SSH_OPTS $USER@${IPS[0]}"

for idx in "${!IPS[@]}"; do
  if (( idx == 0 )); then
    continue
  fi
  IP=${IPS[$idx]}
  pane_num=$((idx + 1))

  if (( pane_num % 2 == 0 )); then
    tmux split-window -h -t "${SESSION}:0" -- "ssh $SSH_OPTS $USER@$IP"
  else
    tmux split-window -v -t "${SESSION}:0" -- "ssh $SSH_OPTS $USER@$IP"
  fi

  tmux select-layout -t "${SESSION}:0" tiled
done

# Enable synchronized input for this window
tmux set-window-option -t "${SESSION}:0" synchronize-panes on

tmux attach -t "$SESSION"

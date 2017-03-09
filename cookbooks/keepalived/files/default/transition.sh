#!/bin/bash

# arg 1 is the event name
# possible values: stopping, backup, master, failed

to_addr="colbyo@copiousinc.com"
from_addr="$(whoami)@$(hostname --fqdn)"
msg_subject="[keepalived] $(hostname) transitioned to ${1} state"

ssmtp colbyo@copiousinc.com <<HEREDOC
To: ${to_addr}
From: ${from_addr}
Subject: ${msg_subject}

${msg_subject}
HEREDOC

# check for election to master
# if this node becomes master and nginx is not successfully listening on IPs then the site goes down!
if [[ $1 == *"master"* ]]
then
  # brief pause to let keepalived bind to all public production VIPs
  sleep 4
  # check for nginx process status
  sudo service nginx status | grep -F 'is running'
  rc=$?
  if [ $rc -eq 0 ]
  then
    # nginx is running; try to restart it (if the configurations look okay)
    sudo service nginx configtest && sudo service nginx restart
  else
    # nginx is not running; command it to start
    sudo service nginx start
  fi
fi

exit 0

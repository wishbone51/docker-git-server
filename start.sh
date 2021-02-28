#!/bin/sh

# If there is some public key in keys folder
# then it copies its contain in authorized_keys file
if [ "$(ls -A /home/git/keys/)" ]; then
  cd /home/git
  cat /home/git/keys/*.pub > .ssh/authorized_keys
  chown -R git:git .ssh
  chmod 700 .ssh
  chmod -R 600 .ssh/*
fi

# -D flag avoids executing sshd as a daemon

exec /usr/sbin/sshd -D "$@"

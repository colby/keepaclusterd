#!/usr/bin/env sh

# aborts immediately if any command exits with an error
set -e

# do the nginx configs pass?
/usr/bin/sudo /usr/sbin/service nginx configtest

# is nginx running?
/usr/bin/sudo /usr/sbin/service nginx status | /bin/grep 'is running'

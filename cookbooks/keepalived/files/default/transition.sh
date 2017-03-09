#!/bin/bash

# arguments
# $1 = "GROUP"|"INSTANCE"
# $2 = name of group or instance
# $3 = target state of transition
#     ("MASTER"|"BACKUP"|"FAULT")

case $3 in
    'MASTER')
        # NOTE: wait for VIP creation
        wait 5
        # NOTE: start nginx
        service nginx configtest && service nginx start
    ;;
    'BACKUP'|'FAULT')
        service nginx stop
    ;;
esac

exit 0

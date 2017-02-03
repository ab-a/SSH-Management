#!/bin/bash

### WARNING : WORK IN PROGRESS /!\ NOT READY FOR PRODUCTION ###

i=0
jq -r ".keys[] | .username" db.json | while read user ; do
        status=$(jq -r ".keys[$i] | .enabled" db.json)
        ssh=$(jq -r ".keys[$i] | .key" db.json)
        if [[ $status = "1" ]]; then
                homedir=$(getent passwd $user | cut -f6 -d:)
                echo "Command : echo $ssh >> $homedir/.ssh/authorized_keys"
        fi
        (( i++ ))
done
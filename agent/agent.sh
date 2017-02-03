#!/bin/bash

### WARNING : WORK IN PROGRESS /!\ NOT READY FOR PRODUCTION ###

i=0
jq -r ".keys[] | .username" db.json | while read keys ; do
        jq -r ".keys[$i] | .key" db.json
        status=$(jq -r ".keys[$i] | .enabled" db.json)
        if [[ $status = "1" ]]; then
                echo "ENABLED"
                homedir=$(getent passwd $keys | cut -f6 -d:)
                echo $homedir
        fi
        (( i++ ))
        echo $keys
        echo $i
done
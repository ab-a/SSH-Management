#!/bin/bash

i=0
master=master.hostname.
port=22
user=ssh-management
database=$(ssh -p $port $user@$hostname cat ~/db.json)
jq -r ".keys[] | .username" db.json | while read user ; do
        status=$(jq -r ".keys[$i] | .enabled" db.json)
        ssh=$(jq -r ".keys[$i] | .key" db.json)
        if [[ $status = "1" ]]; then
                mkdir -p $homedir/.ssh
                if [ ! -f $homedir/.ssh/authorized_keys ]; then
                        touch $homedir/.ssh/authorized_keys
                        chmod 600 $homedir/.ssh/authorized_keys
                        chmod 700 $homedir/.ssh/
                fi
                if [ ! -f $homedir/.ssh/config ]; then
                        touch $homedir/.ssh/config
                        echo "StrictHostKeyChecking no" > $homedir/.ssh/config
                        chmod 644 $homedir/.ssh/config
                fi
		if [ "$i" -gt 0 ]
	                homedir=$(getent passwd $user | cut -f6 -d:)
        	        echo $ssh >> $homedir/.ssh/authorized_keys
		fi
        fi
        (( i++ ))
done

#!/bin/sh

### WARNING : WORK IN PROGRESS /!\ NOT READY FOR PRODUCTION ###

file="hosts.conf"

while read -r line; do
        [[ -n "$line" && "$line" != [[:blank:]\[]* ]] && \
        userconf=$(echo ${line} | cut -d ":" -f 2) && \
        hostconf=$(echo ${line} | cut -d ":" -f 1) && \
        name="$line" && \
        echo "Name read from file - $userconf" && \
        echo "Host read from file - $hostconf" && \
        echo "Command : ssh $userconf@$hostconf"
        # pipe file
        #scp -i ~/.ssh/id_rsa.pub ./db.json ${userconf}@${hostconf}:/home/ssh-keys/db.json
done < "$file"

echo ${resKey}
echo ${resUser}
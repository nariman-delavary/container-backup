#!/bin/bash
scriptPath=$(dirname "$(readlink -f "$0")")
printenv | sed 's/^\(.*\)$/export \1/g' > ${scriptPath}/.env.sh
chmod +x ${scriptPath}/.env.sh
crontab -l | { cat; echo "$BACKUP_TIME /src/script.sh > /dev/null 2>&1"; } | crontab -
/etc/init.d/cron start
tail -f /dev/null

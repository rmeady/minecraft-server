#!/bin/sh
if [ ! -f "eula.txt" ]; then
    echo "# Generated via Docker on $(date)" > eula.txt
    echo "eula=$EULA" >> eula.txt
fi

MANAGE_SCRIPT="/usr/local/minecraft/bin/manage.sh"
[ ! -x "${MANAGE_SCRIPT}" ] && echo "${MANAGE_SCRIPT} is not executable" && exit 1

"${MANAGE_SCRIPT}" -u

tail -f /dev/null
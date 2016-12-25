#!/bin/bash 
set -x

export HOME=/var/lib/pgsql

if [ ! -f ${PGDATA}/pg_hba.conf ]; then
    # init the database
    cd /ansible-dbinit
    ansible-playbook -i inventory dbinit.yml 
fi

exec "$@"

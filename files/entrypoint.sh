#!/bin/bash 
set -x

function generate_passwd_file() {
  export USER_ID=$(id -u)
  export GROUP_ID=$(id -g)
  grep -v ^postgres /etc/passwd > "$HOME/passwd"
  echo "postgres:x:${USER_ID}:${GROUP_ID}:PostgreSQL Server:${HOME}:/bin/bash" >> "$HOME/passwd"
  export LD_PRELOAD=libnss_wrapper.so
  export NSS_WRAPPER_PASSWD=${HOME}/passwd
  export NSS_WRAPPER_GROUP=/etc/group
}

export HOME=/var/lib/pgsql

generate_passwd_file

if [ ! -f ${PGDATA}/pg_hba.conf ]; then
    # init the database
    cd /ansible-dbinit
    ansible-playbook -i inventory dbinit.yml 
fi

exec "$@"

#!/bin/sh

if [[ -z $UID ]]; then
    UID=1000
fi

if [[ -z $GID ]]; then
    GID=1000
fi

usermod -u $UID www-data && groupmod -g $GID www-data

exec /usr/bin/supervisord -n -c /etc/supervisord.conf
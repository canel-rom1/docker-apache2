#!/bin/bash

set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

if [ "${1:0:1}" = "-" ] ; then
	exec /usr/sbin/apache2 "$@"
fi

if [ "$1" = "/usr/sbin/apache2" ] ; then
	exec "$@"
fi

if [ "$1" = "apache2" ] ; then
	exec /usr/sbin/apache2 -D FOREGROUND
fi

exec "$@"

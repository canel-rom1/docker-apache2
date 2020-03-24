#!/usr/bin/env sh

set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

for file in /entrypoints/*.sh
do
        echo "DOCKER Apache2: Load ${file} file" > /dev/stdout
        source "${file}"
done

if [ "${1:0:1}" = "-" ] ; then
	exec /usr/sbin/httpd "$@"
fi

if [ "$1" = "/usr/sbin/httpd" ] ; then
	exec "$@"
fi

if [ "$1" = "apache2" ] ; then
	exec /usr/sbin/httpd -D FOREGROUND -f /etc/apache2/httpd.conf
fi

exec "$@"

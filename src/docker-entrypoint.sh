#!/bin/sh

set -e
trap "echo SIGNAL" HUP INT QUIT KILL TERM

ENTRYPOINT="/entrypoint.sh"
if [ -f "${ENTRYPOINT}" ]
then
        source ${ENTRYPOINT}
fi

if [ -n "${APACHE_HTACCESS}" ] && [ "${APACHE_HTACCESS}" -ne 0 ]
then
        echo "HTACCESS" > /dev/stdout
        sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
        sed -i '/AllowOverride/s/None/all/g' /etc/apache2/conf.d/website*
fi

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
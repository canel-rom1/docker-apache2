#!/bin/sh

if [ -n "${APACHE_HTACCESS}" ] && [ "${APACHE_HTACCESS}" -ne 0 ]
then
        echo "HTACCESS" > /dev/stdout
        sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
        sed -i '/AllowOverride/s/None/all/g' /etc/apache2/conf.d/website*
fi

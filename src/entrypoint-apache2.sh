#!/usr/bin/env sh

APACHE_HTML_DIR_TMP=/tmp/www

if [ -d "${APACHE_HTML_DIR_TMP}" ]
then
        [ -d "${APACHE_HTML_DIR}" ] && rm -fr "${APACHE_HTML_DIR}"
        mv "${APACHE_HTML_DIR_TMP}" "${APACHE_HTML_DIR}"
fi

if [ -n "${APACHE_HTACCESS}" ] && [ "${APACHE_HTACCESS}" -ne 0 ]
then
        echo "HTACCESS" > /dev/stdout
        sed -i '/LoadModule rewrite_module/s/^#//g' /etc/apache2/httpd.conf
        sed -i '/AllowOverride/s/None/all/g' /etc/apache2/conf.d/website*
fi

FROM canelrom1/alpine-canel:3.12.3

LABEL maintainer="Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch"
LABEL date="25/12/2020"
LABEL description="Serveur HTTP - Apache"

RUN apk  add --no-cache --update \
            apache2 \
            apache2-ssl \
            curl

RUN mkdir /entrypoints

RUN mkdir -p /run/apache2 \
 && rm /etc/apache2/conf.d/info.conf

COPY ./conf/httpd.conf /etc/apache2/httpd.conf
COPY ./conf/ssl.conf /etc/apache2/conf.d/ssl.conf
COPY ./conf/website.conf /etc/apache2/conf.d/website.conf
COPY ./conf/website-ssl.conf /etc/apache2/conf.d/website-ssl.conf

ENV APACHE_RUN_USER     apache
ENV APACHE_RUN_GROUP    apache
ENV APACHE_PORT_HTTP    80
ENV APACHE_PORT_HTTPS   443
ENV APACHE_HTML_DIR     /var/www/html
ENV APACHE_SERVERADMIN  webmaster@localhost
ENV APACHE_SERVERNAME   localhost
ENV APACHE_HTACCESS     0

COPY ./www /tmp/www
RUN  rm -fr ${APACHE_HTML_DIR} \
 &&  mv /tmp/www ${APACHE_HTML_DIR} \
 &&  chown ${APACHE_RUN_USER}:${APACHE_RUN_GROUP} -R \
                /var/www \
                /var/log/apache2 \
                /etc/ssl/apache2 \
                /run/apache2 \
                ${APACHE_HTML_DIR}

# EXPOSE ${APACHE_PORT_HTTP}
# EXPOSE ${APACHE_PORT_HTTPS}

HEALTHCHECK CMD curl -f "http://localhost:${APACHE_PORT_HTTP}" || exit 1

COPY ./entrypoint-apache2.sh /entrypoints/10-apache2.sh
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh /entrypoints/10-apache2.sh

# USER ${APACHE_RUN_USER}

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2"]

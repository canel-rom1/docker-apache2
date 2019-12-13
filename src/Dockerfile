FROM canelrom1/alpine-canel:latest

LABEL maintainer="Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch"
LABEL date="11/12/2019"
LABEL description="Serveur HTTP"

RUN apk update \
 && apk add apache2 \
            apache2-ssl \
            curl

RUN mkdir /entrypoints

RUN mkdir -p /run/apache2 \
 && rm /etc/apache2/conf.d/info.conf

COPY ./conf/httpd.conf /etc/apache2/httpd.conf
COPY ./conf/ssl.conf /etc/apache2/ssl.conf
COPY ./conf/website.conf /etc/apache2/conf.d/website.conf
COPY ./conf/website-ssl.conf /etc/apache2/conf.d/website-ssl.conf

COPY ./www/canel.gif /var/www/html/
COPY ./www/index.html /var/www/html/

ENV APACHE_RUN_USER     apache
ENV APACHE_RUN_GROUP    apache
ENV APACHE_SERVERADMIN  webmaster@localhost
ENV APACHE_SERVERNAME   localhost
ENV APACHE_HTACCESS=0

EXPOSE 80
EXPOSE 443

HEALTHCHECK CMD curl -f "http://localhost:80" || exit 1

COPY ./entrypoint-apache2.sh /entrypoints/10-apache2.sh
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh /entrypoints/10-apache2.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2"]

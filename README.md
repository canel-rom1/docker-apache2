# docker-apache2

## Getting started
To run the container:
```bash
$ make run
```
## Build an image
To build your own image:
```bash
$ make build
```
With the parameters:
```bash
$ make build prefix=canelrom1 name=apache2 tag=1.0
```
To clean docker images:
```bash
$ make clean
```


# Environment variable

APACHE_RUN_USER
APACHE_RUN_GROUP
APACHE_SERVERADMIN
APACHE_SERVERNAME
APACHE_HTACCESS

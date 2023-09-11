These files are preconfigured for the docker-compose setup.

Note: this does not work with rootless podman, either docker or root podman works.

```
[from the wings/ directory]
$ docker build -t wings:latest .
$ docker-compose up mariadb
$ # wait for database initialization to finish
$ # from another window
$ docker-compose exec mariadb mysql -uwings -pwings wings
MariaDB [wings]> update zone_settings set zoneip='[yourip]' where zoneip='127.0.0.1';
MariaDB [wings]> update wingslogin.worlds set search_ip='[yourip]';
$ docker-compose up
```

Client command in Ashita: `--server [ip/hostname]` + `--nossl` if you haven't setup ssl

Making yourself a GM:

```
$ docker-compose exec mariadb mysql -uwings -pwings wings
MariaDB [wings]> update chars set gmlevel=4 where charname='[yourCharacterName]';
```

To enable SSL:

* set `ssl_enabled = 2` in conf-docker/login.conf
* set `ssl_certificate_file` and `ssl_private_key_file` in conf-docker/login.conf
* generate a ssl key, through openssl, using something like let's encrypt, or your own way
* restart the login server

#!/bin/sh

for i in /sql-login/*.sql; do
  mysql -uroot -p$MARIADB_ROOT_PASSWORD wingslogin <$i
done

for i in /sql-wings/*.sql; do
  mysql -uroot -p$MARIADB_ROOT_PASSWORD wings <$i
done

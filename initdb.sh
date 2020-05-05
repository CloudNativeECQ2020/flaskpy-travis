#!/bin/sh
# pmcampbell
# 2020-05-04
# issues with initdb in RUN command
# for docker, so trying a script, there must be a better way
# to init postgressql in a container ...

# n.b. script must be run as user postgres

if [[ $USER != "postgres" ]] ; then
     echo $(basename $1) must be run by user postgres
     exit 1
fi

pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log
psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';" 
psql --command "CREATE DATABASE wordcount_dev;"

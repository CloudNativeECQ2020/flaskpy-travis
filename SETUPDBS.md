
2020-05-04 building using [Dockerfile](Dockerfile)  part 2
```
Step 10/19 : RUN su - postgres -c "initdb /var/lib/postgresql/data"
 ---> Running in 2ee565149a60
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locales
  COLLATE:  C
  CTYPE:    C.UTF-8
  MESSAGES: C
  MONETARY: C
  NUMERIC:  C
  TIME:     C
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting dynamic shared memory implementation ... posix
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting default time zone ... UTC
creating configuration files ... ok
running bootstrap script ... ok
performing post-bootstrap initialization ... sh: locale: not found
2020-05-04 21:50:28.740 UTC [10] WARNING:  no usable system locales were found
ok
syncing data to disk ... initdb: warning: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
ok


Success.

Removing intermediate container 2ee565149a60
 ---> f1c9bc8d78ab
Step 11/19 : RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf
 ---> Running in 979a4267b50c
Removing intermediate container 979a4267b50c
 ---> cf2d2f0c02c9
Step 12/19 : RUN su - postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log && psql --command \"ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';\"
 ---> Running in 278a63b87e8b
/bin/sh: syntax error: unterminated quoted string
The command '/bin/sh -c su - postgres -c "pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log && psql --command \"ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';\"' returned a non-zero code: 2
Makefile:42: recipe for target 'build' failed
make: *** [build] Error 2
```

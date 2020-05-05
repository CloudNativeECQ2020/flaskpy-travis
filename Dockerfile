FROM python:3-alpine
MAINTAINER P.M.Campbell pcampbell.edu@gmail.com

# set up postgres
# dev needed for pg_config needed for psycopg2
RUN apk add --no-cache  postgresql-dev
## below needed for postgresql-dev but not for postgresql
# -S system user -G group -H no home dir
RUN (addgroup postgres && adduser -S postgres -G postgres -H || true)
RUN mkdir -p /var/lib/postgresql/data /run/postgresql/
RUN chmod -R 777 /var/lib/postgresql/data
RUN chown -R postgres:postgres /var/lib/postgresql/data
RUN mkdir -p /run/postgresql/ &&  chown -R postgres:postgres /run/postgresql/
##RUN su - postgres -c "initdb /var/lib/postgresql/data"
##RUN echo "host all  all    0.0.0.0/0  md5" >> /var/lib/postgresql/data/pg_hba.conf
##WORKDIR /usr/local/bin
##COPY initdb.sh /usr/local/bin/
##RUN chmod +x initdb.sh && su - postgres -c "initdb.sh"
#RUN chmod +x initdb.sh && su - postgres -c ./initdb.sh'"pg_ctl start -D /var/lib/postgresql/data -l /var/lib/postgresql/log.log" &&  psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD 'postgres';" &&  psql --command "CREATE DATABASE wordcount_dev;"'

# set up python pkgs
##COPY requirements.txt ./
##RUN pip install --no-cache-dir -r requirements.txt 

# set up application
## COPY app/  /usr/local/app
## WORKDIR /usr/local/app 

# note on heroku expose is "not respected" but useful for local testing
# see https://devcenter.heroku.com/articles/container-registry-and-runtime#dockerfile-commands-and-runtime
# default flask port 5000
EXPOSE 5000
#EXPOSE 80

# runtime for testing
ENTRYPOINT [ "sh" ]
# got it working with the basics 
#ENTRYPOINT [ "python", "./app.py" ] 
#ENTRYPOINT [ "python", "./app2.py" ] 

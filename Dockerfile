FROM python:3-alpine
MAINTAINER P.M.Campbell pcampbell.edu@gmail.com

RUN pip install --no-cache-dir Flask &&  pip install --no-cache-dir pytz 

COPY app.py /usr/local/bin/app.py 

# note on heroku expose is "not respected" but useful for local testing
# see https://devcenter.heroku.com/articles/container-registry-and-runtime#dockerfile-commands-and-runtime
# default flask port 5000
#EXPOSE 5000
EXPOSE 80

# working dir
WORKDIR /usr/local/bin

# runtime
CMD [ "python", "./app.py" ] 

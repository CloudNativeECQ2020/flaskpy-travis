FROM python:3-alpine
MAINTAINER P.M.Campbell pcampbell.edu@gmail.com

RUN pip install --no-cache-dir Flask

COPY app.py /usr/local/bin/app.py 

# default flask port
EXPOSE 5000

# working dir
WORKDIR /usr/local/bin

# runtime
CMD [ "python", "./app.py" ] 

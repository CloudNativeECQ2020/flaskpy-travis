#!/usr/bin/python
# pmc sample flask app

# working locally & on heroku


# simple version 2
# 2020-05-04 
# trouble running it on  heroku
# the fix was getting the port as int from env & passing w app run
"""
needed to work on heroku, works without in local container
port = int(os.environ.get("PORT", 5000))
get here and use as arg to app.run:
     app.run(host="0.0.0.0",debug=True, port=port)
"""

from flask import Flask
import os
import sys 
import datetime
from pytz import timezone

def formatdateinfo():
	# %Z  time zone %z offset
	time_format = "%Y-%m-%d %H:%M:%S %Z%z"
	container = datetime.datetime.now()
#	atl = datetime.datetime.now(timezone('Canada/Atlantic'))
	montreal = datetime.datetime.now(timezone('Canada/Eastern'))
	dateinfo = ""
	for place in [container, montreal]:
		dateinfo +="<h3>Current date and time : " + place.strftime(time_format) + "</h3>"
	return dateinfo

def formatsysinfo(): 
  sysinfo = "platform " + sys.platform + " version " + sys.version
  name = "uname " + os.uname()[4]
  uid = "uid " + str(os.getuid()) + " gid " + str(os.getgid()) 
  cwd = "cwd " + os.getcwd() 
  return "<h3>System Info</h3>"+ sysinfo + "</br>" + name + "</br>" +uid + "</br>" + cwd 

app = Flask(__name__)
port = int(os.environ.get("PORT", 5000))

@app.route("/")

def hello():
   return "<body><h2>Hello World!</h2> <h3> Running Flask from Docker, on Heroku</h3>" +\
		 formatsysinfo() + formatdateinfo() + "</body>"

## nb default: binds to loopback
if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True, port=port)


#    default binds to localhost
#    app.run(debug=True)

#!/usr/bin/python
# pmc sample flask app

# simple version
# 2020-05-04 
# trouble running it on  heroku

from flask import Flask
import os
import sys 
'''
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
''' 
app = Flask(__name__)
@app.route("/")

def hello():
   return "<body><h2>Hello World!</h2> <h3> Running Flask from Docker</h3></body>"
#   return "<body><h2>Hello World!</h2> <h3> Running Flask from Docker</h3>" + formatsysinfo() + formatdateinfo() + "</body>"

## nb default: binds to loopback
if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True)

#    default binds to localhost
#    app.run(debug=True)

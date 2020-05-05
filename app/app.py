#!/usr/bin/python
# pmc sample flask app

# working locally & on heroku

# simple version 1
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
app = Flask(__name__)
port = int(os.environ.get("PORT", 5000))

@app.route("/")

def hello():
   return "<body><h2>Hello World!</h2> <h3> Running Flask from Docker, on Heroku</h3></body>"

## nb default: binds to loopback
if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True, port=port)

#    default binds to localhost
#    app.run(debug=True)

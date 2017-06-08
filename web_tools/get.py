#!/usr/bin/python

import requests
from sys import argv

script, site = argv

user_agent = {'User-agent': 'Mozilla/5.0'}

url = "http://%s" % (site)
r = requests.get(url, headers=(user_agent))
server = r.headers['server']

host = url
print "%s is running %s" %(url,server) 

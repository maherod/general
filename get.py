import requests
from sys import argv

script, site = argv

url = "http://%s" % (site,)
r = requests.get(url)
server = r.headers['server']
host = url

print "%s is running %s" %(url,server)

#!/usr/bin/env python

import random

print "(simple lottery random numbers generator"

while True:
    print ""
    print "Numbers:", random.sample(xrange(1,37), 6)
    print "Strong Number:", random.sample(xrange(1,7), 1)
    print ""
    raw_input("Hit <Enter> for more numbers, <CTRL-C> to Exit>")




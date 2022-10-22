#!/usr/bin/env python3

import sys

for line in sys.stdin:
    line = line.strip().split(",")
    value = 1
    print( "%s\t%d" %(line[16], value) )
#!/usr/bin/env python

import plistlib
import sys

file = open(sys.argv[1], 'rb')
data = plistlib.load(file)
key = 'com.apple.security.application-groups'

for val in list(data[key]):
	if len(val.split('.')) > 4:
		data[key].remove(val)

file = open(sys.argv[1], "wb")
plistlib.dump(data, file)
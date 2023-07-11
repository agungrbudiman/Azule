#!/usr/bin/env python

import plistlib
import sys

file = open(sys.argv[1], 'rb')
data = plistlib.load(file)

for x, y in dict(data).items():
	if type(y) is dict:
		for key, val in dict(y).items():
			if 'PlugIns' in key or 'WatchApp.app' in key:
				del data[x][key]
	else:
		for val in list(y):
			if 'PlugIns' in val or 'WatchApp.app' in val:
				data[x].remove(val)

file = open(sys.argv[1], "wb")
plistlib.dump(data, file)
#! /usr/bin/python
import sys

install_dir = sys.argv[1].strip('./');
text_file = open(install_dir + "/lib/pkgconfig/opencv.pc", "r")
lines = text_file.readlines()

for l in lines:
	if 'Libs' in l:
		flags = (l.strip().replace("${exec_prefix}","$(PAPARAZZI_HOME)/sw/ext/opencv_bebop/" + install_dir).split(" -"))
		iterflags = iter(flags)
		next(iterflags)
		for f in iterflags:
			print("\t<flag name=\"LDFLAGS\" value=\"" + f + "\"/>" )



text_file.close()

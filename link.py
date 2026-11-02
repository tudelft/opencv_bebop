#!/usr/bin/env python3
# Print the paparazzi LDFLAGS for an OpenCV install dir, from its opencv4.pc.
import sys

install_dir = sys.argv[1].strip('./')
with open(install_dir + "/lib/pkgconfig/opencv4.pc", "r") as text_file:
	lines = text_file.readlines()

for l in lines:
	if 'Libs' in l:
		flags = (l.strip().replace("${exec_prefix}","$(PAPARAZZI_HOME)/sw/ext/opencv_bebop/" + install_dir).split(" -"))
		iterflags = iter(flags)
		next(iterflags)
		for f in iterflags:
			# CMake target names (e.g. Iconv::Iconv from wechat_qrcode) leak into
			# opencv4.pc; they are no libraries (iconv is part of glibc).
			if '::' in f:
				continue
			print("\t<flag name=\"LDFLAGS\" value=\"" + f + "\"/>" )

Cross Compile OpenCV for gnu-arm-linux-eabi
===========================================

[![Build Status](https://travis-ci.org/tudelft/opencv_bebop.png?branch=master)](https://travis-ci.org/tudelft/opencv_bebop) [![Gitter chat](https://badges.gitter.im/paparazzi/discuss.svg)](https://gitter.im/paparazzi/discuss)


 - Semi-automated (for some platforms)
 - OpenCV 3.2.0: You can try other versions e.g. v3.0 by checkout out another tag in opencv subfolder
 - Codesourcery arm-2012.03 arm-none-linux-gnueabi-gcc: You can select another compiler in bebop.toolchain.cmake
 - An XML document with the paparazzi link parameters is created in install/opencv.xml: **copy paste these parameters in your opencv module**

For more info: read the Makefile


To build it 100% automatic with defualt settings just use this command:
-------------------

  make



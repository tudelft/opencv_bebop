Cross Compile OpenCV for gnu-arm-linux-eabi
===========================================

 - Semi-automated (for some platforms)
 - OpenCv 3.1.0 (+patches): You can try other versions by checkout out another tag in opencv subfolder
 - gnu-arm-linux-eabi 4.7: You can select another compiler in bebop.toolchain.cmake
 - an xml file with the paparazzi link parameters is created in install/opencv.xml: copy paste these parameters in your opencv module

For more info: read the Makefile


default + automatic:
-------------------

  make



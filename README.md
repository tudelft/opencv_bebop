OpenCV for the Parrot Bebop (Paparazzi)
=======================================

Builds OpenCV 4.10.0 (with `opencv_contrib`) as static libraries for Paparazzi:

 - `arm`: cross-compiled for the Parrot Bebop 1/2, soft-float ABI (`-DSOFTFP=ON`)
 - `pc`: for the NPS simulator on your computer

In Paparazzi this repository is the submodule `sw/ext/opencv_bebop`.

Build
-----

From the Paparazzi root:

    make opencv_bebop

or in this directory:

    make        # update the submodules, build arm and pc
    make arm    # Bebop only
    make pc     # simulator only
    make clean

The results are in `install_arm/` and `install_pc/`. Each also gets an `opencv.xml` with the
`LDFLAGS` for a Paparazzi module, made by `link.py` from `lib/pkgconfig/opencv4.pc`. See
`conf/modules/cv_opencvdemo.xml` in Paparazzi for an example module.

Cross-compiler
--------------

The toolchain file is chosen with `CMAKE_FILE`:

| `CMAKE_FILE` | Compiler |
|---|---|
| `bebop.toolchain.cmake.linux` (default on Linux) | `arm-linux-gnueabi-gcc` from the `PATH` (Ubuntu package `gcc-arm-linux-gnueabi`) |
| `bebop.toolchain.cmake.none-linux` | Parrot toolchain 2012.03 in `/opt/arm-2012.03` |
| `bebop.toolchain.cmake.osx` (default on macOS) | carlson-minot toolchain in `/usr/local/carlson-minot` |

Example: `make arm CMAKE_FILE=bebop.toolchain.cmake.none-linux`

The Paparazzi autopilot that links OpenCV must be built with the same compiler and ABI.
The original Parrot toolchains are listed in
[parrot-opensource/toolchains](https://github.com/parrot-opensource/toolchains).
On Ubuntu 24.04 the `arm-linux-gnueabi-gcc` (GCC 13) autopilot freezes on the Bebop, see
[paparazzi/paparazzi#3596](https://github.com/paparazzi/paparazzi/issues/3596).

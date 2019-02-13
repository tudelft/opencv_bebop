
PWD	= $(shell pwd)

# Use 'make <all|pc|arm>' to compile OpenCV. The crosscompiler can be overridden
# by setting CMAKE_FILE=<toolchain file>.

# This compiles with a soft floating point unit. If you want support
# for hard floating point unit remove -DSOFTFP=ON
# -DENABLE_VFPV3=TRUE for virtual floating point optimisation for arm processors
# -DENABLE_NEON=TRUE for neon hard floating point optimisation

BUILD       ?= pc
BUILD_DIR   ?= ./build_$(BUILD)
INSTALL_DIR ?= ./install_$(BUILD)

# Non-default CMake options that apply to all targets
BUILD_FLAGS ?= -DBUILD_JAVA=OFF \
	-DBUILD_IPP_IW=OFF \
	-DBUILD_ITT=OFF \
	-DBUILD_PACKAGE=OFF \
	-DBUILD_PERF_TESTS=OFF \
	-DBUILD_SHARED_LIBS=OFF \
	-DBUILD_TESTS=OFF \
	-DBUILD_WITH_DEBUG_INFO=ON \
	-DBUILD_opencv_apps=OFF \
	-DBUILD_opencv_java_bindings_generator=OFF \
	-DBUILD_opencv_python2=OFF \
	-DBUILD_opencv_python3=OFF \
	-DBUILD_opencv_python_bindings_generator=OFF \
	-DBUILD_opencv_world=ON \
	-DWITH_EIGEN=OFF \
	-DWITH_FFMPEG=OFF \
	-DWITH_GTK=OFF \
	-DWITH_GTK_2_X=OFF \
	-DWITH_IPP=OFF \
	-DWITH_ITT=OFF \
	-DWITH_JASPER=OFF \
	-DWITH_LAPACK=OFF \
	-DWITH_OPENCL=OFF \
	-DWITH_OPENEXR=OFF \
	-DWITH_VTK=OFF \
	-DWITH_WEBP=OFF
EXTRA_BUILD_FLAGS ?=

# get number of processors for parallel make later
NPROCS:=1
ifeq ($(OS),Windows_NT)
  $(warning Warning: OpenCV compilation on Windows not supported)
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S),Linux)
    CMAKE_FILE     ?= bebop.toolchain.cmake.linux
    NPROCS:=$(shell grep -c ^processor /proc/cpuinfo)
  else
    ifeq ($(UNAME_S),Darwin)
      CMAKE_FILE     ?= bebop.toolchain.cmake.osx
      NPROCS:=$(shell system_profiler | awk '/Number Of CPUs/{print $4}{next;}')
    endif
  endif
endif

# Compilation targets
all: update_submodules arm pc

arm:
	make build BUILD=arm EXTRA_BUILD_FLAGS="\
		-DCMAKE_TOOLCHAIN_FILE=$(PWD)/$(CMAKE_FILE) \
		-DSOFTFP=ON \
		"

pc:
	make build BUILD=pc


# Misc targets
build:
	make cmake BUILD=$(BUILD) EXTRA_BUILD_FLAGS="$(EXTRA_BUILD_FLAGS)"
	make compile BUILD=$(BUILD)
	make linkfile BUILD=$(BUILD)

cmake:
	mkdir -p $(BUILD_DIR)
	cmake -H./opencv -B$(BUILD_DIR) -DCMAKE_INSTALL_PREFIX=$(PWD)/$(INSTALL_DIR) \
		$(BUILD_FLAGS) $(EXTRA_BUILD_FLAGS)

compile:
	make -j$(NPROCS) -C $(BUILD_DIR)
	make -C $(BUILD_DIR) install

linkfile:
	./link.py $(INSTALL_DIR) > $(INSTALL_DIR)/opencv.xml

clean:
	rm -rf ./build*
	rm -rf ./install*
	rm -rf *~

update_submodules:
	git submodule init
	git submodule sync
	git submodule update

.PHONY: all arm pc build cmake compile linkfile clean update_submodules

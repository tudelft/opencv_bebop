
PWD	= ~/opencv_bebop


all:
	mkdir build -p;
	cmake -H./opencv -B./build -DCMAKE_TOOLCHAIN_FILE=$(PWD)/bebop.toolchain.cmake


clean:
	rm -rf ./build

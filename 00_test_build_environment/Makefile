# Remove deprecated gpu targets warning
NVCCFLAGS=-Wno-deprecated-gpu-targets

all: main.cu
	nvcc $(NVCCFLAGS) -o main.exe main.cu

clean:
	rm -rf *.exe
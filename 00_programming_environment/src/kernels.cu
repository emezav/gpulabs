/**
 * @file
 * @brief GPU kernel implementations
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @see Cuda Runtime API https://docs.nvidia.com/cuda/cuda-runtime-api/index.html
 * @copyright MIT License
 */

#include "kernels.cuh"
#include <iostream>

namespace environment
{
  using std::cout;
  using std::endl;

  __global__ void echo_kernel(int *data)
  {
    // Calculate global thread index
    // Assuming 1D grid and 1D blocks for this example
    // int index = blockIdx.x * blockDim.x + threadIdx.x;

    // TODO Store index value at the corresponding position in the data array
    // ... Your code here ...
  }

  void run_echo_kernel()
  {

    // Host data array
    int *h_data;

    // Device data array
    int *d_data;

    // Array size
    int n = 32;

    // Allocate host memory
    h_data = (int *)malloc(n * sizeof(int));

    if (h_data == nullptr)
    {
      cout << "Failed to allocate host memory!" << endl;
      return;
    }

    // Fill host array with zeroes
    for (int i = 0; i < n; ++i)
    {
      h_data[i] = 0;
    }

    // Allocate device memory
    cudaError_t err = cudaMalloc((void **)&d_data, n * sizeof(int));
    if (err != cudaSuccess)
    {
      cout << "Failed to allocate device memory!" << endl;
      free(h_data);
      return;
    }

    // Copy data from host to device
    err = cudaMemcpy(d_data, h_data, n * sizeof(int), cudaMemcpyHostToDevice);
    if (err != cudaSuccess)
    {
      cout << "Failed to copy data from host to device!" << endl;
      cudaFree(d_data);
      free(h_data);
      return;
    }

    // Launch the echo kernel with 1 block of n threads
    echo_kernel<<<1, n>>>(d_data);

    // Copy data back from device to host
    err = cudaMemcpy(h_data, d_data, n * sizeof(int), cudaMemcpyDeviceToHost);
    if (err != cudaSuccess)
    {
      cout << "Failed to copy data from device to host!" << endl;
      cudaFree(d_data);
      free(h_data);
      return;
    }
    // Synchronize again to ensure all operations are complete
    cudaDeviceSynchronize();

    // Print the results
    cout << "Data after kernel execution:" << endl;
    for (int i = 0; i < n; ++i)
    {
      cout << h_data[i] << " ";
    }
    cout << endl;

    // Free device memory
    cudaFree(d_data);

    // Check if the results are correct
    bool passed = false;

    // TODO Verify results on host array
    // Each element in h_data should be equal to its index
    // ... Your verification code here ...

    // In case of success, print "PASSED", otherwise print "FAILED".
    if (passed)
    {
      cout << "PASSED" << endl;
    }
    else
    {
      cout << "FAILED" << endl;
    }

    // Free host memory
    free(h_data);
  }
}

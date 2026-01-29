/**
 * @file
 * @brief GPU kernel implementations
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @see Cuda Runtime API https://docs.nvidia.com/cuda/cuda-runtime-api/index.html
 * @copyright MIT License
 */

 #include <iostream>
#include "config.h"
#include "cpu_timer.h"
#include "gpu_timer.cuh"
#include "kernels.cuh"
#include "validate.h"

namespace kernel_launch
{
  using std::cout;
  using std::endl;

  __global__ void write_index(int *data, int n)
  {
    // TODO Calculate global thread index
    // Assuming 1D grid and 1D blocks for this example
    // int idx = ...
    // TODO Validate index is within bounds
    // TODO Store index value at the corresponding position in the data array
  }

  __global__ void add_constant(int *data, int n, int constant)
  {
    // TODO Calculate global thread index
    // Assuming 1D grid and 1D blocks for this example
    // int idx = ...
    // TODO Validate index is within bounds
    // TODO Add constant to the corresponding position in the data array
  }

  void run_write_index()
  {
    // Host data array
    int *h_data;

    // Validation data array
    int *h_validation_data;

    // Device data array
    int *d_data;

    // Array size
    int n = 32;

    // Create CPU timer
    // TODO  Time only if verbose mode is enabled
    cpu_timer::CpuEventTimer cpu_events;

    cpu_events.start("allocate_host_memory");

    // Allocate host memory for data
    h_data = (int *)malloc(n * sizeof(int));

    if (h_data == nullptr)
    {
      cout << "Failed to allocate host memory!" << endl;
      return;
    }

    auto alloc_elapsed = cpu_events.stop("allocate_host_memory");

    cout << "Elapsed host memory allocation time: " << alloc_elapsed << " ms" << endl;

    // Allocate memory for validation data
    h_validation_data = (int *)malloc(n * sizeof(int));
    if (h_validation_data == nullptr)
    {
      cout << "Failed to allocate host memory for validation data!" << endl;
      free(h_data);
      return;
    }

    // Validation data contains each element equal to its index
    for (int i = 0; i < n; ++i)
    {
      h_validation_data[i] = i;
    }

    // Allocate device memory
    cudaError_t err = cudaMalloc((void **)&d_data, n * sizeof(int));
    if (err != cudaSuccess)
    {
      cout << "Failed to allocate device memory!" << endl;
      free(h_data);
      return;
    }

    // Create GPU timer
    // TODO  Time only if verbose mode is enabled
    gpu_timer::GpuEventTimer gpu_events;

    // Time data transfer and kernel execution
    gpu_events.start("write_index_transfer");

    // Copy data from host to device
    err = cudaMemcpy(d_data, h_data, n * sizeof(int), cudaMemcpyHostToDevice);
    if (err != cudaSuccess)
    {
      cout << "Failed to copy data from host to device!" << endl;
      cudaFree(d_data);
      free(h_data);
      free(h_validation_data);
      return;
    }

    auto transfer_elapsed = gpu_events.stop("write_index_transfer");

    cout << "Elapsed transfer time: " << transfer_elapsed << " ms" << endl;

    // Get launch configuration
    config::LaunchConfig config;

    // TODO Use get_1D_launch_config from config.h

    // Remember to specify appropriate array size and block size
    // comment previous declaration of config
    // and uncomment the line below

    // config::LaunchConfig config = config::get_1D_launch_config(..., ...);

    // Launch the write_index kernel with the computed configuration
    write_index<<<config.grid_dim, config.block_dim>>>(d_data, n);

    // TODO Synchronize to ensure kernel execution is complete and check for kernel launch errors

    // Copy data back from device to host
    err = cudaMemcpy(h_data, d_data, n * sizeof(int), cudaMemcpyDeviceToHost);
    if (err != cudaSuccess)
    {
      cout << "Failed to copy data from device to host!" << endl;
      cudaFree(d_data);
      free(h_data);
      free(h_validation_data);
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

    // TODO Validate results against validation data
    // Use the correct equal function from validate.h

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
    free(h_validation_data);
  }

  // TODO Implement the run_add_constant function
  // (this function must validate the results like run_write_index)

}

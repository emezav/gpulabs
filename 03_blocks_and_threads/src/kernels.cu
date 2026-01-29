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
#include "indexing.cuh"
#include "kernels.cuh"
#include "validate.h"

namespace blocks_and_threads
{
  using std::cout;
  using std::endl;

  __global__ void write_index_1D(int *data, int n)
  {
    // Get global thread index
    int idx = global_index_1D();
    // TODO Validate index is within bounds
    // Store index value at the corresponding position in the data array
    data[idx] = idx;
  }

  __global__ void add_constant_1D(int *data, int n, int constant)
  {
    // Get global thread index
    int idx = global_index_1D();
    // TODO Validate index is within bounds
    // Add constant to the corresponding position in the data array
    data[idx] += constant;
  }

  __global__ void write_sequential_2D(int *data, int rows, int cols)
  {
    // Calculate global row and column indices
    int2 idx2D = global_index_2D();
    int row = idx2D.y;
    int col = idx2D.x;
    // TODO Validate row and column indices are within bounds
    // Calculate linear index and store sequential value
    int idx = linear_index_2D(row, col, cols);
    data[idx] = idx;
  }

  __global__ void add_constant_2D(int *data, int rows, int cols, int constant)
  {
    // Calculate global row and column indices
    int2 idx2D = global_index_2D();
    int row = idx2D.y;
    int col = idx2D.x;
    // TODO Validate row and column indices are within bounds
    // Calculate linear index and add constant to the corresponding position
    int idx = linear_index_2D(row, col, cols);
    data[idx] += constant;
  }

  // TODO add parameters to allow flexibility in testing different scenarios
  void run_write_index_1D()
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
    // OPTIONAL: encapsulate in a function
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
      free(h_validation_data);
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
    write_index_1D<<<config.grid_dim, config.block_dim>>>(d_data, n);

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

    // DO NOT Print the results, this is just for debugging small arrays
    // Delete the following lines or leave them commented out
    // cout << "Data after kernel execution:" << endl;
    // for (int i = 0; i < n; ++i)
    // {
    //   cout << h_data[i] << " ";
    // }
    // cout << endl;

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

  // TODO Implement the run_add_constant_1D function
  // Add necessary parameters to allow flexibility in testing different scenarios
  void run_add_constant_1D()
  {
    // Implementation goes here
    // General process:
    // 1. Allocate and initialize host data and validation arrays
    //    Optional: encapsulate data initialization in a function
    // 2. Allocate device memory
    // 3. Copy data from host to device
    // 4. Configure and launch the add_constant_1D kernel
    // 5. Copy results back to host
    // 6. Validate results
    // 7. Free allocated memory
  }

  // TODO Implement the run_write_sequential_2D function
  // Add necessary parameters to allow flexibility in testing different scenarios
  void run_write_sequential_2D()
  {
    // Implementation goes here
    // General process:
    // 1. Allocate and initialize host data and validation arrays
    //    sequential values for validation: row 1  = 0, 1, 2 ...cols - 1, row 2 = cols, cols+1, ...
    //    Optional: encapsulate data initialization in a function
    // 2. Allocate device memory
    // 3. Copy data from host to device
    // 4. Configure and launch the write_sequential_2D kernel
    // 5. Copy results back to host
    // 6. Validate results
    // 7. Free allocated memory
  }

  void run_add_constant_2D()
  {
    // Implementation goes here
    // General process:
    // 1. Allocate and initialize host data and validation arrays
    //    Optional: encapsulate data initialization in a function
    // 2. Allocate device memory
    // 3. Copy data from host to device
    // 4. Configure and launch the add_constant_2D kernel
    // 5. Copy results back to host
    // 6. Validate results
    // 7. Free allocated memory
  }
}

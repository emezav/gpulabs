/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Programming environment for GPU computing using CUDA
 * @copyright MIT License
 */

#include <iostream>

#include <cuda_runtime.h>
#include "environment.h"

namespace environment
{
  using std::cout;
  using std::endl;

  cudaError_t get_device_count(int &device_count)
  {
    // This function is just a wrapper around the CUDA Runtime API function
    // to get the number of CUDA-capable devices.
    // https://docs.nvidia.com/cuda/cuda-runtime-api/index.html

    // Call the CUDA Runtime API to get the number of devices.
    return cudaGetDeviceCount(&device_count);
  }

} // namespace environment
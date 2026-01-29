/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Programming environment for GPU computing using CUDA
 */

#ifndef ENVIRONMENT_H
#define ENVIRONMENT_H

#include <cuda_runtime.h>

/**
 * @brief Programming environment for GPU computing using CUDA
 */
namespace environment
{
  /**
   * @brief Returns the number of CUDA-capable devices available.
   * @param device_count Reference to an integer to store the device count.
   * @return cudaError_t Returns cudaSuccess on success, or an error code on failure.
   */
  cudaError_t get_device_count(int &device_count );
}
#endif // ENVIRONMENT_H
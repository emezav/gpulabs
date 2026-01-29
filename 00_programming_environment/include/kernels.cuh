/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Kernel function declarations
 * @copyright MIT License
 */

#ifndef KERNELS_CUH
#define KERNELS_CUH

#include <cuda_runtime.h>

namespace environment
{
  /**
   * @brief Echo kernel function
   * @param data Pointer to the data array
   */
  __global__ void echo_kernel(int *data);

  /**
   * @brief Runs the echo kernel
   */
  void run_echo_kernel();
}

#endif // KERNELS_CUH
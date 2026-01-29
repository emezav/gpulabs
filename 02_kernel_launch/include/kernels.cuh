/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Kernel function declarations
 * @copyright MIT License
 */

#ifndef KERNELS_CUH
#define KERNELS_CUH

#include <cuda_runtime.h>

namespace kernel_launch
{
  /**
   * @brief Writes the global thread index into the data array
   * @param data Pointer to the data array
   */
  __global__ void write_index(int *data, int n);

  /**
   * @brief Adds a constant value to each element in the data array
   * @param data Pointer to the data array
   * @param n Number of elements in the data array
   * @param constant The constant value to add
   */
  __global__ void add_constant(int *data, int n, int constant);

  /**
   * @brief Runs the write_index kernel
   */
  void run_write_index();
}

#endif // KERNELS_CUH
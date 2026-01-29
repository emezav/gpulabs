/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Kernel function declarations
 * @copyright MIT License
 */

#ifndef KERNELS_CUH
#define KERNELS_CUH

#include <cuda_runtime.h>

namespace blocks_and_threads
{
  /**
   * @brief Writes the global thread index into the 1D data array
   * @param data Pointer to the data array
   * @param n Number of elements in the data array
   */
  __global__ void write_index_1D(int *data, int n);

  /**
   * @brief Adds a constant value to each element in the 1D data array
   * @param data Pointer to the data array
   * @param n Number of elements in the data array
   * @param constant The constant value to add
   */
  __global__ void add_constant_1D(int *data, int n, int constant);

  /**
   * @brief Writes sequential values into a 2D data array
   * @param data Pointer to the data array
   * @param rows Number of rows in the data array
   * @param cols Number of columns in the data array
   */
  __global__ void write_sequential_2D(int *data, int rows, int cols);

  /**
   * @brief Adds a constant value to each element in the 2D data array
   * @param data Pointer to the data array
   * @param rows Number of rows in the data array
   * @param cols Number of columns in the data array
   * @param constant The constant value to add
   */
  __global__ void add_constant_2D(int *data, int rows, int cols, int constant);


  /**
   * @brief Runs the write_index_1D kernel
   * TODO add parameters to allow flexibility in testing different scenarios
   */
  void run_write_index_1D();

  /**
   * @brief Runs the add_constant_1D kernel
   * TODO add parameters to allow flexibility in testing different scenarios
   */
  void run_add_constant_1D();

  /**
   * @brief Runs the write_sequential_2D kernel
   * TODO add parameters to allow flexibility in testing different scenarios
   */
  void run_write_sequential_2D();

  /**
   * @brief Runs the add_constant_2D kernel
   * TODO add parameters to allow flexibility in testing different scenarios
   */
  void run_add_constant_2D();
}

#endif // KERNELS_CUH
/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Indexing related functions and utilities
 * @copyright MIT License
 */

#ifndef INDEXING_CUH
#define INDEXING_CUH
#include <cuda_runtime.h>

/**
 * @brief Get the global index 1D object
 * @return The global thread index for 1D grid and 1D blocks
 */
__device__ __forceinline__ int global_index_1D()
{
  // TODO Calculate and return the global thread index
  // for 1D grid and 1D blocks
  return 0;
}

/**
 * @brief Get the global index 2D object
 * @return The global row and column indices for 2D grid and 2D blocks
 */
__device__ __forceinline__ int2 global_index_2D()
{
  // TODO Calculate and return the global row and column (x = col, y= row) indices
  // for 2D grid and 2D blocks
  return make_int2(0, 0);
}

/**
 * @brief Get the linear index from 2D indices
 * @param row The row index
 * @param col The column index
 * @param num_cols The number of columns in the 2D grid
 * @return The linear index corresponding to the given row and column
 */
__host__ __device__ __forceinline__ int linear_index_2D(int row, int col, int num_cols)
{
  // TODO Calculate and return the linear index
  // from the given row and column indices
  return 0;
}

#endif // INDEXING_CUH

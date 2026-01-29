/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Project configuration options
 * @copyright MIT License
 */

#ifndef CONFIG_H
#define CONFIG_H

#include <cuda_runtime.h>

/** @brief Enable verbose output */
#define GPULABS_VERBOSE 1

namespace config
{

  /** @brief Launch configuration for kernels
   * @see https://docs.nvidia.com/cuda/cuda-programming-guide/05-appendices/cpp-language-extensions.html#kernel-configuration
  */
  struct LaunchConfig
  {
    dim3 grid_dim; /*!< Number of blocks per grid */
    dim3 block_dim;   /*!< Number of threads per block */
  };

  /** @brief Get the launch configuration for 1D kernels
   * Total of threads for the data domain = n
   * @param n Total number of elements (threads required)
   * @param threads_per_block Number of threads per block
   * @return LaunchConfig 1D launch configuration
   */
  LaunchConfig get_1D_launch_config(int n, int threads_per_block);

  /** @brief Get the launch configuration for 2D kernels
   * Total of threads for the data domain = width * height
   * @param width Width of the data in x dimension
   * @param height Height of the data in y dimension
   * @param threads_per_block_x Number of threads per block in x dimension
   * @param threads_per_block_y Number of threads per block in y dimension
   * @return LaunchConfig 2D launch configuration
   */
  LaunchConfig get_2D_launch_config(int width, int height, int threads_per_block_x, int threads_per_block_y);

} // namespace config

#endif // CONFIG_H

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

  /** @brief Launch configuration for kernels */
  struct LaunchConfig
  {
    dim3 grid_dim; /*!< Number of blocks per grid */
    dim3 block_dim;   /*!< Number of threads per block */
  };

  /** @brief Get the launch configuration for 1D kernels
   * @param n Total number of elements (threads required)
   * @param threads_per_block Number of threads per block
   * @return LaunchConfig 1D launch configuration
   */
  LaunchConfig get_1D_launch_config(int n, int threads_per_block);

} // namespace config

#endif // CONFIG_H
/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Implementation of configuration utilities for CUDA kernel launches.
 * @copyright MIT License
 */

#include "config.h"

namespace config
{
  LaunchConfig get_1D_launch_config(int total_threads, int threads_per_block)
  {
    LaunchConfig config;

    // Calculate the number of blocks needed, rounding up
    int blocks = (total_threads + threads_per_block - 1) / threads_per_block;

    // Set the launch configuration
    config.grid_dim = dim3(blocks, 1, 1);
    config.block_dim = dim3(threads_per_block, 1, 1);

    return config;
  }

  LaunchConfig get_2D_launch_config(int width, int height, int threads_per_block_x, int threads_per_block_y)
  {
    LaunchConfig config;

    // Calculate the number of blocks needed in each dimension, rounding up
    int blocks_x = (width + threads_per_block_x - 1) / threads_per_block_x;
    int blocks_y = (height + threads_per_block_y - 1) / threads_per_block_y;

    // Set the launch configuration
    config.grid_dim = dim3(blocks_x, blocks_y, 1);
    config.block_dim = dim3(threads_per_block_x, threads_per_block_y, 1);

    return config;
  }
}

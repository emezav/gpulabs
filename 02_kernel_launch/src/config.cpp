/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Implementation of configuration utilities for CUDA kernel launches.
 * @copyright MIT License
 */

#include "config.h"

namespace config
{
  LaunchConfig get_1D_launch_config(int n, int threads_per_block)
  {
    LaunchConfig config;

    // Calculate the number of blocks needed, rounding up
    int blocks = (n + threads_per_block - 1) / threads_per_block;

    // Set the launch configuration
    config.grid_dim = dim3(blocks, 1, 1);
    config.block_dim = dim3(threads_per_block, 1, 1);

    return config;
  }
}

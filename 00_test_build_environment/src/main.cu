/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>
 * @brief Test build environment
 * @version 1.0
 * @date 2025-03-15
 *
 * @copyright Copyright (c) 2025 Onwards MIT License
 *
 */

#include <cuda_runtime.h>
#include <iostream>

/// @brief Main subroutine
/// @return 0 on success, != 0 on error
int main()
{
    // Store CUDA device count
    int count;

    // Get device count and store into count
    cudaGetDeviceCount(&count);

    // Send information to stdout
    std::cout << "CUDA device count is: " << count << std::endl;

    // End the program.
    return 0;
}

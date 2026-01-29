/**
 * @file
 * @author Erwin Meza Vega <emezav@(unicauca.edu.co|gmail.com)>
 * @brief Experiments on blocks and threads configuration in CUDA
 * @copyright Copyright MIT License
 *
 */

#include <iostream>
#include "environment.h"
#include "kernels.cuh"

/// @brief Main subroutine
/// @return 0 on success, != 0 on error
int main()
{
    // Get the number of CUDA-capable devices.
    int device_count = 0;
    cudaError_t error_id = environment::get_device_count(device_count);

    if (error_id != cudaSuccess)
    {
        std::cerr << "Error retrieving the number of CUDA-capable devices." << std::endl;
        return 1;
    }

    // Print the number of devices found.
    std::cout << "Number of CUDA-capable devices: " << device_count << std::endl;

    // Select the first device (device 0) if available.
    if (device_count > 0)
    {
        error_id = cudaSetDevice(0);
        if (error_id != cudaSuccess)
        {
            std::cerr << "Error setting CUDA device 0." << std::endl;
            return 1;
        }
    }

    // TODO setup four experiments:
    // 1. 1D kernel to write index at its position, or add a constant to an array, with n = multiple of block size
    // 2. 1D kernel to write index at its position, or add a constant to an array, with n not a multiple of block size
    // 3. 2D kernel to write sequential values in a 2D array or add a constant, with width and height as multiples of block dimensions
    // 4. 2D kernel to write sequential values in a 2D array or add a constant, with width and height not as multiples of block dimensions
    // For each experiment, implement the necessary host and device code to perform the operations and validate the results.
    // Parameters must be defined on the host side or passed as arguments to the functions.
    // You can change the function signature, if necessary, to pass parameters (n, width, height).
    // Make sure to validate the results after each kernel execution.
    // Choose a reasonable block size (e.g., 128 or 256 threads per block for 1D, and 16x16 or 32x32 for 2D) based on the GPU architecture.
    // Also choose appropriate values for n, width, and height to test both scenarios (multiples and non-multiples of block size).
    // Array sizes should be manageable within the GPU memory limits, but large enough to observe the effects of different block and grid configurations.
    // Block size must be defined as constants or macros in config.h for easy modification.
    // Do not print the entire arrays; instead, print summaries or specific elements to verify correctness.
    // Validation must guarantee that the results are correct, each element has the expected value after kernel execution.

    // Experiment 1: 1D kernel with n as a multiple of block size
    std::cout << "Starting CUDA kernel execution..." << std::endl;
    // TODO launch run_write_index_1D function, change parameters if needed
    blocks_and_threads::run_write_index_1D();
    // TODO .. or launch run_add_constant_1D function, change parameters if needed
    // blocks_and_threads::run_add_constant_1D();

    // Experiment 2: 1D kernel with n not as a multiple of block size
    // TODO repeat the same experiment, but change n to a non-multiple of block size

    // Experiment 3: 2D kernel with width and height as multiples of block dimensions
    // TODO launch run_write_sequential_2D function, change parameters if needed
    blocks_and_threads::run_write_sequential_2D();
    // TODO ... or launch run_add_constant_2D function, change parameters if needed
    //blocks_and_threads::run_add_constant_2D();

    // Experiment 4: 2D kernel with width and height not as multiples of block dimensions
    // TODO repeat the same experiment, but change width and height to non-multiples of block dimensions
    std::cout << "CUDA kernel execution completed." << std::endl;

    // End the program.
    return 0;
}


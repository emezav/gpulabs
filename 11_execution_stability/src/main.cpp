/**
 * @file
 * @author Erwin Meza Vega <emezav@(unicauca.edu.co|gmail.com)>
 * @brief Experiments on blocks and threads configuration in CUDA
 * @copyright Copyright MIT License
 *
 */

#include <iostream>
#include "environment.h"
#include "experiments.cuh"

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

    // Run the experiments.
    experiments::run_experiments();

    // End the program.
    return 0;
}


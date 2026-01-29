/**
 * @file
 * @author Erwin Meza Vega <emezav@(unicauca.edu.co|gmail.com)>
 * @brief Programming environment for GPU computing using CUDA
 *
 * @copyright MIT License
 *
 */

#include <iostream>
#include "capabilities.h"
#include "environment.h"


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

    // Iterate over each device and print its properties.
    for (int device_id = 0; device_id < device_count; ++device_id)
    {
        cudaDeviceProp device_prop;
        // TODO check for errors and skip to the next device if an error occurs.
        capabilities::get_device_properties(device_id, device_prop);

        std::cout << "Device " << device_id << ": " << device_prop.name << std::endl;
        // TODO print the required information - see README.md for details.

        // Query and print additional capabilities, e.g., compute capability.
        int major = 0, minor = 0;

        // TODO check for errors and skip to the next device if an error occurs.
        capabilities::get_compute_capability(device_id, major, minor);

        std::cout << "  Compute Capability: " << major << "." << minor << std::endl;
        // TODO check if the device meets minimum requirements (i.e. major >= CUDA_MAJOR_REQUIRED && minor >= CUDA_MINOR_REQUIRED).
    }

    // End the program.
    return 0;
}

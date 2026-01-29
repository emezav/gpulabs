/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Capabilities Header File
 * @copyright MIT License
 */
#ifndef CAPABILITIES_H
#define CAPABILITIES_H
#include <cuda_runtime.h>

namespace capabilities
{

  /**
   * @brief Retrieves the properties of a specified CUDA device.
   *
   * @param device_id The ID of the CUDA device.
   * @param device_prop Reference to a cudaDeviceProp structure to store the device properties.
   * @return cudaError_t Returns cudaSuccess on success, or an error code on failure.
   */
  cudaError_t get_device_properties(int device_id, cudaDeviceProp &device_prop);

  /**
   * @brief Retrieves the compute capability of a specified CUDA device.
   *
   * @param device_id The ID of the CUDA device.
   * @param major Reference to store the major version of the compute capability.
   * @param minor Reference to store the minor version of the compute capability.
   * @return cudaError_t Returns cudaSuccess on success, or an error code on failure.
   */
  cudaError_t get_compute_capability(int device_id, int &major, int &minor);
} // namespace capabilities

#endif // CAPABILITIES_H
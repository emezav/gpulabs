/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Capabilities Header File
 * @copyright MIT License
 */

 #include "capabilities.h"

 namespace capabilities {

  cudaError_t get_device_properties(int device_id, cudaDeviceProp &device_prop) {
    return cudaGetDeviceProperties(&device_prop, device_id);
  }

  cudaError_t get_compute_capability(int device_id, int &major, int &minor) {
    return cudaDeviceGetAttribute(&major, cudaDevAttrComputeCapabilityMajor, device_id) == cudaSuccess &&
           cudaDeviceGetAttribute(&minor, cudaDevAttrComputeCapabilityMinor, device_id) == cudaSuccess
           ? cudaSuccess
           : cudaErrorInvalidDevice;
  }
 }
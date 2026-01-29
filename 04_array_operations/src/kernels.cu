/**
 * @file
 * @brief GPU kernel implementations
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @see Cuda Runtime API https://docs.nvidia.com/cuda/cuda-runtime-api/index.html
 * @copyright MIT License
 */

#include <iostream>
#include "config.h"
#include "data_gen.h"
#include "cpu_timer.h"
#include "array_ops.h"
#include "gpu_timer.cuh"
#include "indexing.cuh"
#include "kernels.cuh"
#include "validate.h"

namespace kernels
{
  using std::cout;
  using std::endl;

  // Each experiment function does the following:
  // 1. Prints the experiment parameters
  // 2. Sets up GPU timer
  // 3. Allocates and initializes data on host and device as needed
  // 4. Launches the kernel being tested
  // 5. Stops the GPU timer and prints the elapsed time
  // 6. Validates the results and prints elapsed time
  // 7. Cleans up allocated memory

  void scale_experiment(int n, float scale_factor, int threads_per_block = GPULABS_THREADS_PER_BLOCK)
  {
    cout << "Running scale experiment with n = " << n
         << " and scale_factor = " << scale_factor << "..." << endl;

    // 1. Allocate and initialize data on host
    float *h_data = new float[n];
    data_gen::random_floats(h_data, n);

    // 1.1 Allocate validation data
    float *validation_data = new float[n];

    // 1.2 Prepare validation data (timing the results on CPU)
    cpu_timer::CpuEventTimer cpu_timer;
    cpu_timer.start("cpu_scale");
    array_ops::cpu_scale(validation_data, h_data, scale_factor, n);
    cpu_timer.stop("cpu_scale");
    float cpu_time = cpu_timer.elapsed_milliseconds("cpu_scale");
    cout << "CPU scale time: " << cpu_time << " ms" << endl;

    // 1.3 Prints 5 first elements of input data and validation data
    cout << "First 5 elements of input data: ";
    for (int i = 0; i < 5; i++)
    {
      cout << h_data[i] << " ";
    }
    cout << endl;

    cout << "First 5 elements of validation data: ";
    for (int i = 0; i < 5; i++)
    {
      cout << validation_data[i] << " ";
    }
    cout << endl;

    // 2. Allocate data on device
    float *d_data;
    cudaMalloc((void **)&d_data, n * sizeof(float));

    // 3. Copy data from host to device
    cudaMemcpy(d_data, h_data, n * sizeof(float), cudaMemcpyHostToDevice);

    // 3.1 Allocate output array on device
    float *d_out;
    cudaMalloc((void **)&d_out, n * sizeof(float));

    // 4. Setup GPU timer
    gpu_timer::GpuEventTimer gpu_timer;
    gpu_timer.start("gpu_scale");

    // 5. Launch kernel
    array_ops::gpu_scale(d_out, d_data, scale_factor, n, threads_per_block);

    // 6. Stop GPU timer
    float gpu_time = gpu_timer.stop("gpu_scale");

    // 7. Copy result back to host
    float *h_result = new float[n];
    cudaMemcpy(h_result, d_out, n * sizeof(float), cudaMemcpyDeviceToHost);

    // 7.1 Print first 5 elements of result
    cout << "First 5 elements of result data: ";
    for (int i = 0; i < 5; i++)
    {
      cout << h_result[i] << " ";
    }
    cout << endl;

    // 8. Validate results and print elapsed time
    bool valid = validate::relative_equal(validation_data, h_result, n, 0.1f);

    if (valid)
    {
      cout << "Scale experiment passed! Elapsed time: " << gpu_time << " ms" << endl;
    }
    else
    {
      cout << "Scale experiment failed!" << endl;
    }

    // Calculate speedup

    float speedup = cpu_time / gpu_time;
    cout << "Speedup: " << speedup << "x" << endl;

    // 9. Clean up
    delete[] h_data;
    delete[] validation_data;
    delete[] h_result;
    cudaFree(d_data);
    cudaFree(d_out);
  }

  void run_kernel_experiments()
  {
    cout << "Running kernel experiments..." << endl;
    // Example parameters for the scale experiment
    int n = 1 << 20; // 1 million elements
    float scale_factor = 2.5f; // each element will be scaled by this factor
    int threads_per_block = GPULABS_THREADS_PER_BLOCK; // default threads per block
    cout << "Experiment parameters: " << endl;
    cout << "  n = " << n << endl;
    cout << "  scale_factor = " << scale_factor << endl;
    cout << "  threads_per_block = " << threads_per_block << endl;
    scale_experiment(n, scale_factor, threads_per_block);
    cout << "Kernel experiments completed." << endl;

    // TODO Setup and run more experiments as needed

  }
}

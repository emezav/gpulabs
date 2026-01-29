/**
 * @file
 * @brief Implementation of GPU kernel experiments
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
#include "experiments.cuh"
#include "validate.h"

namespace experiments
{
  using std::cout;
  using std::endl;

  // Each experiment function does the following general process.
  // 0. Prints the experiment parameters
  // 1. Allocates and initializes data to process and validation data on host
  // 2. Allocates data on device
  // 3. Copies data from host to device
  // 4. Sets up the GPU timer
  // 5. Launches the kernel being tested
  // 6. Stops the GPU timer and prints the elapsed time
  // 7. Copies the result back to host
  // 8. Validates the results and prints elapsed time
  // 9. Cleans up allocated memory

  void scale_1D_experiment(int n, float scale_factor, int threads_per_block = GPULABS_THREADS_PER_BLOCK)
  {
    // 0. Print experiment parameters
    cout << "Scale 1D experiment parameters: " << endl;
    cout << "  n = " << n << endl;
    cout << "  scale_factor = " << scale_factor << endl;
    cout << "  threads_per_block = " << threads_per_block << endl;

    // 1. Allocate and initialize data on host
    float *h_data = new float[n];
    data_gen::random_floats(h_data, n);

    // 1.1 Allocate validation data
    float *validation_data = new float[n];

    // 1.2 Prepare validation data (timing the results on CPU)
    cpu_timer::CpuEventTimer cpu_events;
    cpu_events.start("cpu_scale");
    array_ops::cpu_scale(validation_data, h_data, scale_factor, n);
    float cpu_time = cpu_events.stop("cpu_scale");
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
    gpu_timer::GpuEventTimer gpu_events;
    gpu_events.start("gpu_scale");

    // 5. Launch kernel
    array_ops::gpu_scale(d_out, d_data, scale_factor, n, threads_per_block);

    // 6. Stop GPU timer
    float gpu_time = gpu_events.stop("gpu_scale");

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

  void add_2d_experiment(int width, int height, int threads_per_block = GPULABS_THREADS_PER_BLOCK)
  {
    // 0. Print experiment parameters
    cout << "Add 2D experiment parameters: " << endl;
    cout << "  width = " << width << endl;
    cout << "  height = " << height << endl;
    cout << "  threads_per_block = " << threads_per_block << endl;
    cout << endl;

    // 1. Allocate and initialize data on host
    size_t size = width * height;
    float *h_A = new float[size];
    float *h_B = new float[size];
    data_gen::random_floats(h_A, size);
    data_gen::random_floats(h_B, size);
    // 1.1 Allocate validation data
    float *validation_data = new float[size];
    // 1.2 Prepare validation data (timing the results on CPU)
    cpu_timer::CpuEventTimer cpu_events;
    cpu_events.start("cpu_add_2d");
    array_ops::cpu_add(validation_data, h_A, h_B, size);
    float cpu_time = cpu_events.stop("cpu_add_2d");
    cout << "CPU 2D add time: " << cpu_time << " ms" << endl;
    // 1.3 Prints 5 first elements of input data and validation data
    cout << "First 5 elements of input data A: ";
    for (int i = 0; i < 5; i++)
    {
      cout << h_A[i] << " ";
    }
    cout << endl;
    cout << "First 5 elements of input data B: ";
    for (int i = 0; i < 5; i++)
    {
      cout << h_B[i] << " ";
    }
    cout << endl;
    cout << "First 5 elements of validation data: ";
    for (int i = 0; i < 5; i++)
    {
      cout << validation_data[i] << " ";
    }
    cout << endl;

    // 2. Allocate data on device
    float *d_A, *d_B, *d_out;
    cudaMalloc((void **)&d_A, size * sizeof(float));
    cudaMalloc((void **)&d_B, size * sizeof(float));
    cudaMalloc((void **)&d_out, size * sizeof(float));
    // 3. Copy data from host to device
    cudaMemcpy(d_A, h_A, size * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size * sizeof(float), cudaMemcpyHostToDevice);
    // 4. Setup GPU timer
    gpu_timer::GpuEventTimer gpu_events;
    gpu_events.start("gpu_add_2d");
    // 5. Launch kernel
    array_ops::gpu_add(d_out, d_A, d_B, size, threads_per_block);
    // 6. Stop GPU timer
    float gpu_time = gpu_events.stop("gpu_add_2d");
    // 7. Copy result back to host
    float *h_result = new float[size];
    cudaMemcpy(h_result, d_out, size * sizeof(float), cudaMemcpyDeviceToHost);
    // 7.1 Print first 5 elements of result
    cout << "First 5 elements of result: ";
    for (int i = 0; i < 5; i++)
    {
      cout << h_result[i] << " ";
    }
    cout << endl;
    // 8. Validate results and print elapsed time
    bool valid = validate::relative_equal(validation_data, h_result, size, 0.1f);
    if (valid)
    {
      cout << "2D Add experiment passed! Elapsed time: " << gpu_time << " ms" << endl;
    }
    else
    {
      cout << "2D Add experiment failed!" << endl;
    }

    // Calculate speedup
    float speedup = cpu_time / gpu_time;
    cout << "Speedup: " << speedup << "x" << endl;

    // 9. Clean up
    delete[] h_A;
    delete[] h_B;
    delete[] validation_data;
    delete[] h_result;
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_out);

  }

  void run_experiments()
  {
    cout << "Running experiments..." << endl;
    // Example parameters for the scale experiment
    int n = 1 << 20;                                   // 1 million elements
    float scale_factor = 2.5f;                         // each element will be scaled by this factor
    int threads_per_block = GPULABS_THREADS_PER_BLOCK; // default threads per block

    scale_1D_experiment(n, scale_factor, threads_per_block);

    int width = 1024;  // width of the 2D arrays
    int height = 1024; // height of the 2D arrays
    add_2d_experiment(width, height, threads_per_block);
    cout << "Kernel experiments completed." << endl;

    // TODO Setup and run more experiments as needed
    // Matrix scale experiment
    // GEMV row-wise experiment (matrix x vector)
    // GEMM experiment (matrix x matrix)
  }
}

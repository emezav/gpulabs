/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief GPU implementations of array operations.
 * @copyright MIT License
 */

 #include "array_ops.h"
 #include "config.h"
 #include "indexing.cuh"
#include <cfloat>

namespace array_ops
{
  __global__ void gpu_add_kernel(float *out, const float *a, const float *b, int n)
  {
    // Get the global thread index (TODO: implement global_index_1D in indexing.cuh)
    int idx = global_index_1D();
    if (idx < n)
    {
      out[idx] = a[idx] + b[idx];
    }
  }

  void gpu_add(float *out, const float *a, const float *b, int n, int threads_per_block)
  {
    // Define block and grid sizes
    // Review GPULABS_THREADS_PER_BLOCK in config.h
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);
    // Launch the kernel
    gpu_add_kernel<<<config.grid_dim, config.block_dim>>>(out, a, b, n);

    // Synchronize to ensure completion
    // TODO implement error checking
    cudaDeviceSynchronize();
  }

  __global__ void gpu_scale_kernel(float *out, const float *in, float scale, int n)
  {
    // Get the global thread index (TODO: implement global_index_1D in indexing.cuh)
    int idx = global_index_1D();
    if (idx < n)
    {
      out[idx] = in[idx] * scale;
    }
  }

  void gpu_scale(float *out, const float *in, float scale, int n, int threads_per_block)
  {
    // Define block and grid sizes
    // Review GPULABS_THREADS_PER_BLOCK in config.h
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Launch the kernel
    gpu_scale_kernel<<<config.grid_dim, config.block_dim>>>(out, in, scale, n);

    // Synchronize to ensure completion
    // TODO implement error checking
    cudaDeviceSynchronize();
  }

  __global__ void gpu_saxpy_kernel(float *out, const float *x, const float *y, float a, int n)
  {
    // Get the global thread index (TODO: implement global_index_1D in indexing.cuh)
    int idx = global_index_1D();
    if (idx < n)
    {
      out[idx] = a * x[idx] + y[idx];
    }
  }

  void gpu_saxpy(float *out, const float *x, const float *y, float a, int n, int threads_per_block)
  {
    // Define block and grid sizes
    // Review GPULABS_THREADS_PER_BLOCK in config.h
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Launch the kernel
    gpu_saxpy_kernel<<<config.grid_dim, config.block_dim>>>(out, x, y, a, n);

    // Synchronize to ensure completion
    // TODO implement error checking
    cudaDeviceSynchronize();
  }

  __global__ void gpu_dot_kernel(const float *a, const float *b, float *partial_sums, int n)
  {
    // Shared memory for partial sums within a block
    extern __shared__ float shared_data[];

    int idx = global_index_1D();
    int tid = threadIdx.x;

    // Each thread computes its product
    float temp = 0.0f;
    if (idx < n)
    {
      temp = a[idx] * b[idx];
    }
    shared_data[tid] = temp;
    __syncthreads();

    // Reduce within the block
    for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
    {
      if (tid < stride)
      {
        shared_data[tid] += shared_data[tid + stride];
      }
      __syncthreads();
    }

    // Write the block's partial sum to global memory
    if (tid == 0)
    {
      partial_sums[blockIdx.x] = shared_data[0];
    }
  }

  void gpu_dot(const float *a, const float *b, float *result, int n, int threads_per_block)
  {
    // Define block and grid sizes
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Allocate memory for partial sums
    float *d_partial_sums;
    int num_blocks = config.grid_dim.x;
    cudaMalloc(&d_partial_sums, num_blocks * sizeof(float));

    // Launch the kernel
    gpu_dot_kernel<<<config.grid_dim, config.block_dim, config.block_dim.x * sizeof(float)>>>(a, b, d_partial_sums, n);

    // Copy partial sums back to host
    float *h_partial_sums = new float[num_blocks];
    cudaMemcpy(h_partial_sums, d_partial_sums, num_blocks * sizeof(float), cudaMemcpyDeviceToHost);

    // Final reduction on host
    float total = 0.0f;
    for (int i = 0; i < num_blocks; ++i)
    {
      total += h_partial_sums[i];
    }
    *result = total;

    // Clean up
    delete[] h_partial_sums;
    cudaFree(d_partial_sums);
  }

  __global__ void gpu_max_kernel(const float *in, float *partial_maxes, int n)
  {
    // Shared memory for partial max within a block
    extern __shared__ float shared_data[];

    int idx = global_index_1D();
    int tid = threadIdx.x;

    // Each thread loads its element
    float temp = -FLT_MAX;
    if (idx < n)
    {
      temp = in[idx];
    }
    shared_data[tid] = temp;
    __syncthreads();

    // Reduce within the block to find max
    for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
    {
      if (tid < stride)
      {
        shared_data[tid] = fmaxf(shared_data[tid], shared_data[tid + stride]);
      }
      __syncthreads();
    }

    // Write the block's partial max to global memory
    if (tid == 0)
    {
      partial_maxes[blockIdx.x] = shared_data[0];
    }
  }

  void gpu_max(const float *in, float *result, int n, int threads_per_block)
  {
    // Define block and grid sizes
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Allocate memory for partial maxes
    float *d_partial_maxes;
    int num_blocks = config.grid_dim.x;
    cudaMalloc(&d_partial_maxes, num_blocks * sizeof(float));

    // Launch the kernel
    gpu_max_kernel<<<config.grid_dim, config.block_dim, config.block_dim.x * sizeof(float)>>>(in, d_partial_maxes, n);

    // Copy partial maxes back to host
    float *h_partial_maxes = new float[num_blocks];
    cudaMemcpy(h_partial_maxes, d_partial_maxes, num_blocks * sizeof(float), cudaMemcpyDeviceToHost);

    // Final reduction on host
    float max_val = -FLT_MAX;
    for (int i = 0; i < num_blocks; ++i)
    {
      if (h_partial_maxes[i] > max_val)
      {
        max_val = h_partial_maxes[i];
      }
    }
    *result = max_val;

    // Clean up
    delete[] h_partial_maxes;
    cudaFree(d_partial_maxes);
  }

  __global__ void gpu_min_kernel(const float *in, float *partial_mins, int n)
  {
    // Shared memory for partial min within a block
    extern __shared__ float shared_data[];

    int idx = global_index_1D();
    int tid = threadIdx.x;

    // Each thread loads its element
    float temp = FLT_MAX;
    if (idx < n)
    {
      temp = in[idx];
    }
    shared_data[tid] = temp;
    __syncthreads();

    // Reduce within the block to find min
    for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
    {
      if (tid < stride)
      {
        shared_data[tid] = fminf(shared_data[tid], shared_data[tid + stride]);
      }
      __syncthreads();
    }

    // Write the block's partial min to global memory
    if (tid == 0)
    {
      partial_mins[blockIdx.x] = shared_data[0];
    }
  }

  void gpu_min(const float *in, float *result, int n, int threads_per_block)
  {
    // Define block and grid sizes
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Allocate memory for partial mins
    float *d_partial_mins;
    int num_blocks = config.grid_dim.x;
    cudaMalloc(&d_partial_mins, num_blocks * sizeof(float));

    // Launch the kernel
    gpu_min_kernel<<<config.grid_dim, config.block_dim, config.block_dim.x * sizeof(float)>>>(in, d_partial_mins, n);

    // Copy partial mins back to host
    float *h_partial_mins = new float[num_blocks];
    cudaMemcpy(h_partial_mins, d_partial_mins, num_blocks * sizeof(float), cudaMemcpyDeviceToHost);

    // Final reduction on host
    float min_val = FLT_MAX;
    for (int i = 0; i < num_blocks; ++i)
    {
      if (h_partial_mins[i] < min_val)
      {
        min_val = h_partial_mins[i];
      }
    }
    *result = min_val;

    // Clean up
    delete[] h_partial_mins;
    cudaFree(d_partial_mins);
  }

  __global__ void gpu_sum_kernel(const float *in, float *partial_sums, int n)
  {
    // Shared memory for partial sums within a block
    extern __shared__ float shared_data[];

    int idx = global_index_1D();
    int tid = threadIdx.x;

    // Each thread computes its element
    float temp = 0.0f;
    if (idx < n)
    {
      temp = in[idx];
    }
    shared_data[tid] = temp;
    __syncthreads();

    // Reduce within the block
    for (int stride = blockDim.x / 2; stride > 0; stride /= 2)
    {
      if (tid < stride)
      {
        shared_data[tid] += shared_data[tid + stride];
      }
      __syncthreads();
    }

    // Write the block's partial sum to global memory
    if (tid == 0)
    {
      partial_sums[blockIdx.x] = shared_data[0];
    }
  }

  void gpu_sum(const float *in, float *result, int n, int threads_per_block)
  {
    // Define block and grid sizes
    config::LaunchConfig config = config::get_1D_launch_config(n, threads_per_block);

    // Allocate memory for partial sums
    float *d_partial_sums;
    int num_blocks = config.grid_dim.x;
    cudaMalloc(&d_partial_sums, num_blocks * sizeof(float));

    // Launch the kernel
    gpu_sum_kernel<<<config.grid_dim, config.block_dim, config.block_dim.x * sizeof(float)>>>(in, d_partial_sums, n);

    // Copy partial sums back to host
    float *h_partial_sums = new float[num_blocks];
    cudaMemcpy(h_partial_sums, d_partial_sums, num_blocks * sizeof(float), cudaMemcpyDeviceToHost);

    // Final reduction on host
    float total = 0.0f;
    for (int i = 0; i < num_blocks; ++i)
    {
      total += h_partial_sums[i];
    }
    *result = total;

    // Clean up
    delete[] h_partial_sums;
    cudaFree(d_partial_sums);
  }
}

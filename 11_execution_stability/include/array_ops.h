/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Array operations header file.
 * @copyright MIT License
 */

#ifndef ARRAY_OPS_H
#define ARRAY_OPS_H

#include <config.h>

namespace array_ops
{

  // CPU implementations - cpu_array_ops.cpp
  void cpu_add(float *out, const float *a, const float *b, int n);
  void cpu_scale(float *out, const float *in, float scale, int n);
  void cpu_saxpy(float *out, const float *x, const float *y, float a, int n);
  void cpu_dot(float *out, const float *a, const float *b, int n);
  float cpu_max(const float *in, int n);
  float cpu_min(const float *in, int n);
  float cpu_sum(const float *in, int n);

  // GPU implementations - gpu_array_ops.cu
  void gpu_add(float *out, const float *a, const float *b, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  void gpu_scale(float *out, const float *in, float scale, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  void gpu_saxpy(float *out, const float *x, const float *y, float a, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  void gpu_dot(float *out, const float *a, const float *b, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  float gpu_max(const float *in, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  float gpu_min(const float *in, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
  float gpu_sum(const float *in, int n, int threads_per_block  = GPULABS_THREADS_PER_BLOCK);
}

#endif // ARRAY_OPS_H
/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief CPU implementations of array operations.
 * @copyright MIT License
 */

 #include "array_ops.h"

 namespace array_ops
 {
   void cpu_add(float *out, const float *a, const float *b, int n)
   {
     for (int i = 0; i < n; ++i)
     {
       out[i] = a[i] + b[i];
     }
   }

    void cpu_scale(float *out, const float *in, float scale, int n)
    {
      for (int i = 0; i < n; ++i)
      {
        out[i] = in[i] * scale;
      }
    }

    void cpu_saxpy(float *out, const float *x, const float *y, float a, int n)
    {
      for (int i = 0; i < n; ++i)
      {
        out[i] = a * x[i] + y[i];
      }
    }

    void cpu_dot(float *out, const float *a, const float *b, int n)
    {
      float sum = 0.0f;
      for (int i = 0; i < n; ++i)
      {
        sum += a[i] * b[i];
      }
      *out = sum;
    }

    float cpu_max(const float *in, int n)
    {
      // TODO validate n > 0
      float max_val = in[0];
      for (int i = 1; i < n; ++i)
      {
        if (in[i] > max_val)
        {
          max_val = in[i];
        }
      }
      return max_val;
    }

    float cpu_min(const float *in, int n)
    {
      // TODO validate n > 0
      float min_val = in[0];
      for (int i = 1; i < n; ++i)
      {
        if (in[i] < min_val)
        {
          min_val = in[i];
        }
      }
      return min_val;
    }

    float cpu_sum(const float *in, int n)
    {
      float total = 0.0f;
      for (int i = 0; i < n; ++i)
      {
        total += in[i];
      }
      return total;
    }
}

/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief  Data generation utilities implementation.
 * @copyright MIT License
 */

#include <random>

namespace data_gen
{
  void zero_floats(float *out, int n)
  {
    for (int i = 0; i < n; ++i)
    {
      out[i] = 0.0f;
    }
  }

  void random_floats(float *out, int n)
  {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_real_distribution<float> dis(0.0f, 1.0f);
    for (int i = 0; i < n; ++i)
    {
      out[i] = dis(gen);
    }
  }

  void normal_floats(float *out, int n, float mean, float stddev)
  {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::normal_distribution<float> dis(mean, stddev);
    for (int i = 0; i < n; ++i)
    {
      out[i] = dis(gen);
    }
  }

  void sequential_floats(float *out, int n, float start, float step)
  {
    for (int i = 0; i < n; ++i)
    {
      out[i] = start + i * step;
    }
  }

  void constant_floats(float *out, int n, float value)
  {
    for (int i = 0; i < n; ++i)
    {
      out[i] = value;
    }
  }

  void poisson_floats(float *out, int n, float lambda)
  {
    std::random_device rd;
    std::mt19937 gen(rd());
    std::poisson_distribution<int> dis(lambda);
    for (int i = 0; i < n; ++i)
    {
      out[i] = static_cast<float>(dis(gen));
    }
  }
}
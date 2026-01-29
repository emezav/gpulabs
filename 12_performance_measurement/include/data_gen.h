/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Data generation utilities.
 * @copyright MIT License
 */

namespace data_gen
{

  /** @brief Generate an array of zeros
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   */
  void zero_floats(float *out, int n);

  /** @brief Generate an array of random floats
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   */
  void random_floats(float *out, int n);

  /** @brief Generate an array of normally distributed floats
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   * @param mean Mean of the normal distribution
   * @param stddev Standard deviation of the normal distribution
   */
  void normal_floats(float *out, int n, float mean, float stddev);

  /** @brief Generate an array of sequential floats
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   * @param start Starting value
   * @param step Step size between consecutive values
   */
  void sequential_floats(float *out, int n, float start, float step);

  /** @brief Generate an array filled with a constant float value
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   * @param value Constant value to fill
   */
  void constant_floats(float *out, int n, float value);

  /** @brief Generate an array of Poisson-distributed floats
   * @param out Pointer to the output array
   * @param n Number of elements to generate
   * @param lambda Lambda parameter of the Poisson distribution
   */
  void poisson_floats(float *out, int n, float lambda);
}
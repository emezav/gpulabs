/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Validation utilities for GPU computing using CUDA
 * @copyright MIT License
 */

 #ifndef VALIDATE_H
 #define VALIDATE_H

 #include <vector>

 namespace validate {
  /**
   * @brief Checks if two integer arrays are equal.
   * @param expected Pointer to the expected integer array.
   * @param actual Pointer to the actual integer array.
   * @param size Number of elements in the arrays.
   * @return true if arrays up to size are equal, false otherwise.
   */
    bool equal(const int* expected, const int* actual, size_t size);

    /**
     * @brief Checks if two float arrays are approximately equal within a given epsilon.
     * @param expected Pointer to the expected float array.
     * @param actual Pointer to the actual float array.
     * @param size Number of elements in the arrays.
     * @param epsilon Maximum allowed difference between elements.
     * @return true if arrays up to size are approximately equal within epsilon, false otherwise.
     */
    bool equal(const float* expected, const float* actual, size_t size, float epsilon);
    /**
     * @brief Checks if two double arrays are approximately equal within a given relative percent error.
     * @param expected Pointer to the expected double array.
     * @param actual Pointer to the actual double array.
     * @param size Number of elements in the arrays.
     * @param rpce Maximum allowed relative percent error between elements.
     * @return true if arrays up to size are approximately equal within rpce, false otherwise.
     */
    bool relative_equal(const float* expected, const float* actual, size_t size, float rpce);
    // bool equal(const double* expected, const double* actual, size_t size, double epsilon);
    // bool equal(const std::vector<int>& expected, const std::vector<int>& actual);
    // bool equal(const std::vector<float>& expected, const std::vector<float>& actual, float epsilon);
    // bool equal(const std::vector<double>& expected, const std::vector<double>& actual, double epsilon);
 }

#endif // VALIDATE_H
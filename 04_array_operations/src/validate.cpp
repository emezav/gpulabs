/**
 * @file
 * @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
 * @brief Validation utilities for GPU computing using CUDA
 * @copyright MIT License
 */
#include "config.h"
#include "validate.h"
#include <cmath>

 namespace validate {
    bool equal(const int* expected, const int* actual, size_t size) {
        for (size_t i = 0; i < size; ++i) {
            if (expected[i] != actual[i]) {
                printf("Validation failed at index %zu (expected: %d, actual: %d)\n", i, expected[i], actual[i]);
                return false;
            }
        }
        return true;
    }

    bool equal(const float* expected, const float* actual, size_t size, float epsilon) {
        for (size_t i = 0; i < size; ++i) {
            if (fabs(expected[i] - actual[i]) > epsilon) {
                printf("Validation failed at index %zu (expected: %f, actual: %f)\n", i, expected[i], actual[i]);
                return false;
            }
        }
        return true;
    }

    bool relative_equal(const float* expected, const float* actual, size_t size, float rpce) {
        for (size_t i = 0; i < size; ++i) {
            float abs_expected = fabs(expected[i]);
            float abs_actual = fabs(actual[i]);

            float diff = fabs(expected[i] - actual[i]);

            // Check for different signs and sign change near zero
            if ((expected[i] < 0) != (actual[i] < 0) && diff > 1e-10) {
                printf("Validation failed at index %zu (expected: %f, actual: %f, sign mismatch)\n", i, expected[i], actual[i]);
                return false;
            }

            float relative_error = (abs_expected > 1e-10) ? (diff / abs_expected) * 100.0f : diff;

            if (relative_error > rpce) {
              printf("Validation failed at index %zu (expected: %f, actual: %f, relative error: %f%%)\n", i, expected[i], actual[i], relative_error);
                return false;
            }
        }
        return true;
    }
 }
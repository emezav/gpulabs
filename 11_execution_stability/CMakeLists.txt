# @file
# @author Erwin Meza Vega <emezav@unicauca.edu.co>, <emezav@gmail.com>
# @copyright 2025 Onwards MIT License
# Configuration file for CMake.

# ============================================================================
# GPULabs - Standard CMake configuration (CUDA + C++)
# This file is designed to be reused across projects with minimal/no edits.
# ============================================================================

# Minimum required version: 3.24 which improves support for CUDA configuration.
cmake_minimum_required(VERSION 3.24)

# Get current directory name and replace spaces with underscores.
cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME ProjectName)
string(REPLACE " " "_" ProjectName ${ProjectName})

# Use current directory as project name (Visual Studio solution name)
project(${ProjectName} VERSION 1.0 LANGUAGES CXX CUDA)

# To use a custom project name:
# comment the project(...) line before this comment,
# replace MYPROJECT with the desired project name and uncomment the following line:
#project("MYPROJECT" VERSION 1.0 LANGUAGES CXX CUDA)

# Enable CUDA language is deprecated on CMake 3.8 onwards - use LANGUAGES on project(...)
# See https://developer.nvidia.com/blog/building-cuda-applications-cmake/
# enable_language(CUDA)

# ---- Global language standards ----
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# Set position independent code to ON, required for some CUDA libraries
# Please check carefully for each library required on the project
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Create compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Use folders to group CMake targets
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# ---- Options (enable only when needed, depending on the project) ----
option(GPULABS_CUDA_STATIC_RUNTIME "Use static CUDA runtime and libraries" ON)
option(GPULABS_USE_CUBLAS "Link cuBLAS" OFF)
option(GPULABS_USE_CUFFT "Link cuFFT" OFF)

# Find CUDA Toolkit
find_package(CUDAToolkit REQUIRED)

# Add c/c++ headers and sources (recursively)
file(GLOB_RECURSE cpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cpp" "${CMAKE_SOURCE_DIR}/include/*.h")

# Add CUDA headers and sources (recursively)
file(GLOB_RECURSE gpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cu" "${CMAKE_SOURCE_DIR}/include/*.cuh")

# Add include directory "./include"
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add include directory for the CUDA include directories
include_directories(${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})

# Add project executable
add_executable(${PROJECT_NAME} ${cpu_source_files} ${gpu_source_files})

# Set default start project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

# Set link flags to mirror project link flags
set_property(TARGET ${PROJECT_NAME} PROPERTY LINK_FLAGS ${PROJ_LINK_FLAGS})

# ---- CUDA settings ----

# Enable separable compilation for CUDA files
set_property(TARGET ${PROJECT_NAME} PROPERTY CUDA_SEPARABLE_COMPILATION ON)

# Add CUDA::* (depending on project requirements) to link libraries
# target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cudart <..other cuda libraries..>)

if(GPULABS_CUDA_STATIC_RUNTIME)

  # Link static CUDA runtime
  target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cudart_static)

  # Link cuBLAS_static if enabled
  if(GPULABS_USE_CUBLAS)
    # Link static cuBLAS
    target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cublas_static)
    # Add compile definition for cuBLAS
    target_compile_definitions(${PROJECT_NAME} PRIVATE GPULABS_USE_CUBLAS=1)
  endif()

  # Link cuFFT_static if enabled
  if(GPULABS_USE_CUFFT)
    # Link static cuFFT
    target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cufft_static)
    # Add compile definition for cuFFT
    target_compile_definitions(${PROJECT_NAME} PRIVATE GPULABS_USE_CUFFT=1)
  endif()
else()

  # Link dynamic CUDA runtime
  target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cudart)

  # Link cuBLAS if enabled
  if(GPULABS_USE_CUBLAS)
    # Link dynamic cuBLAS
    target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cublas)
    # Add compile definition for cuBLAS
    target_compile_definitions(${PROJECT_NAME} PRIVATE GPULABS_USE_CUBLAS=1)
  endif()
  # Link cuFFT if enabled
  if(GPULABS_USE_CUFFT)
    # Link dynamic cuFFT
    target_link_libraries(${PROJECT_NAME} PRIVATE CUDA::cufft)
    # Add compile definition for cuFFT
    target_compile_definitions(${PROJECT_NAME} PRIVATE GPULABS_USE_CUFFT=1)
  endif()
endif()

# Default to native-ish arch when supported by your toolchain. In lab machines,
# you can also set CMAKE_CUDA_ARCHITECTURES explicitly (e.g., 75;86;89).
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  # Set CUDA architecture to native (use host architecture)
  set(CMAKE_CUDA_ARCHITECTURES native CACHE STRING "CUDA arch list" FORCE)
endif()

# Set CUDA architecture to native (use host architecture) on current project
set_property(TARGET ${PROJECT_NAME} PROPERTY CUDA_ARCHITECTURES ${CMAKE_CUDA_ARCHITECTURES})

# ---- Output ----
set_target_properties(${PROJECT_NAME} PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}"
)

# Print configuration summary
message(STATUS "Project: ${PROJECT_NAME}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ standard: C++${CMAKE_CXX_STANDARD}")
message(STATUS "CUDA standard: CUDA ${CMAKE_CUDA_STANDARD}")
message(STATUS "Use static runtime: ${GPULABS_CUDA_STATIC_RUNTIME}")
message(STATUS "CUDA architectures: ${CMAKE_CUDA_ARCHITECTURES}")
message(STATUS "GPULABS_USE_CUBLAS: ${GPULABS_USE_CUBLAS}")
message(STATUS "GPULABS_USE_CUFFT:  ${GPULABS_USE_CUFFT}")

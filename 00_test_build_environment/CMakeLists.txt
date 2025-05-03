# @file
# @author Erwin Meza Vega <emezav@unicauca.edu.co>
# @copyright 2020 Onwards MIT License
# Configuration file for CMake.

# Minimum required version: 3.24 which improves support for CUDA configuration.
cmake_minimum_required (VERSION 3.18)

# Project name - Change to the desired executable name.

cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME ProjectName)
string(REPLACE " " "_" ProjectId ${ProjectName})

# Use current directory as project name
project(${ProjectName})

# To use a custom project name:
# comment the project(...) line before this comment,
# replace MYPROJECT with the desired project name and uncomment the following line:
#project("MYPROJECT")

# Enable CUDA
enable_language(CUDA)

# Find CUDA Toolkit
find_package(CUDAToolkit REQUIRED)

# Use folders to group CMake targets
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# Add c/c++ headers and sources
file(GLOB cpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cpp" "${CMAKE_SOURCE_DIR}/include/*.h")

# Add CUDA headers and sources
file(GLOB gpu_source_files "${CMAKE_SOURCE_DIR}/src/*.cu" "${CMAKE_SOURCE_DIR}/include/*.cuh")

# Add include directory "./include"
include_directories(${CMAKE_SOURCE_DIR}/include)

# Add include directory for the CUDA include directories
include_directories(${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})

add_executable (${PROJECT_NAME} ${cpu_source_files} ${gpu_source_files})

# Set default start project
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})

# Set link flags to mirror project link flags
set_property(TARGET ${PROJECT_NAME} PROPERTY LINK_FLAGS ${PROJ_LINK_FLAGS})

# Set CUDA architecture to native (use host architecture) on current project
set_property(TARGET ${PROJECT_NAME} PROPERTY CUDA_ARCHITECTURES native)


# ============================================================================
# GPULabs - Standard Makefile wrapper for CMake
# ============================================================================

# Variable declaration
SHELL := /bin/bash
BUILD_DIR := build
CONFIG ?= Release
detected_OS := $(shell uname -s)
RUNTIME_CONFIG :=

# Detect Windows OS for executable extension and runtime config path
FILE_EXT :=
ifeq ($(detected_OS),Windows_NT)
		FILE_EXT := .exe
		RUNTIME_CONFIG := $(CONFIG)/
endif

# Get project name from current directory
PROJECT_NAME := $(shell basename $(CURDIR))

# Target definitions
.PHONY: all configure build run clean rebuild profile help

# Default target
all: build

# CMake configuration
configure:
	cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=$(CONFIG)

# Build target
build: configure
	cmake --build $(BUILD_DIR) --config $(CONFIG) -j

# Run target
run: build
	@echo "Running: $(BUILD_DIR)/$(RUNTIME_CONFIG)$(PROJECT_NAME)$(FILE_EXT)"
	@./$(BUILD_DIR)/$(RUNTIME_CONFIG)$(PROJECT_NAME)$(FILE_EXT)

# Rebuild target
rebuild: clean build

# Clean target
clean:
	cmake --build $(BUILD_DIR) --target clean

# Dist clean target
dist-clean:
	@rm -rf $(BUILD_DIR)
	@rm -rf *.nsys-rep

# Profiling target (example using NVIDIA Nsight Systems)
profile: build
	nsys profile ./$(BUILD_DIR)/$(RUNTIME_CONFIG)$(PROJECT_NAME)$(FILE_EXT)

# Help target
help:
	@echo "Targets:"
	@echo "  make configure  - Generate build system (CMake)"
	@echo "  make build      - Build project"
	@echo "  make run        - Build and run"
	@echo "  make clean      - Remove build directory"
	@echo "  make profile    - Profile the application using NVIDIA Nsight Systems"
	@echo "  make dist-clean - Remove build artifacts and profiling reports"
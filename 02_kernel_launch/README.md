# Lanzamiento de módulos de GPU (kernels)

**Important note: this will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

Este proyecto permite explorar el mecanismo básico para ejecutar un módulo de GPU (en adelante kernel) desde código CPU, para comprender de forma práctica:

- La sintaxis y semántica de un kernel CUDA (__global__).
- El modelo de lanzamiento: <<<grid, block>>>.
- Índices básicos: threadIdx, blockIdx, blockDim, gridDim.
- Sincronización mínima para validez funcional (cudaDeviceSynchronize).
- Detección de errores de lanzamiento y ejecución.
- Ejecución repetida y medición básica del tiempo de ejecución.

## Tareas a realizar

Este proyecto incluye una cantidad mayor de archivos de cabecera (directorio include) y de código fuente (directorio src). Se deberá buscar los comentarios TODO para implementar la funcionalidad requerida y generar una evidencia de ejecución en un documento o archivo REPORT.md.

## Tareas

1. Implementar una versión CPU funcional para línea base
2. Completar el cálculo del índice global 1D
3. Revisar y completar los parámetros para el lanzamiento del kernel
4. Detectar fallos en el lanzamiento del kernel y reportar al usuario
5. Completar la implementación del experimento y el cálculo de resultados de validación

## Material adicional

1. Documentación de los componentes del entorno de desarrollo
2. Documentación del [Runtime de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api)
3. [Introducción a CUDA C++](https://docs.nvidia.com/cuda/cuda-programming-guide/02-basics/intro-to-cuda-cpp.html)
4. [Cuda compute capability list](https://developer.nvidia.com/cuda/gpus)
5. [API de eventos de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api/group__CUDART__EVENT.html)
6. [Medición de tiempo de ejecución en C++](https://en.cppreference.com/w/cpp/chrono/c/clock.html).

## Requisitos del sistema

Para compilar y ejecutar, se requiere un sistema con GPU NVIDIA, con drivers actualizados, y el siguiente software:

- Visual Studio Community (2022, soporte de NVIDIA pendiente para 2026)
- Visual Studio Code
- CMake 3.24 o superior
- Sistemas Windows: w64devkit para utilidades básicas presentes en GNU/Linux (shell, make, cp, rm, etc.)

Opcional:

- Git

## Compilar y ejecutar

Para compilar este proyecto, abrir en Visual Studio Code y usar el botón con el ícono "Play" que se encuentra en la barra de acciones en el borde inferior del entorno.

También se proporciona un Makefile, que permite realizar las tareas básicas de compilación.

Desde la raíz del proyecto:

```bash
make clean
make
make run
```

## Compilar manualmente (Debug)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cmake --build build --config Debug
```

## Compilar manualmente (Release)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cmake --build build --config Release
```

## Limpiar la compilación

Para eliminar archivos ejecutables y de depuración, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cmake --build build --target clean
```

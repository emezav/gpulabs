# Operaciones sobre arreglos

**Important note: This will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

Este proyecto explora la implementación de algunas operaciones básicas sobre arreglos 1D con un mapeo hilo-dato adecuado de acuerdo con la naturaleza del problema.

## Tareas a realizar

Se deberá buscar los comentarios TODO para implementar la funcionalidad requerida y generar una evidencia de ejecución en un documento o archivo REPORT.md.

## Funcionalidad requerida

1. Implementar del kernel map:scale 1D
2. Implementar el kernel zip: saxpy
3. Completar el código host que configura y lanza los kernel
4. Implementar la validación de los resultados.

## Material adicional

1. Documentación de los componentes del entorno de desarrollo
2. [Runtime de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api)
3. [Introducción a CUDA C++](https://docs.nvidia.com/cuda/cuda-programming-guide/02-basics/intro-to-cuda-cpp.html)
4. [Cuda compute capability list](https://developer.nvidia.com/cuda/gpus)
5. [API de eventos de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api/group__CUDART__EVENT.html)
6. [Medición de tiempo de ejecución en C++](https://en.cppreference.com/w/cpp/chrono/c/clock.html).
7. [CUDA Programming Guide - Programming model](https://docs.nvidia.com/cuda/cuda-programming-guide/01-introduction/programming-model.html)
8. [CUDA Toolkit Documentation - Programming model](https://docs.nvidia.com/cuda/archive/11.8.0/cuda-c-programming-guide/index.html)

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

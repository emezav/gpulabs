# Bloques e hilos

**Important note: This will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

Este proyecto explora el mapeo hilo-dato en 1D y 2D, fundamental para que los módulos de GPU (kernels) tengan una cobertura total del dominio de los datos.

## Tareas a realizar

Se deberá buscar los comentarios TODO para implementar la funcionalidad requerida y generar una evidencia de ejecución en un documento o archivo REPORT.md.

## Funcionalidad requerida

En cada uno de los cuatro casos siguientes, implementar un módulo de GPU que:

- Calcula correctamente el índice (i en 1D, i,j en 2D) para una posición única en el dominio de los datos.
- No realiza ninguna acción si el índice está por fuera del dominio de los datos.
- Procesa los datos de forma adecuada (por ejemplo, sin superposiciones).

Se deben implementar cuatro experimentos:

1. Experimento en 1D (write_index_1D o add_constant_1D) sobre un arreglo de n datos, con dos escenarios:
   a. n múltiplo de block_size (dos block_size diferentes)
   b. n no múltiplo de block_size (dos valores diferentes)
2. Experimento en 2D (write_sequential_2D o add_constant_2D) con n, m:
   a. n, m múltiplos de block.x/block.y (ejemplo 1024x1024, bloques de 16x16 hilos)
   b. n, m, no múltiplos de block.x/block.y (ejemplo 1000x700, bloque de 16x16 hilos)

Para cada experimento, imprimir FAILED/PASSED si los datos procesados en CPU son "iguales" a los procesados en GPU (igual ~ función de validación en validate.h/validate.cpp)

Se deben usar tamaños de arreglo que sean soportados por la GPU, pero lo suficientemente grandes para observar los efectos de diferentes configuraciones de bloques.

Los datos de validación se deben generar en CPU, aplicando la misma transformación
del dato de entrada. En todos los casos se usarán números reales de precisión simple (float).
Tenga en cuenta que los kernels se encuentran definidos para números enteros, se debe realizar el cambio correspondiente.

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

Para compilar este proyecto, abrir en Visual Studio Code y usar el botón con el ícono "Play"
que se encuentra en la barra de acciones en el borde inferior del entorno.

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

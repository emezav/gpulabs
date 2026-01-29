# Análisis del rendimiento de la aplicación

**This will be the only text in Spanish, the documentation/comment notes inside other files must be in English.**

El propósito de este proyecto consiste en implementar un método para facilicar el análisis del rendimiento de la aplicación: El **protocolo**, las repeticiones, la separación entre etapas y la generación de reportes. La implementación de este método, junto con las herramientas de perfilado, permitirá identificar puntos críticos de la aplicación, susceptibles a ser optimizados.

## Tareas a realizar

Se deberá implementar un análisis del rendimiento que sea cuantificable y reproducible, especificado en un archivo PERFORMANCE.md o en un documento de texto, incluyendo:

1. Medición de tiempos de CPU y GPU.
2. Separación de etapas:
   a. Transferencias H2D (Host to Device).
   b. Ejecución kernels.
   c. Transferencias D2H (Device to Host).
   d. Medición global.
3. Uso de un protocolo, que defina:
   a. Warmup de GPU.
   b. Repeticiones.
   c. Medidas estadísticas.
   d. Control de sincronización.
4. Generación de reportes:
   a. Información general de la configuración.
   b. Tiempos en cada etapa.
   c. Speedup.

En este proyecto no se realiza ninguna optimización del código.

## Funcionalidad requerida

1. Implementar el protocolo de medición, definiendo como mínimo:
   a. Parámetros de warmup
   b. Cantidad de repeticiones.
   c. Medidas estadísticas a usar.
   d. Posibilidad de habilitar / deshabilitar la sincronozación explícita.
2. Implementar la medición en cada una de las etapas que se desea medir.
3. Cálculo del speedup usando el promedio del tiempo de ejecuciones en CPU y en GPU.

Además, se deberá incluir una sección en el archivo del reporte de rendimiento (PERFORMANCE.md) en la cual se realice un análisis que responda las siguientes preguntas:

- ¿Qué etapas dominan el tiempo total de ejecución?
- ¿Se presenta speedup global o en alguna etapa? ¿Por qué?
- ¿Existe alguna oportunidad de optimización?

## Medición de tiempos

Todas las mediciones se deben llevar a cabo con el código base proporcionado (`include/cpu_timer.h`, `include/gpu_timer.h`).

Es importante diferenciar tiempo total de ejecución del programa de tiempo efectivo de procesamiento. Para el tiempo de procesamiento, se debe establecer un punto temporizador (de GPU o CPU) justo antes de invocar la subrutina (o el kernel) que procesa los datos, y detener el temporizador justo después que la subrutina o el kernel hayan terminado. Algunas etapas críticas a medir son:

- Asignación de memoria.
- Inicialización de los datos.
- Transferencias H2D y D2H.

Dependiendo del problema seleccionado, puede incorporar y reportar medición en otras etapas.

## Material adicional

1. Documentación de los componentes del entorno de desarrollo
2. [Runtime de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api)
3. [Introducción a CUDA C++](https://docs.nvidia.com/cuda/cuda-programming-guide/02-basics/intro-to-cuda-cpp.html)
4. [Cuda compute capability list](https://developer.nvidia.com/cuda/gpus)
5. [API de eventos de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api/group__CUDART__EVENT.html)
6. [Medición de tiempo de ejecución en C++](https://en.cppreference.com/w/cpp/chrono/c/clock.html).
7. [CUDA Programming Guide - Programming model](https://docs.nvidia.com/cuda/cuda-programming-guide/01-introduction/programming-model.html)
8. [CUDA Toolkit Documentation - Programming model](https://docs.nvidia.com/cuda/archive/11.8.0/cuda-c-programming-guide/index.html)
9. [Back to Basics: RAII in C++ - Andre Kostur - CppCon 2022](https://www.youtube.com/watch?v=Rfu06XAhx90)

## Requisitos del sistema

Para compilar y ejecutar, se requiere un sistema con GPU NVIDIA, con drivers actualizados, y el siguiente software:

- Visual Studio Community (2022, soporte de NVIDIA pendiente para 2026).
- Visual Studio Code.
- CMake 3.24 o superior.
- Sistemas Windows: w64devkit para utilidades básicas presentes en GNU/Linux (shell, make, cp, rm, etc.).

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

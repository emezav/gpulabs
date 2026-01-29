# Estabilidad y manejo de errores

**Important note: This will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

En este proyecto se valida la estabilidad dee código bajo:

- Ejecuciones repetidas.
- Variación de tamaños de entrada.
- Variación de configuración de lanzamiento (block size) dentro de límites válidos.

## Definición de estabilidad

En el contexto de este proyecto, se van a considerar los siguientes criterios para determinar la estabilidad:

- Validez funcional repetida: la verificación CPU vs GPU pasa en todas las ejecuciones.
- Determinismo: resultados idénticos (o dentro de tolerancia) para la misma entrada.
- Robustez a tamaños: funciona para múltiples tamaños de entrada.
- Ausencia de fallos intermitentes: no hay fallos intermitentes ni errores esporádicos.

## Tareas a realizar

1. Diseñar un caso de experimento (caso de prueba) parametrizado, con las siguientes etapas:
   a. Generar datos de prueba a partir de los parámetros configurados.
   b. Ejecutar versión CPU.
   c. Ejecutar versión GPU.
   d. Comparar resultados con tolerancia parametrizable.
2. Repetir el experimento un número de veces:
   a. Verificar si se obtienen resultados funcionalmente válidos.
   b. Reportar resumen por caso de prueba y total.

## Funcionalidad requerida

Como mínimo, se deberán considerar:

- Dos (2) tamaños de bloque:
  - 128 y 256 (o 64/256)
- Tres (3) tamaños de datos:
  - uno múltiplo del tamaño del bloque (1024).
  - uno no múltiplo (1000).
  - uno pequeño (17).
- Dos (2) repeticiones: 20 o 50
- Definición del patrón de datos, por ejemplo:
  - valores constantes.
  - valores aleatorios con semilla fija.
  - valores con gradiente (i, i*i, etc.).
  - casos de borde (ceros, máximos, mínimos razonables).

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

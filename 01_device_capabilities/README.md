# Caracterización de los dispositivos CUDA disponibles en el sistema

**Important note: this will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

El propósito de este proyecto consiste en verificar y caracterizar los dispositivos disponibles, incluyendo:

- Enumeración de GPU presentes en el sistema.
- Propiedades críticas para el diseño de las soluciones paralelas.
- Límites de ejecución (threads per block, dimensiones de mallas, memoria compartida)
- Características que dependen de la arquitectura de GPU disponible

En este proyecto no se ejecuta ningún kernel, sólo se consulta e imprime la información relevante de los dispositivos detectados y verifica si tienen una versión mínima aceptable (definida en include/config.h)

Por ejemplo, la [Tabla de compatibilidad para cuDNN](https://docs.nvidia.com/deeplearning/cudnn/backend/latest/reference/support-matrix.html) define las arquitecturas que soportan esta biblioteca avanzada.

## Tareas a realizar

### Tarea 1. Imprimir información de las GPU detectadas en el sistema que afectan el diseño. El programa deberá

- Detectar e imprimir la cantidad de GPU disponibles en el sistema.
- Presentar una tabla para cada GPU detectada, con la siguiente información como mínimo:
  a. maxThreadsPerBlock (tamaño de bloques )
  b. warpSize (alineación, divergencia)
  c. sharedMemPerBlock (memoria compartida entre hilos)
  d. maxGridSize (tamaño del dominio de datos)
  e. major/minor (características específicas a la versión de la arquitectura de GPU)
  El formato debe ser el suiguiente:

```txt
Number of GPU Devices: #
Device Number: ..
  Device name: ........
  Device Compute Major: . Minor: .
  Max Thread Dimensions: [....][...][...]
  Max Threads Per Block: ...
  Number of Multiprocessors: ...
  Device Clock Rate (KHz): ...
  Memory Bus Width (bits): ...
  Registers Per Block: ...
  Registers Per Multiprocessor: ...
  Shared Memory Per Block: ...
  Shared Memory Per Multiprocessor: ...
  Total Constant Memory (bytes): ...
  Total Global Memory (bytes): ...
  Warp Size: ...
  Peak Memory Bandwidth (GB/s): ...
```

### Tarea 2. Verificación de compatibilidad

Completar el código para verificar si el (los) dispositivo(s) tiene(n) un umbral de compute capability  definido en config.h (por ejemplo, 6.0 o major, 7.0 o major, etc.) Los valores de major/minor deben ser ajustados en el código, incluyendo la  documentación relevante (características o cambios  más importantes del major/minor definido)

## Material adicional

1. Documentación de los componentes del entorno de desarrollo
2. Documentación del [Runtime de CUDA](https://docs.nvidia.com/cuda/cuda-runtime-api)
3. Documentación de [Cuda compute capability list](https://developer.nvidia.com/cuda/gpus)

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

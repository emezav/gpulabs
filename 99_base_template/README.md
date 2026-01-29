# Entorno de programación básico para computación paralela con GPU

Este proyecto establece la estructura básica de un proyecto de desarrollo de computación paralaela en C/C++ - CUDA
para sistemas con GPU NVIDIA.

## Requisitos del sistema

Para compilar y ejecutar, se require un sistema con GPU NVIDIA, con drivers actualizados, y el siguiente software:

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

```sh
cmake --build build --config Debug
```

## Compilar manualmente (Release)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```sh
cmake --build build --config Release
```

## Limpiar la compilación

Para eliminar archivos ejecutables y de depuración, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```sh
cd build
cmake --build build --target clean
```

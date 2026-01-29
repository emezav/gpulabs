# Entorno de programación básico para computación paralela con GPU

Este proyecto establece la estructura básica que se usará para crear las aplicaciones de computación paralela en C/C++ - CUDA  para sistemas con GPU NVIDIA.

**This will be the only text in Spanish, the documentation/comment notes inside other files must be in English.**

## Tareas a realizar

Crear un documento (o un archivo REPORT.md) en el cual se muestre evidencia del  siguiente proceso:

1. Verificación del entorno de hardware
   a. Verificar que el sistema dispone al menos de una GPU compatible con CUDA.
   b. Confirmar que el driver de NVIDIA está correctamente instalado.
   c. Usar el Panel de Control NVIDIA (o el comando nvidia-smi) para verificar: modelo de GPU, versión del driver.
2. Verificación del entorno software
   a. CUDA Toolkit, especialmente el compilador nvcc.
   b. Compilador de C++ (g++, cl)
   c. CMake
   d. Make
   e. Entornos de desarrollo: Visual Studio Code (Windows/Linux), Visual Studio CE (Windows)
   f. Entorno GNU (w64devkit en Windows)
3. Verificación de entorno de desarrollo y ejecución
   a. Ejecutar el comando correspondiente (o usar la configuración automática de Visual Studio Code) para generar entorno de construcción (build)
   b. Verificar que la configuración se haya creado correctamente.
4. Compilación del código base
   a. Compilar el proyecto usando make, cmake e interfaz gráfica de VS Code.
   b. Verificar que el archivo ejecutable se ha creado exitosamente.
5. Ejecución del programa de prueba.
   a. Ejecutar el programa compilado.
   b. Verificar que el programa se ejecuta y produce una salida.
   c. Analizar la salida del programa.
6. Completar el código para que el funcionamiento del programa sea correcto
   a. Buscar comentarios TODO
   b. Implementar la lógica descrita en cada TODO
   c. Verificar que el programa funciona y produce resultados correctos.

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

También se proporciona un Makefile, que permite realizar las tareas básicas de  compilación.

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

# Manejo de recursos y errores

**Important note: This will be the only text file in Spanish, the documentation/comment notes inside other files must be in English.**

En este proyecto se incorporan prácticas para transformar un código funcional en código robusto, lo cual implica:

- Detectar y reportar errores que se pueden presentar al usar las funciones del API de programación de la GPU, el lanzamiento y la
  ejecución de los módulos de GPU.
- Gestionar de forma correcta el ciclo de vida de uso de los recursos (memoria del sistema, memoria de la GPU y otros recursos).
- Mecanismos para prevención y mitigación de errores silenciosos (debidos principalmente a la gestión incorrecta de recursos).
- Otras estrategias para mejorar la robustez de la aplicación.

Se deberá adoptar un estándar para la gestión de errores, considerando que:

- Se debe verificar el valor de retorno de cada llamada al API de programación de la GPU (CUDA), dado que la mayoría de ellas
  retorna un valor de tipo cudaError_t o similar, que permite verificar si la operación inmediatamente anterior se completó correctamente.
- Estructurar código siguiendo en lo posible el principio RAII (Resource Acquisition Is Initialization), para evitar fugas de recursos, principalmente memoria.
- Se debe documentar adecuadamente las fallas, sus causas y posibles estrategias para atenuarlas o resolverlas.

## Tareas a realizar

Copiar el código (completo) del proyecto anterior (05_matrix_operations), en el cual se han implementado los experimentos adicionales  especificados en el archivo README.md Si se usó la estrategia de modularización presentada hasta ahora, sólo se requiere copiar los archivos experiments.cu y experiments.cu.

1. Incluir validación en todas las llamadas al API de CUDA: Las funciones del API de CUDA retornan un valor de tipo **cudaError_t**, que debe ser capturado y evaluado para verificar si la llamada se ejecutó exitosamente. Se deberá validar todas las llamadas al API. Se puede implementar un macro que encapsule la validación.
2. Luego de invocar cada kernel, se deberá consultar el último error ocurrido mediante la llamada a **cudaGetLastError**. Si el kernel se ejecutó correctamente, el valor de retorno será **cudaSuccess**.
3. Incluir validaciones que permitan verificar si una llamada para adquirir un recurso (por ejemplo memoria de host o dispositivo) se ejecutó corrrectamente o no. Por ejemplo, al solicitar la asignación de memoria dinámica mediante **malloc**, se debe verificar el valor de retorno.
4. Cada llamada de solicitud de recursos debe tener una llamada correspondiente para liberar el recurso (malloc - free, cudaMalloc, cudaFree).
5. Si se usan clases para encapsular la gestión de recursos, tratar de usar el principio RAII (Resource Acquisition Is Initialization), en el cual
   el ciclo de vida de un recurso se encuentra asociado al ciclo de vida de un objeto. Se solicita el recurso en el constructor de la clase y se libera en el destructor. Dado que en C++ los objetos se destruyen automáticamente al salir de contexto, se garantiza que los recursos son liberados de forma adecuada. Ver material adicional 8 para una explicación detallada de RAII.
6. Se deberá sincronizar luego de la invocación de cada kernel sólo si se está en modo Debug (`#ifdef _DEBUG` en Visual Studio), combinando con una variable de tipo bool cuyo valor será verdadero si el modo Debug está activado.
7. Si ocurre una condición en la cual el programa no puede continuar, se deberá informar al usuario con un mensaje pertinente, liberar los recursos
   asignados y terminar la ejecución.
8. Si ocurre una condición en la cual se presenta un error pero el programa puede continuar, se deberá informar al usuario y retornar un valor que
   indique el estado de error, y continuar la lógica sin terminar el programa.

## Funcionalidad requerida

Este proyecto no agrega nueva funcionalidad al código completo del proyecto anterior. Su propósito consiste en perfeccionar las estrategias para
hacer más robusto el código construido.

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

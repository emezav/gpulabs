# Learning Parallel Programming with CUDA

Ejemplos para el aprendizaje de Programación en Paralelo usando CUDA

La secuencia de estudio de de las prácticas está dada por el número en el nombre del directorio.

NOTA: Para trabajar en un proyecto se debe abrir Visual Studio Code en el directorio correspondiente.

## Estructura básica de un proyecto

La mayoría de proyectos tienen la siguiente estructura:

- README.md: Descripción del proyecto e instrucciones específicas para compilar/ejecutar.
- Directorio *include*, contiene definiciones de:
  - Encabezados de lenguaje C/C++ con extensión .h.
  - Encabezados de lenguaje C/C++ para CUDA con extensión .cuh.
- Directorio *src*, contiene definiciones de:
  - Código en lenguaje C/C++ con extensión .c o .cpp.
  - Código en lenguaje C/C++ para CUDA con extensión .cu.
- Archivo CMakeLists.txt: Archivo que contiene la configuración de cmake, que permite automatizar
  la creación de los proyectos para diferentes plataformas y entornos de desarrollo.

## Definiciones para código C/C++ o CUDA

Tanto en los archivos de encabezado (.cuh) y de código fuente (.cu), se deben incluir los
atributos adecuados a la definicióm de las funciones, de acuerdo con lo establecido en la
documentación oficial de CUDA.

La declaración y la definición de las funciones deben incluir una de las siguientes clave:
    - __host__: Código que se ejecuta en la CPU.
    - __global__: Código que se ejecuta en la GPU pero es invocado desde la CPU.
    - __device__: Código que se ejecuta en la GPU y es invocado por otro código en la GPU.
el proceso de compilación.

## Requisitos de software

En sistemas Windows:

- [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)
- [w64devkit](https://github.com/skeeto/w64devkit) Entorno de desarrollo para C/C++. Incluye algunas herramientas requeridas
  para realizar los procesos de compilación.
- [Visual Studio Community](https://visualstudio.microsoft.com/es/vs/community/)
- [Visual Studio Code](https://code.visualstudio.com/). Se debe instalar el meta paquete C/C++ Extension Pack de Microsoft,
  que incluye algunas extensiones necesarias para desarrollar en C/C++ y usar CMake.

En sistemas GNU/Linux:

- [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)
- [Visual Studio Code](https://code.visualstudio.com/)

## Referencias

- [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)
- [w64devkit](https://github.com/skeeto/w64devkit) Entorno de desarrollo para C/C++. Incluye algunas herramientas requeridas
  para realizar los procesos de compilación.
- [Visual Studio Community](https://visualstudio.microsoft.com/es/vs/community/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [W64DevKit - Portable C, C++, and Fortran Development Kit for x64 and x86 Windows](https://github.com/skeeto/w64devkit)
- [CMake - Build your world](https://cmake.org/)
- [CMake vs. Make: What's the Difference?](https://earthly.dev/blog/cmake-vs-make-diff/)
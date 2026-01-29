# Learning Parallel GPU computing

Ejemplos para el aprendizaje de Programación paralela en GPU

La secuencia de estudio de de las prácticas está dada por el número en el nombre del directorio.

NOTA: Para trabajar en un proyecto se debe abrir Visual Studio Code en el directorio correspondiente.

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

## Estructura básica de un proyecto

La mayoría de proyectos tienen la siguiente estructura:

```t
include/        # Cabeceras (.h, .cuh)
src/            # Código fuente (.cpp, .cu)
build/          # Directorio generado por CMake
CMakeLists.txt
.gitignore
Makefile
README.md
```

- Directorio *include*, contiene definiciones de:
  - Encabezados de lenguaje C/C++ con extensión .h.
  - Encabezados de lenguaje C/C++ para CUDA con extensión .cuh.
- Directorio *src*, contiene definiciones de:
  - Código en lenguaje C/C++ con extensión .c o .cpp.
  - Código en lenguaje C/C++ para CUDA con extensión .cu.
- Archivo CMakeLists.txt: Archivo que contiene la configuración de cmake,
    que permite automatizar   la creación de los proyectos para diferentes
    plataformas y entornos de desarrollo.
- Archivo .gitignore: Contiene los patrones de archivos/directorios que no
    se publican en el reposoitorio git.
- Archivo Makefile: Permite automatizar las tareas de compilación desde la
    línea de comandos.
- README.md: Descripción del proyecto e instrucciones específicas para
    compilar/ejecutar.

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

## Compilar manualmente - CMake (Debug)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cd build
cmake --build . --config Debug
```

## Compilar manualmente CMake (Release)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cd build
cmake --build . --config Release
```

## Limpiar la compilación

Para eliminar archivos ejecutables y de depuración, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```bash
cd build
cmake --build . --target clean
```

## Definiciones para código C/C++ o CUDA

Tanto en los archivos de encabezado (.cuh) y de código fuente (.cu), se deben incluir los
atributos adecuados a la definicióm de las funciones, de acuerdo con lo establecido en la
documentación oficial de CUDA.

La declaración y la definición de las funciones deben incluir una de las siguientes clave:
    - __host__: Código que se ejecuta en la CPU.
    - __global__: Código que se ejecuta en la GPU pero es invocado desde la CPU.
    - __device__: Código que se ejecuta en la GPU y es invocado por otro código en la GPU.
el proceso de compilación.

## Referencias

- [NVIDIA CUDA Toolkit](https://developer.nvidia.com/cuda-toolkit)
- [w64devkit](https://github.com/skeeto/w64devkit) Entorno de desarrollo para C/C++. Incluye algunas herramientas requeridas
  para realizar los procesos de compilación.
- [Visual Studio Community](https://visualstudio.microsoft.com/es/vs/community/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [W64DevKit - Portable C, C++, and Fortran Development Kit for x64 and x86 Windows](https://github.com/skeeto/w64devkit)
- [CMake - Build your world](https://cmake.org/)
- [CMake vs. Make: What's the Difference?](https://earthly.dev/blog/cmake-vs-make-diff/)

## Whitepapers de arquitecturas NVIDIA

- [NVIDIA Technologies](https://www.nvidia.com/en-us/technologies/)
- [WOLF Advanced Technology - NVIDIA GPU Architecture:
  From Turing to Blackwell](https://wolfadvancedtechnology.com/wp-content/uploads/2025/11/WOLF-NVIDIA-GPUTuring-to-Blackwell.pdf)
- [NVIDIA Blackwell](https://images.nvidia.com/aem-dam/Solutions/geforce/blackwell/nvidia-rtx-blackwell-gpu-architecture.pdf)
- [NVIDIA Ada](https://images.nvidia.com/aem-dam/Solutions/geforce/ada/nvidia-ada-gpu-architecture.pdf)
- [NVIDIA Ampere](https://www.nvidia.com/content/PDF/nvidia-ampere-ga-102-gpu-architecture-whitepaper-v2.pdf)
- [NVIDIA Turing](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf)

## Aviso de responsabilidad / disclaimer

El código de este repositorio se creó a partir del estudio y la experiencia obtenidas en programación de la GPU usando CUDA. Cualquier similitud con código existente es completamente circunstancial. Este código se proporcion TAL CUAL, sin ninguna garantía. Use el código bajo su entera responsabilidad. Las marcas comerciales mencionadas en este repositorio son propiedad de sus respectivos titulares.

The code in this repository was created from study and experience gained in GPU programming using CUDA. Any similarity to existing code is completely circumstantial. This code is provided AS IS, without any warranty. Use the code at your own risk.
Trademarks mentioned in this repository are the property of their respective owners.

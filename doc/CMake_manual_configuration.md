# Generar manualmente proyectos para diferentes entornos de desarrollo

La siguiente sección puede ser omitida si se planea usar Visual Studio Code, se incluye como
una información complementaria.

## Generar configuración para MinGW/MinGW64

Para compilar y ejecutar el código dentro de este proyecto, se debe realizar la siguiente secuencia:

Linux:

```sh
mkdir mingw-x64
cd mingw-x64
cmake -G "MinGW Makefiles" ..
```

Para compilar el proyecto, se usa el comando"

```sh
cd mingw-x64
make
```

## Generar el proyecto y la solución para Visual Studio

Para generar la configuración de Visual Studio 2022, se debe crear un directorio y generar los archivos de Visual Studio usando el CMakeLists.txt:

```sh
mkdir build
cd build
cmake -G "Visual Studio 17 2022" -A x64 ..
```

### Compilar usando Visual Studio

Luego de generar el proyecto y la solución de Visual Studio, se debe abrir el archivo .sln y compilar desde el entorno.

#### Compilar por línea de comandos

Para compilar por línea de comandos: se debe entrar al directorio que contiene la solución de Visual Studio y ejecutar cmake:

Versión Debug:

```sh
cd build
cmake --build . --config Debug
```

Versión Release:

```sh
cd build
cmake --build . --config Release
```

### Limpiar los archivos de compilación

Limpiar los archivos de Release:

```sh
cd build
cmake --build . --config Release --target clean
```

Limpiar los archivos de Debug:

```sh
cd build
cmake --build . --config Debug --target clean
```

## Referencias

- [W64DevKit - Portable C, C++, and Fortran Development Kit for x64 and x86 Windows](https://github.com/skeeto/w64devkit)
- [CMake - Build your world](https://cmake.org/)
- [CMake vs. Make: What's the Difference?](https://earthly.dev/blog/cmake-vs-make-diff/)

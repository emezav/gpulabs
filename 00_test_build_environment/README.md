# Proyecto inicial de CUDA

Este proyecto establece la estructura básica de un proyecto de desarrollo de C/C++ con CUDA.

## Compilar y ejecutar

Para compilar este proyecto, abrir en Visual Studio Code y usar el botón con el ícono "Play"
que se encuentra en la barra de acciones en el borde inferior del entorno.

## Compilar manualmente (Debug)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```sh
cd build
cmake --build . --config Debug
```

## Compilar manualmente (Release)

Para compilar manualmente, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```sh
cd build
cmake --build . --config Release
```

## Limpiar la compilación

Para eliminar archivos ejecutables y de depuración, se debe abrir una nueva terminal y ejecutar el siguiente comando:

```sh
cd build
cmake --build . --target clean
```
